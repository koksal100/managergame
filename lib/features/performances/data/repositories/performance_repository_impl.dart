import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/performance.dart' as domain;
import '../../domain/entities/player_stat.dart';
import '../../domain/entities/match_detail_stat.dart';
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
      season: row.season,
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
      season: row.season,
      rating: row.rating,
    )).toList();
  }

  @override
  Future<List<MatchDetailStat>> getMatchStats(int matchId) async {
    final p = _database.performances;
    final pl = _database.players;
    
    // Join performances with players to get names and clubs
    final query = _database.select(p).join([
      innerJoin(pl, pl.id.equalsExp(p.playerId)),
    ]);

    query.where(p.matchId.equals(matchId));

    final result = await query.get();

    return result.map((row) {
        final performance = row.readTable(p);
        final player = row.readTable(pl);

        return MatchDetailStat(
            playerId: player.id,
            playerName: player.name,
            clubId: player.clubId ?? 0,
            goals: performance.goals,
            assists: performance.assists,
            rating: performance.rating,
        );
    }).toList();
  }
  @override
  Future<List<PlayerStat>> getTopScorers(int leagueId, {int limit = 10}) async {
    return _getStats(
      leagueId, 
      limit, 
      (p) => OrderingTerm.desc(p.goals.sum()),
    );
  }

  @override
  Future<List<PlayerStat>> getTopAssisters(int leagueId, {int limit = 10}) async {
    return _getStats(
      leagueId, 
      limit, 
      (p) => OrderingTerm.desc(p.assists.sum()),
    );
  }

  @override
  Future<List<PlayerStat>> getTopRated(int leagueId, {int limit = 10}) async {
    return _getStats(
      leagueId, 
      limit, 
      (p) => OrderingTerm.desc(p.rating.avg()),
    );
  }

  Future<List<PlayerStat>> _getStats(
    int leagueId, 
    int limit,
    OrderingTerm Function($PerformancesTable) orderBy,
  ) async {
    final p = _database.performances;
    final pl = _database.players;
    final c = _database.clubs;

    final goalsSum = p.goals.sum();
    final assistsSum = p.assists.sum();
    final ratingAvg = p.rating.avg();
    final matchCount = p.id.count();

    final query = _database.select(pl).join([
      innerJoin(c, c.id.equalsExp(pl.clubId)),
      innerJoin(p, p.playerId.equalsExp(pl.id)),
    ]);

    query.where(c.leagueId.equals(leagueId));
    
    query.addColumns([goalsSum, assistsSum, ratingAvg, matchCount]);
    query.groupBy([pl.id]);
    query.orderBy([orderBy(p)]);
    query.limit(limit);

    final result = await query.get();

    return result.map((row) {
      final player = row.readTable(pl);
      final club = row.readTable(c);
      final g = row.read(goalsSum) ?? 0;
      final a = row.read(assistsSum) ?? 0;
      final r = row.read(ratingAvg) ?? 0.0;
      final m = row.read(matchCount) ?? 0;

      return PlayerStat(
        playerId: player.id,
        playerName: player.name,
        clubName: club.name,
        goals: g,
        assists: a,
        averageRating: r,
        matchesPlayed: m,
      );
    }).toList();
  }
}
