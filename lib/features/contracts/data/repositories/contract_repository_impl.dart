import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/new_contracts.dart';
import '../../domain/repositories/contract_repository.dart';


class ContractRepositoryImpl implements ContractRepository {
  final AppDatabase database;

  ContractRepositoryImpl(this.database);

  @override
  Future<Either<Failure, AgentContractEntity?>> getAgentContract(int playerId) async {
    try {
      final query = database.select(database.agentContracts)..where((t) => t.playerId.equals(playerId));
      final result = await query.getSingleOrNull();
      
      if (result == null) return const Right(null);

      // Mapping Logic (Row -> Entity)
      return Right(AgentContractEntity(
        id: result.id,
        agentId: result.agentId,
        playerId: result.playerId,
        feePercentage: result.feePercentage,
        startDate: result.startDate,
        endDate: result.endDate,
        status: result.status,
      ));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ClubContractEntity?>> getClubContract(int playerId) async {
    try {
      final query = database.select(database.clubContracts)..where((t) => t.playerId.equals(playerId));
      final result = await query.getSingleOrNull();
      
      if (result == null) return const Right(null);

      // Mapping Logic
      return Right(ClubContractEntity(
        id: result.id,
        clubId: result.clubId,
        playerId: result.playerId,
        weeklySalary: result.weeklySalary,
        startDate: result.startDate,
        endDate: result.endDate,
        status: result.status,
        releaseClause: result.releaseClause,
      ));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
