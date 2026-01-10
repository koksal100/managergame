import '../entities/match.dart';

abstract class MatchRepository {
  Future<void> saveMatches(List<Match> matches);
  Future<List<Match>> getMatchesByWeek(int season, int week);
  Future<List<Match>> getMatchesByClub(int clubId);
  Future<List<Match>> getMatchesByLeagueAndWeek(int leagueId, int season, int week);
  Future<void> updateMatches(List<Match> matches);
}
