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

      // G. PİYASA DEĞERİ HESAPLAMA
      int marketValue = _calculateMarketValue(ca, age, position.shortName);

      // --- MODEL SONU ---

      final playerId = await database.into(database.players).insert(
        PlayersCompanion(
          name: Value('$firstName $lastName'),
          age: Value(age),
          position: Value(position.shortName),
          clubId: Value(clubId),
          ca: Value(ca),
          pa: Value(pa),
          reputation: Value(ca),
          marketValue: Value(marketValue),
        ),
      );

      // Value History (Initial)
      await database.into(database.valueHistories).insert(
        ValueHistoriesCompanion(
          playerId: Value(playerId),
          date: Value(DateTime.now()),
          value: Value(marketValue.toDouble()),
        ),
      );
    }
  }

  int _calculateMarketValue(int ca, int age, String position) {
    // Base Values for key CA milestones (approximate)
    // CA 60 -> 50k
    // CA 70 -> 500k
    // CA 80 -> 5M
    // CA 90 -> 30M
    // CA 100 -> 100M+

    double baseValue = 0;
    if (ca < 60) {
      baseValue = 10000.0 * pow(1.05, (ca - 40));
    } else if (ca < 70) {
      baseValue = 50000.0 * pow(1.25, (ca - 60));
    } else if (ca < 80) {
      baseValue = 500000.0 * pow(1.25, (ca - 70));
    } else if (ca < 90) {
      baseValue = 5000000.0 * pow(1.20, (ca - 80));
    } else {
      baseValue = 30000000.0 * pow(1.15, (ca - 90));
    }

    // Age Multiplier (Young players worth more)
    double ageMultiplier = 1.0;
    if (age <= 21) {
      ageMultiplier = 1.5;
    } else if (age <= 24) {
      ageMultiplier = 1.2;
    } else if (age >= 30) {
      ageMultiplier = 0.7;
    } else if (age >= 33) {
      ageMultiplier = 0.4;
    }

    // Position Multiplier (Attackers usually worth more)
    double posMultiplier = 1.0;
    if (['ST', 'FWD', 'AML', 'AMR', 'AMC'].contains(position)) {
      posMultiplier = 1.2; // Forward/Attacker premium
    } else if (['GK'].contains(position)) {
      posMultiplier = 0.8; // GK discount
    }

    double finalValue = baseValue * ageMultiplier * posMultiplier;

    // Rounding logic for cleaner numbers
    if (finalValue < 1000000) {
      return (finalValue / 1000).round() * 1000;
    } else {
      return (finalValue / 10000).round() * 10000;
    }
  }

  Future<void> seedFixtures() async {
    final fixtureJson = await _loadJson('assets/data/fixture.json');
    final Map<String, dynamic> fixtureData = fixtureJson as Map<String, dynamic>;

    // Build Cache
    final clubs = await database.select(database.clubs).get();
    final clubCache = {for (var c in clubs) c.name: c.id};

    for (var weekStr in fixtureData.keys) {
        final week = int.tryParse(weekStr) ?? 0;
        if (week == 0) continue;

        // Check if week is seeded
        final existingMatches = await (database.select(database.matches)..where((tbl) => tbl.week.equals(week))).get();
        if (existingMatches.isNotEmpty) {
           // Assume seeded or played
           continue; 
        }

        final weekData = fixtureData[weekStr];
        if (weekData['type'] == 'Match Week' || weekData['type'] == 'League Match') {
             final matchesMap = weekData['matches'] as Map<String, dynamic>;
             
             List<MatchesCompanion> newMatches = [];
             for (var leagueName in matchesMap.keys) {
                 final matches = matchesMap[leagueName] as List;
                 for (var m in matches) {
                     final homeName = m['home'];
                     final awayName = m['away'];
                     final homeId = clubCache[homeName];
                     final awayId = clubCache[awayName];

                     if (homeId != null && awayId != null) {
                        newMatches.add(MatchesCompanion(
                           homeClubId: Value(homeId),
                           awayClubId: Value(awayId),
                           season: Value(1), // Default Season 1
                           week: Value(week),
                           isPlayed: Value(false),
                           homeScore: const Value(null),
                           awayScore: const Value(null),
                        ));
                     }
                 }
             }

             if (newMatches.isNotEmpty) {
               await database.batch((batch) {
                 batch.insertAll(database.matches, newMatches);
               });
             }
        }
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
