import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/constants.dart';
import '../../../leagues/presentation/providers/fixture_provider.dart';
import '../../../performances/presentation/providers/performance_provider.dart';
import '../../../performances/domain/entities/match_detail_stat.dart';

class MatchDetailDialog extends ConsumerWidget {
  final FixtureItem fixture;

  const MatchDetailDialog({super.key, required this.fixture});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final match = fixture.match;
    // Don't show for unplayed matches? User wants "past match".
    // If future, maybe show "vs" and "Not Played".
    
    final statsAsync = ref.watch(matchStatsProvider(match.id));

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12),
          boxShadow: [
             BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, spreadRadius: 2),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header (Scoreboard)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                children: [
                   Text(
                     'Week ${match.week}',
                     style: const TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                   ),
                   const SizedBox(height: 12),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Expanded(
                         child: Text(
                           fixture.homeClubName, 
                           textAlign: TextAlign.center, 
                           style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
                         ),
                       ),
                       Container(
                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                         decoration: BoxDecoration(
                           color: Colors.black45,
                           borderRadius: BorderRadius.circular(8),
                           border: Border.all(color: Colors.white12),
                         ),
                         child: Text(
                           match.isPlayed ? '${match.homeScore} - ${match.awayScore}' : 'vs',
                           style: const TextStyle(color: Colors.yellowAccent, fontSize: 24, fontWeight: FontWeight.bold),
                         ),
                       ),
                       Expanded(
                         child: Text(
                           fixture.awayClubName, 
                           textAlign: TextAlign.center, 
                           style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
                         ),
                       ),
                     ],
                   ),
                ],
              ),
            ),

            // Scorers / Stats
            if (match.isPlayed)
              Padding(
                padding: const EdgeInsets.all(16),
                child: statsAsync.when(
                  data: (stats) {
                    final homeEvents = _reconstructMatchEvents(stats, match.homeClubId);
                    final awayEvents = _reconstructMatchEvents(stats, match.awayClubId);

                    if (homeEvents.isEmpty && awayEvents.isEmpty) {
                       return const Text('No stats available', style: TextStyle(color: Colors.white54, fontStyle: FontStyle.italic));
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Home Events
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: homeEvents.map((e) => _buildEventItem(e, TextAlign.left)).toList(),
                          ),
                        ),
                        
                        // Divider
                        Container(width: 1, height: 80, color: Colors.white10),
                        
                        // Away Events
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: awayEvents.map((e) => _buildEventItem(e, TextAlign.right)).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  error: (err, stack) => Text('Error: $err', style: const TextStyle(color: Colors.red)),
                ),
              )
            else
               const Padding(
                 padding: EdgeInsets.all(32.0),
                 child: Text('Match Not Played Yet', style: TextStyle(color: Colors.white38)),
               ),

            // Close Button
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('CLOSE', style: TextStyle(color: Colors.white60)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventItem(_MatchEvent event, TextAlign align) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: align == TextAlign.left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
           // Scorer
           Text(
             event.scorerName,
             textAlign: align,
             style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
           ),
           // Assister (if any)
           if (event.assisterName != null)
             Text(
               '(A. ${event.assisterName})',
               textAlign: align,
               style: const TextStyle(color: Colors.white54, fontSize: 11),
             ),
        ],
      ),
    );
  }

  List<_MatchEvent> _reconstructMatchEvents(List<MatchDetailStat> stats, int clubId) {
    // Filter stats for this club
    final clubStats = stats.where((s) => s.clubId == clubId).toList();
    
    // Expand Goals
    List<String> scorers = [];
    for (var s in clubStats) {
      for (int i = 0; i < s.goals; i++) {
        scorers.add(s.playerName);
      }
    }
    
    // Expand Assists
    List<String> assisters = [];
    for (var s in clubStats) {
      for (int i = 0; i < s.assists; i++) {
        assisters.add(s.playerName);
      }
    }

    // Pair them (Simple approach: Queue based)
    // To respect "Self-Assist" constraint roughly:
    // We can just shuffle and hope, or do a simple check.
    // Given it's a visual approximation:
    assisters.shuffle(); 
    
    List<_MatchEvent> events = [];
    
    for (var scorer in scorers) {
       String? assister;
       if (assisters.isNotEmpty) {
           // Try to find an assister who is NOT the scorer
           try {
              assister = assisters.firstWhere((a) => a != scorer);
              assisters.remove(assister); // Remove specific instance
           } catch (e) {
              // If only self remains (rare but possible in loose reconstruction), just take it or none?
              // Simulation prevents generation, but reconstruction might corner itself.
              // Just take first if forced, or leave null.
              if (assisters.isNotEmpty) {
                 assister = assisters.removeAt(0);
              }
           }
       }
       events.add(_MatchEvent(scorer, assister));
    }
    
    return events;
  }
}

class _MatchEvent {
  final String scorerName;
  final String? assisterName;
  _MatchEvent(this.scorerName, this.assisterName);
}
