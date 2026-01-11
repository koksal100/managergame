import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/database_provider.dart';
import '../data/repositories/contract_repository_impl.dart';
import '../domain/repositories/contract_repository.dart';
import '../domain/entities/new_contracts.dart';

final contractRepositoryProvider = Provider<ContractRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return ContractRepositoryImpl(database);
});

// Fetch Club Contract for a specific player
final playerClubContractProvider = FutureProvider.family<ClubContractEntity?, int>((ref, playerId) async {
  final repo = ref.watch(contractRepositoryProvider);
  final result = await repo.getClubContract(playerId);
  return result.fold(
     (fail) => null, 
     (contract) => contract
  );
});

// Fetch Agent Contract for a specific player
final playerAgentContractProvider = FutureProvider.family<AgentContractEntity?, int>((ref, playerId) async {
  final repo = ref.watch(contractRepositoryProvider);
  final result = await repo.getAgentContract(playerId);
  return result.fold(
     (fail) => null, 
     (contract) => contract
  );
});
