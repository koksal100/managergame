import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart' hide Player;
import '../../../../core/providers/database_provider.dart';
import '../../../players/domain/entities/player.dart';
import '../../../players/presentation/widgets/player_list_item.dart';
// Removed domain/entities/agent.dart to avoid conflict with Drift Agent

// Provider to get players by specific agent (Not User)
final agentPlayersProvider = FutureProvider.family<List<Player>, int>((ref, agentId) async {
    final db = ref.read(appDatabaseProvider);
    final players = await (db.select(db.players)..where((tbl) => tbl.agentId.equals(agentId))).get();
    
    // Map to Domain Entity
    // Note: We might need a mapper, but doing manual mapping for speed as we did in other files
    return players.map((p) => Player(
        id: p.id,
        name: p.name,
        age: p.age,
        position: p.position,
        clubId: p.clubId,
        ca: p.ca,
        pa: p.pa,
        marketValue: p.marketValue,
        reputation: p.reputation,
        agentId: p.agentId
    )).toList();
});

class AgentDetailPage extends ConsumerWidget {
  final Agent agent;

  const AgentDetailPage({super.key, required this.agent});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsync = ref.watch(agentPlayersProvider(agent.id));
    bool isUser = agent.id == 1;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: Text(isUser ? "My Stats" : agent.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Agent Profile Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isUser ? Colors.teal.withOpacity(0.1) : Colors.white10,
              border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1))),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: isUser ? Colors.teal : Colors.blueGrey,
                  child: Text(
                    agent.name.substring(0, 1),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Level ${agent.level}",
                      style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Reputation: ${agent.reputation}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      "Balance: €${(agent.balance / 1000000).toStringAsFixed(1)}M",
                      style: const TextStyle(color: Colors.greenAccent),
                    ),
                  ],
                )
              ],
            ),
          ),
          
          Expanded(
             child: playersAsync.when(
               data: (players) {
                 if (players.isEmpty) {
                   return const Center(child: Text("No players represented.", style: TextStyle(color: Colors.white54)));
                 }
                 return ListView.builder(
                   padding: const EdgeInsets.all(16),
                   itemCount: players.length,
                   itemBuilder: (context, index) {
                      return PlayerListItem(player: players[index]);
                   },
                 );
               },
               loading: () => const Center(child: CircularProgressIndicator()),
               error: (err, stack) => Center(child: Text("Error: $err", style: const TextStyle(color: Colors.red))),
             ),
          ),
        ],
      ),
    );
  }
}
