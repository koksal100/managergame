import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/league.dart';

abstract class LeagueRepository {
  Future<Either<Failure, List<League>>> getLeagues();
  // Future<Either<Failure, League>> getLeagueById(int id);
}
