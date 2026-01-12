import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../../core/providers/game_date_provider.dart';
import '../../../../core/providers/repository_providers.dart';
import '../../../players/domain/services/player_growth_service.dart';
import '../../domain/services/simulation_service.dart';
import '../../../office/providers/office_provider.dart';
import '../../../agents/providers/agent_provider.dart';

final simulationServiceProvider = Provider<SimulationService>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return SimulationService(
    matchRepository: ref.watch(matchRepositoryProvider),
    performanceRepository: ref.watch(performanceRepositoryProvider),
    clubRepository: ref.watch(clubRepositoryProvider),
    playerRepository: ref.watch(playerRepositoryProvider),
    playerGrowthService: PlayerGrowthService(database),
    officeRepository: ref.watch(officeRepositoryProvider),
    agentRepository: ref.watch(agentRepositoryProvider),
  );
});

final tickerMatchesProvider = FutureProvider<List<String>>((ref) async {
  final currentGameTime = ref.watch(gameDateProvider);
  final currentWeek = currentGameTime.week;
  // Fetch from previous week if possible, ensuring we show results of just played matches
  final targetWeek = currentWeek > 1 ? currentWeek - 1 : 1;
  
  final matchRepo = ref.watch(matchRepositoryProvider);
  final allMatches = await matchRepo.getMatchesByWeek(1, targetWeek); 
  
  // Filter played
  final playedMatches = allMatches.where((m) => m.isPlayed).toList();
  
  if (playedMatches.isEmpty) return [];
  
  // Shuffle and take 20
  playedMatches.shuffle();
  final selected = playedMatches.take(20).toList();
  
  final clubRepo = ref.watch(clubRepositoryProvider);
  final clubsResult = await clubRepo.getClubs();
  
  // Map ID -> Name
  final clubsMap = clubsResult.fold(
      (l) => <int, String>{}, 
      (r) => {for (var c in r) c.id: c.name}
  );
  
  return selected.map((m) {
      final homeName = clubsMap[m.homeClubId] ?? '?';
      final awayName = clubsMap[m.awayClubId] ?? '?';
      return '${homeName.toUpperCase()} ${m.homeScore}-${m.awayScore} ${awayName.toUpperCase()}';
  }).toList();
});
