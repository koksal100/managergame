import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart' hide Contract;
import '../../../../core/error/failures.dart';
import '../../domain/repositories/contract_repository.dart';
import '../../domain/entities/contract.dart';


class ContractRepositoryImpl implements ContractRepository {
  final AppDatabase database;

  ContractRepositoryImpl(this.database);

  @override
  Future<Either<Failure, List<Contract>>> getContracts() async {
    try {
      final rows = await database.select(database.contracts).get();
      final list = rows.map((row) => Contract(
        id: row.id,
        playerId: row.playerId,
        agentId: row.agentId,
        startDate: row.startDate,
        endDate: row.endDate,
        wage: row.wage,
        releaseClause: row.releaseClause,
        status: row.status,
      )).toList();
      return Right(list);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> createContract(Contract contract) async {
    try {
      final companion = ContractsCompanion(
        playerId: Value(contract.playerId),
        agentId: Value(contract.agentId),
        startDate: Value(contract.startDate),
        endDate: Value(contract.endDate),
        wage: Value(contract.wage),
        releaseClause: Value(contract.releaseClause),
        status: Value(contract.status),
      );
      final id = await database.into(database.contracts).insert(companion);
      return Right(id);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
