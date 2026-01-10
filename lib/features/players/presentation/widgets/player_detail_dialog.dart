import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../agents/providers/user_agent_provider.dart';
import '../../domain/entities/player.dart';
import '../../../clubs/domain/entities/club.dart';
import '../../../clubs/providers/club_provider.dart';
import 'negotiation_game_dialog.dart';

class PlayerDetailDialog extends ConsumerWidget {
  final Player player;

  const PlayerDetailDialog({super.key, required this.player});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 350,
        height: 500, // Fixed height or adjust as needed
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E).withOpacity(0.95), // Dark card
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            // Header: Avatar & Basic Info
            _buildHeader(ref),
            
            const Divider(color: Colors.white10),

            // Tabs / Stats Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildStatRow('Age', '${player.age}'),
                    _buildStatRow('Position', player.position),
                    const SizedBox(height: 20),
                    
                    _buildSectionTitle('Ability Report'),
                    const SizedBox(height: 10),
                    _buildStarRating('Current Ability', player.ca),
                    _buildStarRating('Potential Ability', player.pa),

                    const SizedBox(height: 20),
                    _buildSectionTitle('Contract / Value'),
                    const SizedBox(height: 10),
                    _buildStatRow('Market Value', _formatCurrency(player.marketValue)), // Added Market Value
                    _buildStatRow('Reputation', '${player.reputation} / 100'),
                    
                    // Club Name Fetcher
                    _buildClubRow(ref),
                  ],
                ),
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Close', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final notifier = ref.read(userAgentProvider.notifier);
                        
                        // Case 1: Already Managed -> Option to Release
                        if (player.agentId == 1) {
                           // Show Confirmation Dialog
                           final confirm = await showDialog<bool>(
                             context: context,
                             builder: (context) => AlertDialog(
                               backgroundColor: const Color(0xFF1E1E1E),
                               title: const Text("Terminate Contract?", style: TextStyle(color: Colors.white)),
                               content: Text("Are you sure you want to release ${player.name}? This cannot be undone.", style: const TextStyle(color: Colors.white70)),
                               actions: [
                                 TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
                                 TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Terminate", style: TextStyle(color: Colors.redAccent))),
                               ],
                             ),
                           );

                           if (confirm == true) {
                             await notifier.releasePlayer(player.id);
                             if (context.mounted) {
                               ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(content: Text('Contract Terminated: ${player.name} is now a free agent.'), backgroundColor: Colors.orangeAccent),
                               );
                               Navigator.of(context).pop();
                             }
                           }
                          return;
                        }

                        // Case 2: Sign Player (Negotiation Game)
                        // 1. Check Capacity BEFORE Game
                        final capacityCheck = await notifier.checkCapacity();
                        if (!capacityCheck) {
                           if (context.mounted) {
                             ScaffoldMessenger.of(context).showSnackBar(
                               const SnackBar(content: Text('Capacity Full! You cannot sign more players.'), backgroundColor: Colors.redAccent),
                             );
                           }
                           return;
                        }

                        // 2. Check Weekly Offer Limit
                        final canOffer = await notifier.checkCanMakeOffer();
                        if (!canOffer) {
                           if (context.mounted) {
                             ScaffoldMessenger.of(context).showSnackBar(
                               const SnackBar(content: Text('Weekly Offer Limit Reached! (Max 2 per week)'), backgroundColor: Colors.redAccent),
                             );
                           }
                           return;
                        }

                        // 3. Play Negotiation Game
                        // Consume Offer Attempt
                        await notifier.incrementOfferCount();

                        final userAgent = ref.read(userAgentProvider).value;
                        final managerRep = userAgent?.reputation ?? 0;
                        
                        // Show Negotiation Dialog
                        final success = await showDialog<bool>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => NegotiationGameDialog(
                            playerReputation: player.reputation, 
                            managerReputation: managerRep,
                            playerName: player.name,
                          ),
                        );

                        if (success != true) {
                           if (context.mounted) {
                             ScaffoldMessenger.of(context).showSnackBar(
                               const SnackBar(content: Text('Negotiation Failed! Player refused your offer.'), backgroundColor: Colors.red),
                             );
                           }
                           return; 
                        }

                        // 3. Sign Player (If game won)
                        final error = await notifier.signPlayer(player.id);

                        if (context.mounted) {
                          if (error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error), backgroundColor: Colors.red),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Negotiation Successful! ${player.name} joined your agency.'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.of(context).pop(); // Close dialog on success
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (player.agentId == 1) ? Colors.redAccent.withOpacity(0.8) : Colors.teal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        (player.agentId == 1) ? 'Terminate Contract' : 'Offer Representation',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildClubRow(WidgetRef ref) {
    if (player.clubId == null) {
      return _buildStatRow('Club', 'Free Agent');
    }

    return FutureBuilder(
      future: ref.read(clubRepositoryProvider).getClubById(player.clubId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
           return _buildStatRow('Club', 'Loading...');
        }
        if (snapshot.hasError) {
           return _buildStatRow('Club', 'Unknown');
        }
        
        final result = snapshot.data;
        return result!.fold(
          (failure) => _buildStatRow('Club', 'Unknown'),
          (club) => _buildStatRow('Club', club.name),
        );
      },
    );
  }

  Widget _buildHeader(WidgetRef ref) {
    // We can also fetch Club name for subtitle here if we want
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueGrey.shade900, Colors.blueGrey.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white10,
            child: Text(
              player.position,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.tealAccent),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Professional Footballer',
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white.withOpacity(0.6))),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.tealAccent.withOpacity(0.8),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  String _formatCurrency(int value) {
    if (value >= 1000000) {
      double millions = value / 1000000;
      // Show decimal only if needed (e.g. 1.5M, but 10M)
      return '€${millions.toStringAsFixed(millions.truncateToDouble() == millions ? 0 : 1)}M';
    } else if (value >= 1000) {
      return '€${(value / 1000).toStringAsFixed(0)}K';
    } else {
      return '€$value';
    }
  }

  Widget _buildStarRating(String label, int value) {
    // Value 1-100. Let's map to 5 stars.
    final stars = (value / 20).clamp(0.5, 5.0);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        Row(
          children: List.generate(5, (index) {
            if (index < stars.floor()) {
              return const Icon(Icons.star, color: Colors.amber, size: 16);
            } else if (index < stars && stars % 1 != 0) {
              return const Icon(Icons.star_half, color: Colors.amber, size: 16);
            } else {
              return Icon(Icons.star_border, color: Colors.grey.shade700, size: 16);
            }
          }),
        ),
      ],
    );
  }
}
