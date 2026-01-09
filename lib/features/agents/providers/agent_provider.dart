import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/database_provider.dart';
import '../data/repositories/agent_repository_impl.dart';
import '../domain/entities/agent.dart';
import '../domain/repositories/agent_repository.dart';

final agentRepositoryProvider = Provider<AgentRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return AgentRepositoryImpl(database);
});

final agentsProvider = AsyncNotifierProvider<AgentsNotifier, List<Agent>>(() {
  return AgentsNotifier();
});

class AgentsNotifier extends AsyncNotifier<List<Agent>> {
  @override
  Future<List<Agent>> build() async {
    return _fetchAgents();
  }

  Future<List<Agent>> _fetchAgents() async {
    final repository = ref.read(agentRepositoryProvider);
    final result = await repository.getAgents();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (agents) => agents,
    );
  }

  Future<void> addAgent(Agent agent) async {
    final repository = ref.read(agentRepositoryProvider);
    final result = await repository.createAgent(agent);
    
    result.fold(
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (id) async {
         state = const AsyncValue.loading();
         state = await AsyncValue.guard(() => _fetchAgents());
      },
    );
  }
}
