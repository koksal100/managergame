import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/presentation/widgets/glass_container.dart';
import '../../../../core/providers/database_provider.dart';
import 'agent_detail_page.dart';

final allAgentsProvider = FutureProvider<List<Agent>>((ref) async {
  final db = ref.read(appDatabaseProvider);
  return (db.select(db.agents)..orderBy([
        (t) => OrderingTerm(expression: t.reputation, mode: OrderingMode.desc),
      ]))
      .get();
});

class AgentsPage extends ConsumerWidget {
  const AgentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentsAsync = ref.watch(allAgentsProvider);

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/background.png', fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.66),
                  Colors.black.withOpacity(0.88),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white12),
                        ),
                        child: const Icon(
                          Icons.public,
                          color: Colors.tealAccent,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'WORLD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'AGENTS DIRECTORY',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: agentsAsync.when(
                    data: (agents) {
                      if (agents.isEmpty) {
                        return const Center(
                          child: Text(
                            "No agents found.",
                            style: TextStyle(color: Colors.white70),
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                        itemCount: agents.length,
                        itemBuilder: (context, index) {
                          return _AgentCard(agent: agents[index]);
                        },
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                    error: (err, stack) => Center(
                      child: Text(
                        "Error: $err",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AgentCard extends StatelessWidget {
  final Agent agent;

  const _AgentCard({required this.agent});

  @override
  Widget build(BuildContext context) {
    final isUser = agent.id == 1;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassContainer(
        borderRadius: 14,
        backgroundColor: isUser
            ? const Color(0x6626A69A)
            : const Color(0x991E1E1E),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          leading: CircleAvatar(
            backgroundColor: isUser ? Colors.teal : Colors.blueGrey.shade700,
            child: Text(
              agent.name.substring(0, 1),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            agent.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Text(
                  "REP ${agent.reputation}",
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(width: 10),
                Text(
                  "LVL ${agent.level}",
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                if (isUser) ...[
                  const SizedBox(width: 10),
                  const Text(
                    "YOU",
                    style: TextStyle(
                      color: Colors.tealAccent,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white38,
            size: 16,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => AgentDetailPage(agent: agent)),
            );
          },
        ),
      ),
    );
  }
}
