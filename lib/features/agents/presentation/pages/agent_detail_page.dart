import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart' hide Player;
import '../../../../core/presentation/widgets/glass_container.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../players/domain/entities/player.dart';
import '../../../players/presentation/widgets/player_detail_dialog.dart';
import '../../../players/presentation/widgets/player_list_item.dart';

final agentPlayersProvider = FutureProvider.family<List<Player>, int>((
  ref,
  agentId,
) async {
  final db = ref.read(appDatabaseProvider);
  final players = await (db.select(
    db.players,
  )..where((tbl) => tbl.agentId.equals(agentId))).get();

  return players
      .map(
        (p) => Player(
          id: p.id,
          name: p.name,
          age: p.age,
          position: p.position,
          clubId: p.clubId,
          ca: p.ca,
          pa: p.pa,
          marketValue: p.marketValue,
          reputation: p.reputation,
          agentId: p.agentId,
        ),
      )
      .toList();
});

class AgentDetailPage extends ConsumerWidget {
  final Agent agent;

  const AgentDetailPage({super.key, required this.agent});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsync = ref.watch(agentPlayersProvider(agent.id));
    final isUser = agent.id == 1;

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
                  Colors.black.withValues(alpha: 0.66),
                  Colors.black.withValues(alpha: 0.9),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 20, 12),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          isUser ? 'MY PROFILE' : agent.name.toUpperCase(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _AgentProfileCard(agent: agent, isUser: isUser),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Text(
                        'REPRESENTED PLAYERS',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const Spacer(),
                      playersAsync.maybeWhen(
                        data: (players) => Text(
                          '${players.length}',
                          style: const TextStyle(
                            color: Colors.tealAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        orElse: () => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: playersAsync.when(
                    data: (players) {
                      if (players.isEmpty) {
                        return const Center(
                          child: Text(
                            "No players represented.",
                            style: TextStyle(color: Colors.white54),
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                        itemCount: players.length,
                        itemBuilder: (context, index) {
                          final player = players[index];
                          return PlayerListItem(
                            player: player,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    PlayerDetailDialog(player: player),
                              );
                            },
                          );
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

class _AgentProfileCard extends StatelessWidget {
  final Agent agent;
  final bool isUser;

  const _AgentProfileCard({required this.agent, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 16,
      backgroundColor: isUser
          ? const Color(0x6626A69A)
          : const Color(0x991E1E1E),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: isUser ? Colors.teal : Colors.blueGrey.shade700,
              child: Text(
                agent.name.substring(0, 1),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    agent.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _StatPill(
                        icon: Icons.workspace_premium,
                        text: 'Level ${agent.level}',
                        color: Colors.amberAccent,
                      ),
                      _StatPill(
                        icon: Icons.star,
                        text: 'Rep ${agent.reputation}',
                        color: Colors.tealAccent,
                      ),
                      _StatPill(
                        icon: Icons.attach_money,
                        text:
                            '€${(agent.balance / 1000000).toStringAsFixed(1)}M',
                        color: Colors.greenAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _StatPill({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.24),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
