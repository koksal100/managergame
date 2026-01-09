import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/error/failures.dart';
import '../entities/league.dart';
import '../repositories/league_repository.dart';

class LeagueRepositoryImpl implements LeagueRepository {
  final AppDatabase database;

  LeagueRepositoryImpl(this.database);

  @override
  Future<Either<Failure, List<League>>> getLeagues() async {
    try {
      final rows = await database.select(database.leagues).get();
      final list = rows.map((row) => League(
        id: row.id,
        name: row.name,
        countryId: row.countryId,
        reputation: row.reputation,
      )).toList();
      return Right(list);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
