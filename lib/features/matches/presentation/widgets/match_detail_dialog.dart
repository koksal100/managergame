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
                    final homeScorers = stats.where((s) => s.clubId == match.homeClubId && s.goals > 0).toList();
                    final awayScorers = stats.where((s) => s.clubId == match.awayClubId && s.goals > 0).toList();
                    
                    if (homeScorers.isEmpty && awayScorers.isEmpty) {
                       return const Text('No goals', style: TextStyle(color: Colors.white54, fontStyle: FontStyle.italic));
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Home Scorers
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Align left for home? Or center? usually simpler
                            children: homeScorers.map((s) => _buildScorerItem(s, TextAlign.left)).toList(),
                          ),
                        ),
                        // Divider
                        Container(width: 1, height: 40, color: Colors.white10),
                        // Away Scorers
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: awayScorers.map((s) => _buildScorerItem(s, TextAlign.right)).toList(),
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

  Widget _buildScorerItem(MatchDetailStat stat, TextAlign align) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        '${stat.playerName} (${stat.goals})',
        textAlign: align,
        style: const TextStyle(color: Colors.white70, fontSize: 14),
      ),
    );
  }
}
