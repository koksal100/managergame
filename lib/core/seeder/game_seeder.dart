import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../../features/players/domain/enums/player_position.dart';
import 'dtos.dart';

class GameSeeder {
  final AppDatabase database;
  final Random _random = Random();

  GameSeeder(this.database);

  Future<void> seed() async {
    // 1. Load JSONs
    final countriesJson = await _loadJson('assets/data/countries.json');
    final leaguesJson = await _loadJson('assets/data/leagues.json');
    final teamsJson = await _loadJson('assets/data/teams.json');
    final namesJson = await _loadJson('assets/data/names.json');

    final countryDTOs = (countriesJson as List).map((e) => CountryDTO.fromJson(e)).toList();
    final leagueDTOs = (leaguesJson as List).map((e) => LeagueDTO.fromJson(e)).toList();
    final teamDTOs = (teamsJson as List).map((e) => TeamDTO.fromJson(e)).toList();
    final namesDTO = NamesDTO.fromJson(namesJson);

    // 2. Seed Countries
    await _seedCountries(countryDTOs);

    // 3. Seed Leagues and Clubs
    await _seedLeaguesAndClubs(leagueDTOs, teamDTOs, namesDTO, countryDTOs);
  }

  Future<dynamic> _loadJson(String path) async {
    final String response = await rootBundle.loadString(path);
    return json.decode(response);
  }

  Future<void> _seedCountries(List<CountryDTO> dtos) async {
    for (var dto in dtos) {
      await database.into(database.countries).insert(
        CountriesCompanion(
          name: Value(dto.name),
          code: Value(dto.code),
          reputation: Value(dto.reputation),
        ),
      );
    }
  }

  Future<void> _seedLeaguesAndClubs(
    List<LeagueDTO> leagues, 
    List<TeamDTO> teams, 
    NamesDTO names,
    List<CountryDTO> countries
  ) async {
    for (var leagueDto in leagues) {
      // Find Country ID
      final country = await (database.select(database.countries)..where((tbl) => tbl.name.equals(leagueDto.nationality))).getSingleOrNull();
      
      if (country != null) {
        // Create League
        final leagueId = await database.into(database.leagues).insert(
          LeaguesCompanion(
            name: Value(leagueDto.name),
            countryId: Value(country.id),
            reputation: Value(leagueDto.reputation),
          ),
        );

        // Create Clubs for this League
        for (var teamName in leagueDto.teamNames) {
          // Find matching team details or use default
          var teamDetail = teams.firstWhere(
            (t) => t.name == teamName,
            orElse: () => TeamDTO(
              name: teamName, 
              reputation: (leagueDto.reputation * 0.9).toInt(), 
              wageBudget: 10000000, 
              transferBudget: 5000000
            ),
          );

          final clubId = await database.into(database.clubs).insert(
            ClubsCompanion(
              name: Value(teamDetail.name),
              leagueId: Value(leagueId),
              reputation: Value(teamDetail.reputation),
              wageBudget: Value(teamDetail.wageBudget),
              transferBudget: Value(teamDetail.transferBudget),
            ),
          );

          // Generate Players
          await _generatePlayersForClub(clubId, teamDetail, names, country.name, countries);
        }
      }
    }
  }

  // Obsolete map removed

  Future<void> _generatePlayersForClub(
    int clubId, 
    TeamDTO club, 
    NamesDTO names, 
    String countryName,
    List<CountryDTO> allCountries
  ) async {
    // 25 Players total
    await _createPlayers(clubId, club, PlayerPosition.goalkeeper, 3, names, countryName, allCountries);
    await _createPlayers(clubId, club, PlayerPosition.defender, 8, names, countryName, allCountries);
    await _createPlayers(clubId, club, PlayerPosition.midfielder, 8, names, countryName, allCountries);
    await _createPlayers(clubId, club, PlayerPosition.forward, 6, names, countryName, allCountries);
  }

  Future<void> _createPlayers(
      int clubId,
      TeamDTO club,
      PlayerPosition position,
      int count,
      NamesDTO names,
      String clubCountryName,
      List<CountryDTO> allCountries
      ) async {

    for (int i = 0; i < count; i++) {
      // 1. Nationality Logic
      String playerNationality = clubCountryName;
      if (_random.nextInt(100) >= 80) {
        playerNationality = allCountries[_random.nextInt(allCountries.length)].name;
      }

      // 2. Name Logic
      final countryDto = allCountries.firstWhere(
              (c) => c.name == playerNationality,
          orElse: () => CountryDTO(name: playerNationality, code: 'XX', reputation: 0, nameSource: playerNationality)
      );

      String nameSource = countryDto.nameSource;
      if (!names.countries.containsKey(nameSource)) {
        nameSource = 'England';
      }

      final nameSet = names.countries[nameSource]!;
      final firstName = nameSet.names[_random.nextInt(nameSet.names.length)];
      final lastName = nameSet.surnames[_random.nextInt(nameSet.surnames.length)];

      // --- 3. GÜNCELLENMİŞ MATEMATİKSEL MODEL ---

      // A. YAŞ (16 - 38)
      final age = 16 + _random.nextInt(23);

      // B. YENİ DİNAMİK ORTALAMA (Dynamic Mean)
      // Kulüp Gücü 57 ise -> Ortalama 60 olsun.
      // Kulüp Gücü 96 ise -> Ortalama 85 olsun.
      // Aradaki fark: 39 puanlık kulüp gücü farkı, 25 puanlık ortalama farkına denk geliyor.
      double clubPower = club.reputation.toDouble().clamp(57.0, 96.0);

      // FORMÜL: Başlangıç (60) + (KulüpGücüFarkı * (HedefAralık / KaynakAralık))
      double dynamicMean = 60.0 + (clubPower - 57.0) * (25.0 / 55.0);

      // C. GAUSS DAĞILIMI
      // Standart sapmayı 6.5'te tutuyoruz.
      double baseOvr = _nextGaussian(dynamicMean, 6.5);

      // D. YAŞ PENALTISI
      // (Yaş - 27)^2 / 22
      double distFromPrime = (age - 27).abs().toDouble();
      double agePenalty = (distFromPrime * distFromPrime) / 22.0;

      // E. CA HESAPLAMA
      int rawCa = (baseOvr - agePenalty).round();

      // Alt limiti 57, üst limiti 96 ile sınırlıyoruz.
      int ca = rawCa.clamp(57, 96);

      // F. PA HESAPLAMA
      int potentialBonus = 0;
      if (age < 29) {
        // Genç oyunculara bonus potansiyel
        potentialBonus = _random.nextInt(30 - (age - 16));
      }
      int pa = (ca + potentialBonus).clamp(ca, 99);

      // --- MODEL SONU ---

      await database.into(database.players).insert(
        PlayersCompanion(
          name: Value('$firstName $lastName'),
          age: Value(age),
          position: Value(position.shortName),
          clubId: Value(clubId),
          ca: Value(ca),
          pa: Value(pa),
          reputation: Value(ca),
        ),
      );
    }
  }

// Yardımcı Fonksiyon (Aynı kalacak)
  double _nextGaussian(double mean, double stdDev) {
    var u1 = 1.0 - _random.nextDouble();
    var u2 = 1.0 - _random.nextDouble();
    var randStdNormal = sqrt(-2.0 * log(u1)) * sin(2.0 * pi * u2);
    return mean + stdDev * randStdNormal;
  }

}
