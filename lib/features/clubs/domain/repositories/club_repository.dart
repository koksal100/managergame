import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/club.dart';

abstract class ClubRepository {
  Future<Either<Failure, List<Club>>> getClubs();
  Future<Either<Failure, List<Club>>> getClubsByLeagueId(int leagueId);
  Future<Either<Failure, Club>> getClubById(int id);
  Future<Either<Failure, int>> createClub(Club club);
  Future<Either<Failure, void>> updateClub(Club club);
  Future<Either<Failure, void>> deleteClub(int id);
  Future<Either<Failure, List<Club>>> searchClubs(String query);
}
