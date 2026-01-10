import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/match_detail_stat.dart';
import '../../domain/repositories/performance_repository.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../performances/data/repositories/performance_repository_impl.dart';

// Service/Repository Provider
final performanceRepositoryProvider = Provider<PerformanceRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return PerformanceRepositoryImpl(database);
});

// Stats Provider
final matchStatsProvider = FutureProvider.family<List<MatchDetailStat>, int>((ref, matchId) async {
  final repository = ref.watch(performanceRepositoryProvider);
  return repository.getMatchStats(matchId);
});
