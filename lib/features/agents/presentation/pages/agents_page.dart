import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' hide Column;
import '../../../../core/database/app_database.dart';
import '../../../../core/providers/database_provider.dart';
import 'agent_detail_page.dart';

// Provider to get all agents sorted by Reputation
final allAgentsProvider = FutureProvider<List<Agent>>((ref) async {
  final db = ref.read(appDatabaseProvider);
  return (db.select(db.agents)..orderBy([(t) => OrderingTerm(expression: t.reputation, mode: OrderingMode.desc)])).get();
});

class AgentsPage extends ConsumerWidget {
  const AgentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentsAsync = ref.watch(allAgentsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: const Text('World Agents Directory', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: agentsAsync.when(
        data: (agents) {
          if (agents.isEmpty) {
             return const Center(child: Text("No agents found.", style: TextStyle(color: Colors.white70)));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: agents.length,
            itemBuilder: (context, index) {
              final agent = agents[index];
              return _AgentCard(agent: agent);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err", style: const TextStyle(color: Colors.red))),
      ),
    );
  }
}

class _AgentCard extends StatelessWidget {
  final Agent agent;
  const _AgentCard({required this.agent});

  @override
  Widget build(BuildContext context) {
    bool isUser = agent.id == 1;

    return Card(
      color: isUser ? Colors.teal.withOpacity(0.2) : Colors.white10,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isUser ? const BorderSide(color: Colors.tealAccent, width: 1) : BorderSide.none
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: isUser ? Colors.teal : Colors.blueGrey,
          child: Text(
            agent.name.substring(0, 1),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          agent.name,
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const SizedBox(height: 4),
             Text("Reputation: ${agent.reputation} • Level: ${agent.level}", style: const TextStyle(color: Colors.white70)),
             if(isUser) const Text("YOU", style: TextStyle(color: Colors.tealAccent, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
        onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (c) => AgentDetailPage(agent: agent)));
        },
      ),
    );
  }
}
