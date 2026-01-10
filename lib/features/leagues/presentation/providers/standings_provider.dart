
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/standings_service.dart';
import '../../../../core/providers/repository_providers.dart';

final standingsServiceProvider = Provider<StandingsService>((ref) {
  return StandingsService(
    ref.watch(clubRepositoryProvider),
    ref.watch(matchRepositoryProvider),
  );
});

final standingsProvider = FutureProvider.family<List<LeagueStanding>, int>((ref, leagueId) async {
  final service = ref.watch(standingsServiceProvider);
  return service.getStandings(leagueId);
});
