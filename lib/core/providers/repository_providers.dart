import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database_provider.dart';

// Repositories
import '../../features/clubs/data/repositories/club_repository_impl.dart';
import '../../features/clubs/domain/repositories/club_repository.dart';
import '../../features/players/data/repositories/player_repository_impl.dart';
import '../../features/players/domain/repositories/player_repository.dart';
import '../../features/matches/data/repositories/match_repository_impl.dart';
import '../../features/matches/domain/repositories/match_repository.dart';
import '../../features/performances/data/repositories/performance_repository_impl.dart';
import '../../features/performances/domain/repositories/performance_repository.dart';

final clubRepositoryProvider = Provider<ClubRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ClubRepositoryImpl(db);
});

final playerRepositoryProvider = Provider<PlayerRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return PlayerRepositoryImpl(db);
});

final matchRepositoryProvider = Provider<MatchRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return MatchRepositoryImpl(db);
});

final performanceRepositoryProvider = Provider<PerformanceRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return PerformanceRepositoryImpl(db);
});
