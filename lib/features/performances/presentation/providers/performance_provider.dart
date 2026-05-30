import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/match_detail_stat.dart';
import '../../../../core/providers/repository_providers.dart';

// Stats Provider
final matchStatsProvider = FutureProvider.family<List<MatchDetailStat>, int>((
  ref,
  matchId,
) async {
  final repository = ref.watch(performanceRepositoryProvider);
  return repository.getMatchStats(matchId);
});
