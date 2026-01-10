
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/standings_service.dart';
import '../../../../core/providers/repository_providers.dart';

import '../../../performances/domain/entities/player_stat.dart';

final standingsServiceProvider = Provider<StandingsService>((ref) {
  return StandingsService(
    ref.watch(clubRepositoryProvider),
    ref.watch(matchRepositoryProvider),
    ref.watch(performanceRepositoryProvider),
  );
});

final standingsProvider = FutureProvider.family<List<LeagueStanding>, int>((ref, leagueId) async {
  final service = ref.watch(standingsServiceProvider);
  return service.getStandings(leagueId);
});

final topScorersProvider = FutureProvider.family<List<PlayerStat>, int>((ref, leagueId) async {
  final service = ref.watch(standingsServiceProvider);
  return service.getTopScorers(leagueId);
});

final topAssistersProvider = FutureProvider.family<List<PlayerStat>, int>((ref, leagueId) async {
  final service = ref.watch(standingsServiceProvider);
  return service.getTopAssisters(leagueId);
});

final topRatedProvider = FutureProvider.family<List<PlayerStat>, int>((ref, leagueId) async {
  final service = ref.watch(standingsServiceProvider);
  return service.getTopRated(leagueId);
});
