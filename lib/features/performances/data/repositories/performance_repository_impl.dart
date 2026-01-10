import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/performance.dart' as domain;
import '../../domain/repositories/performance_repository.dart';

class PerformanceRepositoryImpl implements PerformanceRepository {
  final AppDatabase _database;

  PerformanceRepositoryImpl(this._database);

  @override
  Future<void> savePerformances(List<domain.Performance> performances) async {
    await _database.batch((batch) {
      batch.insertAll(
        _database.performances,
        performances.map((p) => PerformancesCompanion(
          matchId: Value(p.matchId),
          playerId: Value(p.playerId),
          minutesPlayed: Value(p.minutesPlayed),
          goals: Value(p.goals),
          assists: Value(p.assists),
          yellowCards: Value(p.yellowCards),
          redCards: Value(p.redCards),
          rating: Value(p.rating),
        )),
      );
    });
  }

  @override
  Future<List<domain.Performance>> getPerformancesByMatch(int matchId) async {
    final query = _database.select(_database.performances)
      ..where((t) => t.matchId.equals(matchId));
      
    final result = await query.get();
    
    return result.map((row) => domain.Performance(
      id: row.id,
      matchId: row.matchId,
      playerId: row.playerId,
      minutesPlayed: row.minutesPlayed,
      goals: row.goals,
      assists: row.assists,
      yellowCards: row.yellowCards,
      redCards: row.redCards,
      rating: row.rating,
    )).toList();
  }

  @override
  Future<List<domain.Performance>> getPerformancesByPlayer(int playerId) async {
    final query = _database.select(_database.performances)
      ..where((t) => t.playerId.equals(playerId));
      
    final result = await query.get();
    
    return result.map((row) => domain.Performance(
      id: row.id,
      matchId: row.matchId,
      playerId: row.playerId,
      minutesPlayed: row.minutesPlayed,
      goals: row.goals,
      assists: row.assists,
      yellowCards: row.yellowCards,
      redCards: row.redCards,
      rating: row.rating,
    )).toList();
  }
}
