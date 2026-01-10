import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/match.dart' as domain;
import '../../domain/repositories/match_repository.dart';

class MatchRepositoryImpl implements MatchRepository {
  final AppDatabase _database;

  MatchRepositoryImpl(this._database);

  @override
  Future<void> saveMatches(List<domain.Match> matches) async {
    await _database.batch((batch) {
      batch.insertAll(
        _database.matches,
        matches.map((m) => MatchesCompanion(
          homeClubId: Value(m.homeClubId),
          awayClubId: Value(m.awayClubId),
          homeScore: Value(m.homeScore),
          awayScore: Value(m.awayScore),
          season: Value(m.season),
          week: Value(m.week),
          isPlayed: Value(m.isPlayed),
        )),
      );
    });
  }

  @override
  Future<List<domain.Match>> getMatchesByWeek(int season, int week) async {
    final query = _database.select(_database.matches)
      ..where((t) => t.season.equals(season) & t.week.equals(week));
    
    final result = await query.get();
    
    return result.map((row) => domain.Match(
      id: row.id,
      homeClubId: row.homeClubId,
      awayClubId: row.awayClubId,
      homeScore: row.homeScore,
      awayScore: row.awayScore,
      season: row.season,
      week: row.week,
      isPlayed: row.isPlayed,
    )).toList();
  }

  @override
  Future<List<domain.Match>> getMatchesByClub(int clubId) async {
    final query = _database.select(_database.matches)
      ..where((t) => t.homeClubId.equals(clubId) | t.awayClubId.equals(clubId));
      
    final result = await query.get();
    
    return result.map((row) => domain.Match(
      id: row.id,
      homeClubId: row.homeClubId,
      awayClubId: row.awayClubId,
      homeScore: row.homeScore,
      awayScore: row.awayScore,
      season: row.season,
      week: row.week,
      isPlayed: row.isPlayed,
    )).toList();
  }
}
