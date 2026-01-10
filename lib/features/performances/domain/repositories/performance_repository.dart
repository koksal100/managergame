import '../entities/performance.dart';
import '../entities/player_stat.dart';
import '../entities/match_detail_stat.dart';

abstract class PerformanceRepository {
  Future<void> savePerformances(List<Performance> performances);
  Future<List<Performance>> getPerformancesByMatch(int matchId);
  Future<List<MatchDetailStat>> getMatchStats(int matchId);
  Future<List<Performance>> getPerformancesByPlayer(int playerId);
  
  // Stats
  Future<List<PlayerStat>> getTopScorers(int leagueId, {int limit = 10});
  Future<List<PlayerStat>> getTopAssisters(int leagueId, {int limit = 10});
  Future<List<PlayerStat>> getTopRated(int leagueId, {int limit = 10});
}
