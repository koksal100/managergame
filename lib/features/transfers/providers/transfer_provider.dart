import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/database_provider.dart';
import '../data/repositories/transfer_repository_impl.dart';
import '../domain/entities/transfer.dart';
import '../domain/repositories/transfer_repository.dart';

final transferRepositoryProvider = Provider<TransferRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return TransferRepositoryImpl(database);
});

final transfersProvider = AsyncNotifierProvider<TransfersNotifier, List<Transfer>>(() {
  return TransfersNotifier();
});

class TransfersNotifier extends AsyncNotifier<List<Transfer>> {
  @override
  Future<List<Transfer>> build() async {
    final repository = ref.read(transferRepositoryProvider);
    final result = await repository.getTransfers();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (transfers) => transfers,
    );
  }

  Future<void> addTransfer(Transfer transfer) async {
    final repository = ref.read(transferRepositoryProvider);
    final result = await repository.createTransfer(transfer);
    
    result.fold(
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (id) async {
         state = const AsyncValue.loading();
         ref.invalidateSelf(); 
      },
    );
  }
}
