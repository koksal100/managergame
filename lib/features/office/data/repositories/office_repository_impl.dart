
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/office_staff.dart';
import '../../domain/repositories/office_repository.dart';

class OfficeRepositoryImpl implements OfficeRepository {
  final AppDatabase database;

  OfficeRepositoryImpl(this.database);

  @override
  Future<Either<Failure, List<OfficeStaff>>> getStaff(int agentId) async {
    try {
      final query = database.select(database.agentStaffs)..where((tbl) => tbl.agentId.equals(agentId));
      final rows = await query.get();

      return Right(rows.map((row) => OfficeStaff(
        id: row.id,
        agentId: row.agentId,
        type: row.staffType,
        level: row.level,
        count: row.count,
      )).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> hireStaff(int agentId, StaffType type, int level) async {
    try {
      // Check if exists
      final existing = await (database.select(database.agentStaffs)
        ..where((tbl) => tbl.agentId.equals(agentId))
        ..where((tbl) => tbl.staffType.equals(type.index)) // Enum index check just in case, or use drift converter logic
        ..where((tbl) => tbl.level.equals(level))
      ).getSingleOrNull();

      if (existing != null) {
        // Update count
        await (database.update(database.agentStaffs)..where((tbl) => tbl.id.equals(existing.id))).write(
          AgentStaffsCompanion(count: Value(existing.count + 1)),
        );
      } else {
        // Insert new
        await database.into(database.agentStaffs).insert(
          AgentStaffsCompanion(
            agentId: Value(agentId),
            staffType: Value(type),
            level: Value(level),
            count: const Value(1),
          ),
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> fireStaff(int agentId, StaffType type, int level) async {
    try {
       final existing = await (database.select(database.agentStaffs)
        ..where((tbl) => tbl.agentId.equals(agentId))
        ..where((tbl) => tbl.staffType.equals(type.index))
        ..where((tbl) => tbl.level.equals(level))
      ).getSingleOrNull();

      if (existing != null) {
        if (existing.count > 1) {
           await (database.update(database.agentStaffs)..where((tbl) => tbl.id.equals(existing.id))).write(
            AgentStaffsCompanion(count: Value(existing.count - 1)),
          );
        } else {
          // Delete row if count reaches 0
          await (database.delete(database.agentStaffs)..where((tbl) => tbl.id.equals(existing.id))).go();
        }
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
