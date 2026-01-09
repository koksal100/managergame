import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/relationship.dart';

abstract class RelationshipRepository {
  Future<Either<Failure, List<Relationship>>> getRelationships();
  Future<Either<Failure, int>> createRelationship(Relationship relationship);
}
