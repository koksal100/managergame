import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/error/failures.dart';
import '../entities/agent.dart';
import '../repositories/agent_repository.dart';

class AgentRepositoryImpl implements AgentRepository {
  final AppDatabase database;

  AgentRepositoryImpl(this.database);

  @override
  Future<Either<Failure, List<Agent>>> getAgents() async {
    try {
      final rows = await database.select(database.agents).get();
      final list = rows.map((row) => Agent(
        id: row.id,
        name: row.name,
        balance: row.balance,
        reputation: row.reputation,
        negotiationSkill: row.negotiationSkill,
        scoutingSkill: row.scoutingSkill,
        level: row.level,
      )).toList();
      return Right(list);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Agent>> getAgentById(int id) async {
    try {
      final query = database.select(database.agents)..where((tbl) => tbl.id.equals(id));
      final row = await query.getSingleOrNull();
      
      if (row == null) {
        return const Left(CacheFailure('Agent not found'));
      }

      return Right(Agent(
        id: row.id,
        name: row.name,
        balance: row.balance,
        reputation: row.reputation,
        negotiationSkill: row.negotiationSkill,
        scoutingSkill: row.scoutingSkill,
        level: row.level,
      ));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> createAgent(Agent agent) async {
    try {
      final companion = AgentsCompanion(
        name: Value(agent.name),
        balance: Value(agent.balance),
        reputation: Value(agent.reputation),
        negotiationSkill: Value(agent.negotiationSkill),
        scoutingSkill: Value(agent.scoutingSkill),
        level: Value(agent.level),
      );
      final id = await database.into(database.agents).insert(companion);
      return Right(id);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateAgent(Agent agent) async {
    try {
      final companion = AgentsCompanion(
        id: Value(agent.id),
        name: Value(agent.name),
        balance: Value(agent.balance),
        reputation: Value(agent.reputation),
        negotiationSkill: Value(agent.negotiationSkill),
        scoutingSkill: Value(agent.scoutingSkill),
        level: Value(agent.level),
      );
      await database.update(database.agents).replace(companion);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAgent(int id) async {
    try {
      await (database.delete(database.agents)..where((tbl) => tbl.id.equals(id))).go();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
