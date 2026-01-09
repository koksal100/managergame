import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/agent.dart';

abstract class AgentRepository {
  Future<Either<Failure, List<Agent>>> getAgents();
  Future<Either<Failure, Agent>> getAgentById(int id);
  Future<Either<Failure, int>> createAgent(Agent agent);
  Future<Either<Failure, void>> updateAgent(Agent agent);
  Future<Either<Failure, void>> deleteAgent(int id);
}
