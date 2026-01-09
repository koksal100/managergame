import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/error/failures.dart';
import '../entities/relationship.dart';
import '../repositories/relationship_repository.dart';

class RelationshipRepositoryImpl implements RelationshipRepository {
  final AppDatabase database;

  RelationshipRepositoryImpl(this.database);

  @override
  Future<Either<Failure, List<Relationship>>> getRelationships() async {
    try {
      final rows = await database.select(database.relationships).get();
      final list = rows.map((row) => Relationship(
        id: row.id,
        fromId: row.fromId,
        toId: row.toId,
        fromType: row.fromType,
        toType: row.toType,
        score: row.score,
      )).toList();
      return Right(list);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> createRelationship(Relationship relationship) async {
    try {
      final companion = RelationshipsCompanion(
        fromId: Value(relationship.fromId),
        toId: Value(relationship.toId),
        fromType: Value(relationship.fromType),
        toType: Value(relationship.toType),
        score: Value(relationship.score),
      );
      final id = await database.into(database.relationships).insert(companion);
      return Right(id);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
