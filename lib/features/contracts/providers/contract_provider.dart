import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/database_provider.dart';
import '../data/repositories/contract_repository_impl.dart';
import '../domain/entities/contract.dart';
import '../domain/repositories/contract_repository.dart';

final contractRepositoryProvider = Provider<ContractRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return ContractRepositoryImpl(database);
});

final contractsProvider = AsyncNotifierProvider<ContractsNotifier, List<Contract>>(() {
  return ContractsNotifier();
});

class ContractsNotifier extends AsyncNotifier<List<Contract>> {
  @override
  Future<List<Contract>> build() async {
    final repository = ref.read(contractRepositoryProvider);
    final result = await repository.getContracts();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (contracts) => contracts,
    );
  }

  Future<void> addContract(Contract contract) async {
    final repository = ref.read(contractRepositoryProvider);
    final result = await repository.createContract(contract);
    
    result.fold(
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (id) async {
         // Optionally refresh
         state = const AsyncValue.loading();
         ref.invalidateSelf(); // This triggers build() again
      },
    );
  }
}
