import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/error/failures.dart';
import '../entities/player.dart';
import '../repositories/player_repository.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final AppDatabase database;

  PlayerRepositoryImpl(this.database);

  @override
  Future<Either<Failure, List<Player>>> getPlayers() async {
    try {
      final playerRows = await database.select(database.players).get();
      final players = playerRows.map((row) => Player(
        id: row.id,
        name: row.name,
        age: row.age,
        clubId: row.clubId,
        agentId: row.agentId,
        position: row.position,
        ca: row.ca,
        pa: row.pa,
        reputation: row.reputation,
        currentContractId: row.currentContractId,
      )).toList();
      return Right(players);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Player>> getPlayerById(int id) async {
    try {
      final query = database.select(database.players)..where((tbl) => tbl.id.equals(id));
      final row = await query.getSingleOrNull();
      
      if (row == null) {
        return const Left(CacheFailure('Player not found'));
      }

      return Right(Player(
        id: row.id,
        name: row.name,
        age: row.age,
        clubId: row.clubId,
        agentId: row.agentId,
        position: row.position,
        ca: row.ca,
        pa: row.pa,
        reputation: row.reputation,
        currentContractId: row.currentContractId,
      ));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> createPlayer(Player player) async {
    try {
      final companion = PlayersCompanion(
        name: Value(player.name),
        age: Value(player.age),
        clubId: Value(player.clubId),
        agentId: Value(player.agentId),
        position: Value(player.position),
        ca: Value(player.ca),
        pa: Value(player.pa),
        reputation: Value(player.reputation),
        currentContractId: Value(player.currentContractId),
      );
      final id = await database.into(database.players).insert(companion);
      return Right(id);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePlayer(Player player) async {
    try {
       // Drift update requires explicit Value wrappers if we want to be safe or just replace object
       // But the Repository takes an Entity which has full data, so we can replace.
       final companion = PlayersCompanion(
        id: Value(player.id),
        name: Value(player.name),
        age: Value(player.age),
        clubId: Value(player.clubId),
        agentId: Value(player.agentId),
        position: Value(player.position),
        ca: Value(player.ca),
        pa: Value(player.pa),
        reputation: Value(player.reputation),
        currentContractId: Value(player.currentContractId),
      );
      await database.update(database.players).replace(companion);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePlayer(int id) async {
    try {
      await (database.delete(database.players)..where((tbl) => tbl.id.equals(id))).go();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
