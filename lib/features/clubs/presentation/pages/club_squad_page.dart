import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../players/presentation/providers/player_provider.dart';
import '../../../players/presentation/widgets/player_detail_dialog.dart';
import '../../../clubs/domain/entities/club.dart'; // Ensure you have this import or passed name directly

class ClubSquadPage extends ConsumerWidget {
  final int clubId;
  final String clubName;

  const ClubSquadPage({super.key, required this.clubId, required this.clubName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsync = ref.watch(playersByClubProvider(clubId));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(clubName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),

          // Content
          playersAsync.when(
            data: (players) {
              if (players.isEmpty) {
                return const Center(child: Text('No players found', style: TextStyle(color: Colors.white)));
              }
              return ListView.builder(
                padding: const EdgeInsets.only(top: 100, bottom: 20, left: 16, right: 16),
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final player = players[index];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => PlayerDetailDialog(player: player),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Row(
                        children: [
                          // Position Circle
                          Container(
                            width: 36,
                            height: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _getPositionColor(player.position),
                              border: Border.all(color: Colors.white30, width: 1),
                            ),
                            child: Text(
                              player.position.substring(0, 1),
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          const SizedBox(width: 16),
                          
                          // Name and Age
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  player.name,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                  Text(
                                  'Age: ${player.age} | Rat: ${player.ca} | Val: ${_formatCurrency(player.marketValue)}',
                                  style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          
                          const Icon(Icons.info_outline, color: Colors.white54, size: 20),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator(color: Colors.teal)),
            error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.redAccent))),
          ),
        ],
      ),
    );
  }

  Color _getPositionColor(String position) {
    if (['GK'].contains(position)) return Colors.orange; // GK: Orange
    if (['DL', 'DC', 'DR', 'DEF'].contains(position)) return Colors.green; // Defenders: Green
    if (['DMC', 'MC', 'AMC', 'ML', 'MR', 'MID'].contains(position)) return Colors.amber; // Midfielders: Yellow/Amber
    if (['AML', 'AMR', 'ST', 'FWD'].contains(position)) return Colors.blue.shade900; // Forwards: Dark Blue
    return Colors.grey;
  }

  String _formatCurrency(int value) {
    if (value >= 1000000) {
      double millions = value / 1000000;
      return '€${millions.toStringAsFixed(millions.truncateToDouble() == millions ? 0 : 1)}M';
    } else if (value >= 1000) {
      return '€${(value / 1000).toStringAsFixed(0)}K';
    } else {
      return '€$value';
    }
  }
}
