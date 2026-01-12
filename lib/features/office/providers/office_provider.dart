
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/database_provider.dart';
import '../data/repositories/office_repository_impl.dart';
import '../domain/entities/office_staff.dart';
import '../domain/repositories/office_repository.dart';

final officeRepositoryProvider = Provider<OfficeRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return OfficeRepositoryImpl(database);
});

// Provide list of staff for a given agent
final officeStaffProvider = FutureProvider.family<List<OfficeStaff>, int>((ref, agentId) async {
  final repository = ref.watch(officeRepositoryProvider);
  final result = await repository.getStaff(agentId);
  return result.fold(
    (l) => [],
    (r) => r,
  );
});

// Calculate total daily cost for UI
final officeStaffCostProvider = FutureProvider.family<int, int>((ref, agentId) async {
  final staff = await ref.watch(officeStaffProvider(agentId).future);
  int total = 0;
  for (var s in staff) {
    total += s.totalWeeklyCost;
  }
  return total;
});
