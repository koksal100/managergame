import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widgets/glass_container.dart';
import '../../../agents/providers/user_agent_provider.dart';
import '../providers/player_provider.dart';
import '../widgets/player_detail_dialog.dart';

class PlayersPage extends ConsumerWidget {
  const PlayersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myPlayersAsync = ref.watch(playersByAgentProvider(1)); // User Agent ID = 1
    final userAgentNotifier = ref.read(userAgentProvider.notifier);
    final userAgentAsync = ref.watch(userAgentProvider);

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/players_background.png',
            fit: BoxFit.cover,
          ),
          
          // Overlay Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'MY AGENCY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                      // Capacity Indicator
                      userAgentAsync.when(
                        data: (agent) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Text(
                             // Fetching player count here ideally, but for now showing Cap
                            'Capacity: ${userAgentNotifier.capacity}', 
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        loading: () => const SizedBox(),
                        error: (_,__) => const SizedBox(),
                      ),
                    ],
                  ),
                ),

                // Player List
                Expanded(
                  child: myPlayersAsync.when(
                    data: (players) {
                      if (players.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_off_outlined, size: 60, color: Colors.white.withOpacity(0.3)),
                              const SizedBox(height: 20),
                              Text(
                                "No players signed yet.",
                                style: TextStyle(color: Colors.white.withOpacity(0.5)),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Go to 'Office' or 'Scout' to find talent.",
                                style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      }
                      
                      return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100), // Bottom padding for navbar
                        itemCount: players.length,
                        itemBuilder: (context, index) {
                          final player = players[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: GlassContainer(
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(8),
                                leading: CircleAvatar(
                                  backgroundColor: _getPositionColor(player.position),
                                  child: Text(
                                    player.position,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                ),
                                title: Text(
                                  player.name,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "Age: ${player.age} • OVR: ${player.ca}",
                                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                                ),
                                trailing: Text(
                                  _formatCurrency(player.marketValue),
                                  style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                   showDialog(
                                    context: context,
                                    builder: (context) => PlayerDetailDialog(player: player),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
                    error: (err, stack) => Center(child: Text("Error: $err", style: const TextStyle(color: Colors.red))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getPositionColor(String position) {
     if (['GK'].contains(position)) return Colors.orange;
     if (['DL', 'DC', 'DR'].contains(position)) return Colors.green;
     if (['DMC', 'MC', 'AMC', 'ML', 'MR'].contains(position)) return Colors.amber.shade700;
     if (['AML', 'AMR', 'ST', 'FWD'].contains(position)) return Colors.redAccent;
     return Colors.blueGrey;
  }

  String _formatCurrency(int value) {
    if (value >= 1000000) {
      return '€${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '€${(value / 1000).toStringAsFixed(0)}K';
    }
    return '€$value';
  }
}
