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
    final availableCountries = names.countries.keys.toList();

    for (int i = 0; i < count; i++) {
      // 1. Determine Nationality
      // 80% chance -> Club's Country
      // 20% chance -> Random Country from all seeded countries
      String playerNationality = clubCountryName;
      if (_random.nextInt(100) >= 80) {
        // Pick a random country from the list of ALL countries we know about
        playerNationality = allCountries[_random.nextInt(allCountries.length)].name;
      }

      // 2. Resolve Name Source (Metadata Lookyp)
      // Find the CountryDTO for the chosen nationality to get its nameSource
      final countryDto = allCountries.firstWhere(
        (c) => c.name == playerNationality, 
        orElse: () => CountryDTO(name: playerNationality, code: 'XX', reputation: 0, nameSource: playerNationality)
      );
      
      String nameSource = countryDto.nameSource;

      // Fallback: If the resolved source isn't in our names.json, default to England
      if (!names.countries.containsKey(nameSource)) {
         nameSource = 'England'; 
      }

      final nameSet = names.countries[nameSource]!;

      // 3. Generate Attributes
      final baseAttribute = club.reputation;
      final ca = (baseAttribute + _random.nextInt(15) - 7).clamp(1, 100);
      final pa = (ca + _random.nextInt(20)).clamp(1, 100);
      final age = 16 + _random.nextInt(20); 

      final firstName = nameSet.names[_random.nextInt(nameSet.names.length)];
      final lastName = nameSet.surnames[_random.nextInt(nameSet.surnames.length)];

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

}
