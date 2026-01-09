import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart' hide Club;
import '../../../../core/error/failures.dart';
import '../../domain/repositories/club_repository.dart';
import '../../domain/entities/club.dart';


class ClubRepositoryImpl implements ClubRepository {
  final AppDatabase database;

  ClubRepositoryImpl(this.database);

  @override
  Future<Either<Failure, List<Club>>> getClubs() async {
    try {
      final rows = await database.select(database.clubs).get();
      final list = rows.map((row) => Club(
        id: row.id,
        name: row.name,
        leagueId: row.leagueId,
        reputation: row.reputation,
        transferBudget: row.transferBudget,
        wageBudget: row.wageBudget,
      )).toList();
      return Right(list);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Club>> getClubById(int id) async {
    try {
      final query = database.select(database.clubs)..where((tbl) => tbl.id.equals(id));
      final row = await query.getSingleOrNull();
      
      if (row == null) {
        return const Left(CacheFailure('Club not found'));
      }

      return Right(Club(
        id: row.id,
        name: row.name,
        leagueId: row.leagueId,
        reputation: row.reputation,
        transferBudget: row.transferBudget,
        wageBudget: row.wageBudget,
      ));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> createClub(Club club) async {
    try {
      final companion = ClubsCompanion(
        name: Value(club.name),
        leagueId: Value(club.leagueId),
        reputation: Value(club.reputation),
        transferBudget: Value(club.transferBudget),
        wageBudget: Value(club.wageBudget),
      );
      final id = await database.into(database.clubs).insert(companion);
      return Right(id);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateClub(Club club) async {
    try {
      final companion = ClubsCompanion(
        id: Value(club.id),
        name: Value(club.name),
        leagueId: Value(club.leagueId),
        reputation: Value(club.reputation),
        transferBudget: Value(club.transferBudget),
        wageBudget: Value(club.wageBudget),
      );
      await database.update(database.clubs).replace(companion);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteClub(int id) async {
    try {
      await (database.delete(database.clubs)..where((tbl) => tbl.id.equals(id))).go();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
