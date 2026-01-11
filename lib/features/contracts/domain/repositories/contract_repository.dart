import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/new_contracts.dart';

abstract class ContractRepository {
  Future<Either<Failure, AgentContractEntity?>> getAgentContract(int playerId);
  Future<Either<Failure, ClubContractEntity?>> getClubContract(int playerId);
}
// Note: Entities might need to be created if using CLEAN arch strictly, 
// but for now I might use the Drift generated classes or DTOs.
// User didn't specify strict adherence but project uses it.
// I will create simple entities or reuse the drift classes if acceptable.
// Given strict clean arch in this project (Data vs Domain), I should map.
// checking lib/features/contracts/domain/entities...
