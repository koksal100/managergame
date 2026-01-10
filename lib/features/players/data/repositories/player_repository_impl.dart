import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart' hide Player;
import '../../../../core/error/failures.dart';
import '../../domain/repositories/player_repository.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/player_filter.dart';


class PlayerRepositoryImpl implements PlayerRepository {
  final AppDatabase database;

  PlayerRepositoryImpl(this.database);

  @override
  Future<Either<Failure, List<Player>>> getPlayers({PlayerFilter? filter}) async {
    try {
      final query = database.select(database.players);

      if (filter != null) {
        if (filter.nameQuery != null && filter.nameQuery!.isNotEmpty) {
          query.where((tbl) => tbl.name.like('%${filter.nameQuery}%'));
        }
        if (filter.positions != null && filter.positions!.isNotEmpty) {
          query.where((tbl) => tbl.position.isIn(filter.positions!));
        }
        if (filter.minAge != null) {
          query.where((tbl) => tbl.age.isBiggerOrEqualValue(filter.minAge!));
        }
        if (filter.maxAge != null) {
          query.where((tbl) => tbl.age.isSmallerOrEqualValue(filter.maxAge!));
        }
        if (filter.minCa != null) {
          query.where((tbl) => tbl.ca.isBiggerOrEqualValue(filter.minCa!));
        }
        if (filter.minPa != null) {
          query.where((tbl) => tbl.pa.isBiggerOrEqualValue(filter.minPa!));
        }
        if (filter.minMarketValue != null) {
          query.where((tbl) => tbl.marketValue.isBiggerOrEqualValue(filter.minMarketValue!));
        }
        if (filter.maxMarketValue != null) {
          query.where((tbl) => tbl.marketValue.isSmallerOrEqualValue(filter.maxMarketValue!));
        }
      }

      // Dynamic Sorting
      final sortMode = (filter?.ascending ?? false) ? OrderingMode.asc : OrderingMode.desc;
      final sortType = filter?.sortType ?? PlayerSortType.ca;

      switch (sortType) {
        case PlayerSortType.name:
          query.orderBy([(t) => OrderingTerm(expression: t.name, mode: sortMode)]);
          break;
        case PlayerSortType.age:
          query.orderBy([(t) => OrderingTerm(expression: t.age, mode: sortMode)]);
          break;
        case PlayerSortType.pa:
          query.orderBy([(t) => OrderingTerm(expression: t.pa, mode: sortMode)]);
          break;
        case PlayerSortType.reputation:
          query.orderBy([(t) => OrderingTerm(expression: t.reputation, mode: sortMode)]);
          break;
        case PlayerSortType.marketValue:
          query.orderBy([(t) => OrderingTerm(expression: t.marketValue, mode: sortMode)]);
          break;
        case PlayerSortType.ca:
        default:
          query.orderBy([(t) => OrderingTerm(expression: t.ca, mode: sortMode)]);
          break;
      }

      final playerRows = await query.get();

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
        marketValue: row.marketValue,
        currentContractId: row.currentContractId,
      )).toList();
      return Right(players);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Player>>> getPlayersByClubId(int clubId) async {
    try {
      final query = database.select(database.players)..where((tbl) => tbl.clubId.equals(clubId));
      
      // Default sort by CA descending for squad view
      query.orderBy([(t) => OrderingTerm(expression: t.ca, mode: OrderingMode.desc)]);

      final playerRows = await query.get();

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
        marketValue: row.marketValue,
        currentContractId: row.currentContractId,
      )).toList();

      // Define position weights
      final positionWeights = {
        'GK': 0,
        'DL': 1, 'DC': 1, 'DR': 1, 'DEF': 1, // Added DEF
        'DMC': 2,
        'ML': 3, 'MC': 3, 'MR': 3, 'MID': 3, // Added MID
        'AML': 4, 'AMC': 4, 'AMR': 4,
        'ST': 5, 'FWD': 5, // Added FWD
      };

      // Custom Sort: Position Weight (asc) -> CA (desc)
      players.sort((a, b) {
        final weightA = positionWeights[a.position] ?? 99;
        final weightB = positionWeights[b.position] ?? 99;

        if (weightA != weightB) {
          return weightA.compareTo(weightB);
        } else {
          // Secondary sort by CA (Best players first within position group)
          return b.ca.compareTo(a.ca);
        }
      });

      return Right(players);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Player>>> getPlayersByAgentId(int agentId) async {
    try {
      final query = database.select(database.players)..where((tbl) => tbl.agentId.equals(agentId));
      
      // Sort by CA descending
      query.orderBy([(t) => OrderingTerm(expression: t.ca, mode: OrderingMode.desc)]);

      final playerRows = await query.get();

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
        marketValue: row.marketValue,
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
        marketValue: row.marketValue,
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
        marketValue: Value(player.marketValue),
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
        marketValue: Value(player.marketValue),
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
