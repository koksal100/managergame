# Transfer Sistemi Detaylı Dokümantasyonu

Bu belge, **Manager Game** projesindeki yapay zeka tabanlı transfer motorunun (`TransferEngine`) çalışma prensiplerini, algoritmalarını ve teknik mimarisini derinlemesine açıklar.

---

## 1. Oyun Dünyası ve Kurallar (Gameplay Logic)

Transfer sistemi, oyunun en dinamik ve kaotik parçasıdır. Sezonun belirli dönemlerinde çalışır ve binlerce kulübün yaşayan bir ekosistem gibi davranmasını sağlar.

### 1.1. Transfer Takvimi
Oyun takvimi "Hafta" bazlı ilerler.
*   **Yaz Transfer Dönemi:** 1. Hafta açılır, 8. Hafta kapanır. (Sezon Başı)
*   **Kış Transfer Dönemi:** 29. Hafta açılır, 32. Hafta kapanır. (Devre Arası)
*   *Teknik Detay:* `TransferEngine.isTransferWindow(week)` fonksiyonu bu kontrolü sağlar.

### 1.2. Kulüp Zekası: İhtiyaç Analizi (Needs Analysis)
Her transfer dönemi başında (`generateAllClubNeeds`), her kulüp kendi kadrosunu analiz eder ve bir strateji belirler.

*   **Zayıf Halka Tespiti (Buy Strategy):**
    *   Kadro 4 bölgeye ayrılır: GK, DEF, MID, FWD.
    *   Her bölgedeki oyuncuların ortalama yeteneği (CA - Current Ability) hesaplanır.
    *   En düşük ortalamaya sahip bölge "Hedef Mevki" olarak belirlenir.
    *   **Bütçe:** Kulüp, mevcut transfer bütçesinin %50'sini bu transfer için ayırır.
    *   **Hedef:** Mevcut ortalamanın üzerinde güce sahip (Minimum CA) ve 18-32 yaş arası bir oyuncu aranır.

*   **Kadro Temizliği (Sell Strategy):**
    *   Eğer kadroda 20'den fazla oyuncu varsa, kulüp küçülmeye gider.
    *   Kadro CA puanına göre sıralanır ve en zayıf oyuncu seçilir.
    *   Bu oyuncu "Satılık Listesi"ne (`TransferNeeds` tablosuna `type='sell'` ile) eklenir.
    *   **Fiyat:** Piyasa değerinin %70'i "Minimum Bonservis" olarak belirlenir.

### 1.3. Teklif Oluşturma Algoritması (Offer Generation)
Simülasyonun her adımında (`processOfferCreation`), alıcı kulüpler aktif olarak oyuncu arar.

#### Adım 1: Geçmiş Transfer Kontrolü (The "One-Move" Rule)
Sistem, oyuncuların "gezgin" olmasını engellemek için katı bir kural uygular:
> **Kural:** Bir oyuncu aynı transfer döneminde sadece 1 kez transfer olabilir.
*   Motor, o dönem içinde (`status='accepted'`) statüsüne sahip tüm transferleri tarar.
*   Bu oyuncular "Yasaklı Listesi"ne alınır ve ne listeden ne de havuzdan onlara teklif yapılamaz.

#### Adım 2: Pazar Araştırması (Market Search)
Alıcı kulüp şu sırayla arama yapar:

1.  **Satılık Listesi (Primary Market):**
    *   Önce diğer kulüplerin satılığa çıkardığı oyunculara (`SellNeeds`) bakılır.
    *   Kriterler: Mevki, Yaş, Yetenek (CA) ve Bütçe uyumu.
    *   *Avantaj:* Satılık listedeki oyuncular daha ucuza (piyasa değerinin %70'i civarı) alınabilir.

2.  **Genel Oyuncu Havuzu (Secondary/Unlisted Market):**
    *   Eğer listede kriterlere uygun oyuncu yoksa, kulüp ligdeki diğer takımların kadrolarına göz diker.
    *   *Fiyat Politikası:* Satılık olmayan bir oyuncuyu almak zordur. Bu yüzden kulüp, oyuncunun piyasa değerinin **%20 fazlasını** (Premium Offer) teklif eder.
    *   Bütçe yeterliyse teklif yapılır.

### 1.4. İmza Aşaması: Tekliflerin Değerlendirilmesi
Hafta biterken (`evaluateOffers`), satıcı kulüpler masadaki teklifleri inceler.

*   **Rekabet (Bidding War):** Bir oyuncuya 3 farklı kulüp teklif yapmış olabilir.
*   **En İyinin Seçimi:** Satıcı kulüp, teklifleri ücretlerine göre sıralar (`OfferAmount DESC`) ve sadece en yüksek teklifi dikkate alır.
*   **Karar Mekanizması:**
    *   *Listelenmiş Oyuncuysa:* Teklif, belirlenen "Minimum Bonservis" bedelini karşılıyor mu? (Evet -> Kabul)
    *   *Listelenmemiş Oyuncuysa:* Teklif çok cazip mi? (Piyasa değerinin %90'ı ve üstü). Eğer öyleyse bile %50 şansla kabul edilir (`Random`).

---

## 2. Teknik Mimari ve Optimizasyon (Technical Architecture)

Oyunun akıcılığını bozmadan binlerce transfer kararını saniyeler içinde vermek için ciddi optimizasyonlar yapılmıştır.

### 2.1. Veri Yapısı (Drift / SQLite)
3 Temel tablo üzerine kuruludur:

1.  **TransferNeeds:**
    *   `type`: 'buy' veya 'sell'.
    *   `isFulfilled`: İhtiyaç karşılandı mı? (Sorgularda `false` olanlar çekilir).
    *   Bu tablo, AI'nın "Niyet Belgesi"dir.

2.  **TransferOffers:**
    *   `status`: 'pending', 'accepted', 'rejected'.
    *   `offerAmount`, `contractYears`, `week`: Teklif detayları.
    *   `needId`: Hangi alım ihtiyacına binaen yapıldığı (Traceability).

3.  **Transfers:**
    *   Sadece bitmiş, resmiyete dökülmüş transferlerin logudur (Tarihçe).

### 2.2. Performans Optimizasyonu: Batch Processing
Klasik "Döngü içinde veritabanı sorgusu" (`N+1` problemi) simülasyonu dakikalarca kilitleyebilir. Bunu önlemek için **"Hepsini Çek, Hafızada İşle"** ("Fetch All, Process In-Memory") yöntemi uygulanır.

1.  **Toplu Veri Çekme:**
    *   Tüm açık ALIM ihtiyaçları (`BuyNeeds`) çekilir.
    *   Tüm açık SATIM ihtiyaçları (`SellNeeds`) çekilir.
    *   Bu ihtiyaçlarla ilgili TÜM oyuncular tek bir `WHERE id IN (...)` sorgusuyla çekilir ve bir `Map<int, Player>` (Hash Map) içine atılır.

2.  **In-Memory Matching:**
    *   Dart tarafında, veritabanına gitmeden `Map` üzerinden eşleşmeler yapılır.
    *   Maliyetli SQL JOIN işlemleri yerine RAM üzerinde referans kontrolü yapılır.
    *   Sonuç: 50 saniyelik işlem süresi **1 saniyenin altına** düşürülmüştür.

### 2.3. Race Condition & Safety Checks
Simülasyon hızlı aktığı için (veya asenkron işlemlerden dolayı), bir oyuncu aynı anda iki takıma satılmaya çalışılabilir.

*   **Sorun:** Ali için A ve B takımı teklif yaptı. A'nın teklifi kabul edildi, oyuncu A'ya geçti. B'nin teklifi işlenirken oyuncu hala eski takımında sanılabilir.
*   **Çözüm (The Safety Check):** `_finalizeTransfer` çağrılmadan hemen önce, kritik bir sorgu atılır:
    ```dart
    // Oyuncu ŞU AN, GERÇEKTEN teklifin yapıldığı kulüpte mi?
    if (player.clubId != offer.toClubId) { 
       abort(); // İşlem iptal, teklifler red.
    }
    ```
*   Bu sayede mükerrer satışlar ve veri tutarsızlıkları %100 engellenir.

### 2.4. Çöp Toplama (Garbage Collection)
Bir transfer penceresi kapandığında (`clearTransferNeeds`), veritabanında şişkinlik yaratmamak için tüm `TransferNeeds` kayıtları silinir. `Make clean` mantığıyla yeni döneme temiz başlanır.
