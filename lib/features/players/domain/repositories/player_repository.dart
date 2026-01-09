import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/player.dart';
import '../entities/player_filter.dart';

abstract class PlayerRepository {
  Future<Either<Failure, List<Player>>> getPlayers({PlayerFilter? filter});
  Future<Either<Failure, List<Player>>> getPlayersByClubId(int clubId);
  Future<Either<Failure, Player>> getPlayerById(int id);
  Future<Either<Failure, int>> createPlayer(Player player);
  Future<Either<Failure, void>> updatePlayer(Player player);
  Future<Either<Failure, void>> deletePlayer(int id);
}
