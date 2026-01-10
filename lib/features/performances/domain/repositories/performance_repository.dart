import '../entities/performance.dart';

abstract class PerformanceRepository {
  Future<void> savePerformances(List<Performance> performances);
  Future<List<Performance>> getPerformancesByMatch(int matchId);
  Future<List<Performance>> getPerformancesByPlayer(int playerId);
}
