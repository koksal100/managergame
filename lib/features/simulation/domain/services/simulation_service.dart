import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

import '../../../matches/domain/entities/match.dart';
import '../../../matches/domain/repositories/match_repository.dart';
import '../../../performances/domain/entities/performance.dart';
import '../../../performances/domain/repositories/performance_repository.dart';
import '../../../clubs/domain/repositories/club_repository.dart';
import '../../../players/domain/repositories/player_repository.dart';

class SimulationService {
  final MatchRepository _matchRepository;
  final PerformanceRepository _performanceRepository;
  final ClubRepository _clubRepository; // Need to fetch clubs to map Name -> ID
  final PlayerRepository _playerRepository; // Need to fetch players for stats

  Map<String, dynamic>? _fixtureData;
  Map<String, int>? _clubIdCache;

  SimulationService({
    required MatchRepository matchRepository,
    required PerformanceRepository performanceRepository,
    required ClubRepository clubRepository,
    required PlayerRepository playerRepository,
  })  : _matchRepository = matchRepository,
        _performanceRepository = performanceRepository,
        _clubRepository = clubRepository,
        _playerRepository = playerRepository;

  Future<void> _loadFixtureIfNeeded() async {
    if (_fixtureData != null) return;
    final jsonString = await rootBundle.loadString('assets/data/fixture.json');
    _fixtureData = json.decode(jsonString);
  }

  Future<void> _buildClubIdCacheIfNeeded() async {
    if (_clubIdCache != null) return;
    _clubIdCache = {};
    
    // Fetch all clubs to build cache
    final result = await _clubRepository.getClubs();
    result.fold(
      (failure) => print("Error fetching clubs: $failure"),
      (clubs) {
        for (var club in clubs) {
          _clubIdCache![club.name] = club.id;
        }
      },
    );
  }
  
  Future<int?> _getClubId(String teamName) async {
    // 1. Check Cache
    if (_clubIdCache != null && _clubIdCache!.containsKey(teamName)) {
      return _clubIdCache![teamName];
    }
    
    // 2. Fetch if missing
    final result = await _clubRepository.searchClubs(teamName);
    return result.fold(
      (failure) {
        print("Error searching club $teamName: $failure");
        return null;
      },
      (clubs) {
        if (clubs.isNotEmpty) {
           // Exact match check
           final club = clubs.firstWhere((c) => c.name == teamName, orElse: () => clubs.first);
           if (_clubIdCache != null) _clubIdCache![teamName] = club.id;
           return club.id;
        }
        return null;
      },
    );
  }

  Future<void> simulateWeek(int season, int week) async {
    await _loadFixtureIfNeeded();
    await _buildClubIdCacheIfNeeded();
    
    final weekKey = week.toString();
    if (_fixtureData == null || !_fixtureData!.containsKey(weekKey)) {
        print("Week $week not found in fixture.");
        return;
    }

    final weekData = _fixtureData![weekKey];
    final type = weekData['type'];

    if (type == "Match Week" || type == "League Match") {
        await _simulateMatches(season, week, weekData['matches']);
    } else {
        print("Week $week is $type. Skipping simulation.");
    }
  }

  Future<void> _simulateMatches(int season, int week, Map<String, dynamic> leagueMatches) async {
    print("--- START SIMULATION: Season $season, Week $week ---");
    final random = Random();

    // Step 1: Prepare Match objects
    List<Match> preparedMatches = [];
    print("Leagues with matches this week: ${leagueMatches.keys.toList()}");

    for (final leagueName in leagueMatches.keys) {
         final matches = List<Map<String, dynamic>>.from(leagueMatches[leagueName]);
         print(">> Processing $leagueName: ${matches.length} matches.");

         for (final matchPair in matches) {
             final homeTeamName = matchPair['home'];
             final awayTeamName = matchPair['away'];

             final homeId = await _getClubId(homeTeamName);
             final awayId = await _getClubId(awayTeamName);

             if (homeId != null && awayId != null) {
                 // print("   -> Simulating: $homeTeamName vs $awayTeamName");
                 preparedMatches.add(Match(
                     id: 0,
                     homeClubId: homeId,
                     awayClubId: awayId,
                     homeScore: _simulateScore(random),
                     awayScore: _simulateScore(random),
                     season: season,
                     week: week,
                     isPlayed: true
                 ));
             } else {
               print("!!! SKIPPING MATCH: $homeTeamName vs $awayTeamName (Club ID not found)");
             }
         }
    }
    
    print("Total Matches Prepared: ${preparedMatches.length}");

    // Step 2: Batch Save Matches
    await _matchRepository.saveMatches(preparedMatches);
    print("Matches Saved to Database.");
    
    // Step 3: Fetch Back Matches (to get IDs)
    final savedMatches = await _matchRepository.getMatchesByWeek(season, week);
    print("Fetched back ${savedMatches.length} matches from DB (Verification).");
    
    // Step 4: Generate Performances
    List<Performance> preparedPerformances = [];
    
    for (final match in savedMatches) {
        // Generate stats for Home Team
        final homePlayers = await _getBest11(match.homeClubId);
        _distributeStats(preparedPerformances, homePlayers, match.id, match.homeScore!, random);
        
        // Generate stats for Away Team
        final awayPlayers = await _getBest11(match.awayClubId);
        _distributeStats(preparedPerformances, awayPlayers, match.id, match.awayScore!, random);
    }
    
    // Step 5: Batch Save Performances
    await _performanceRepository.savePerformances(preparedPerformances);
    print("Performances Saved. Simulation Complete for Week $week.");
  }

  void _distributeStats(List<Performance> performances, List<dynamic> players, int matchId, int teamGoals, Random r) {
      // Create a map to track goals per player temporarily
      Map<int, int> playerGoals = {for (var p in players) p.id: 0};
      
      // Distribute goals randomly
      for (int i = 0; i < teamGoals; i++) {
          if (players.isEmpty) break;
          // Weighted random could be better (strikers score more), but uniform is OK for now.
          final scorer = players[r.nextInt(players.length)];
          playerGoals[scorer.id] = playerGoals[scorer.id]! + 1;
      }

      for (var player in players) {
          performances.add(Performance(
              id: 0,
              matchId: matchId,
              playerId: player.id,
              minutesPlayed: 90,
              goals: playerGoals[player.id]!,
              assists: 0,
              yellowCards: r.nextInt(20) == 0 ? 1 : 0, 
              redCards: 0,
              rating: 6.0 + r.nextDouble() * 4.0 + (playerGoals[player.id]! * 0.5), 
          ));
      }
  }

  int _simulateScore(Random r) {
    // Weights: 0 (30%), 1 (30%), 2 (20%), 3 (10%), 4+ (10%)
    final roll = r.nextInt(100);
    if (roll < 30) return 0;
    if (roll < 60) return 1;
    if (roll < 80) return 2;
    if (roll < 90) return 3;
    return 3 + r.nextInt(3); 
  }
  
  Future<List<dynamic>> _getBest11(int clubId) async {
     final result = await _playerRepository.getPlayersByClubId(clubId);
     return result.fold(
       (failure) => [],
       (players) {
          // Sort by CA (Current Ability) descending
          // Assuming implementation already sorts by CA (checking PlayerRepositoryImpl: yes strictly creates secondary sort by CA)
          // But to be sure:
          players.sort((a, b) => b.ca.compareTo(a.ca));
          return players.take(11).toList();
       }
     );
  }
}
