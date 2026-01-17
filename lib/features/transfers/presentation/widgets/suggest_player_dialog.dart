import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart' hide Player;
import '../../../players/domain/entities/player.dart';
import '../../../players/presentation/providers/player_provider.dart';
import '../../../agents/providers/user_agent_provider.dart';
import 'transfer_negotiation_dialog.dart';

// --- SABİT RENKLER ---
const kDialogBgColor = Color(0xFF1E1E1E);
const kCardBgColor = Color(0xFF2C2C2C);
const kAccentColor = Color(0xFF64FFDA); // Teal
const kMoneyColor = Color(0xFFFFD700); // Gold
const kDangerColor = Color(0xFFFF5252);

class SuggestPlayerDialog extends ConsumerWidget {
  final TransferNeed need;
  final int currentWeek;
  final int season;

  const SuggestPlayerDialog({
    super.key,
    required this.need,
    required this.currentWeek,
    required this.season,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAgent = ref.watch(userAgentProvider).value;
    if (userAgent == null) return const SizedBox();

    final playersAsync = ref.watch(playersByAgentProvider(userAgent.id));

    return Dialog(
      backgroundColor: kDialogBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 450, maxHeight: 700),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER: CLUB NEEDS ---
            _buildHeaderInfo(),
            const SizedBox(height: 20),

            // --- PLAYER LIST ---
            Expanded(
              child: playersAsync.when(
                data: (players) {
                  final validPlayers = players
                      .where((p) => p.clubId != need.clubId)
                      .toList();

                  if (validPlayers.isEmpty) {
                    return _buildEmptyState();
                  }

                  return ListView.separated(
                    itemCount: validPlayers.length,
                    separatorBuilder: (c, i) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final player = validPlayers[index];
                      bool isFit = _checkFit(player, need);
                      return _buildPlayerCard(context, player, isFit);
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(color: kAccentColor),
                ),
                error: (e, s) => Center(
                  child: Text(
                    'Error: $e',
                    style: const TextStyle(color: kDangerColor),
                  ),
                ),
              ),
            ),

            // --- FOOTER ACTION ---
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(foregroundColor: Colors.white54),
                child: const Text('CANCEL', style: TextStyle(letterSpacing: 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER: Header ---
  Widget _buildHeaderInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SELECT PLAYER TO SUGGEST',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRequirementBadge(
                'POSITION',
                need.targetPosition ?? 'ANY',
                kAccentColor,
              ),
              _buildRequirementBadge(
                'MIN CA',
                '${need.minCa ?? 0}',
                Colors.white,
              ),
              _buildRequirementBadge(
                'MAX SALARY',
                _formatCompact(need.maxWeeklySalary ?? 0),
                kMoneyColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRequirementBadge(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // --- WIDGET HELPER: Player Card ---
  Widget _buildPlayerCard(BuildContext context, Player player, bool isFit) {
    return Container(
      decoration: BoxDecoration(
        color: kCardBgColor,
        borderRadius: BorderRadius.circular(12),
        border: isFit
            ? Border.all(color: kAccentColor.withOpacity(0.5), width: 1.5)
            : null,
        boxShadow: isFit
            ? [BoxShadow(color: kAccentColor.withOpacity(0.1), blurRadius: 8)]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: isFit ? () {
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (context) => TransferNegotiationDialog(
                player: player,
                need: need,
                currentWeek: currentWeek,
                season: season,
              ),
            );
          } : null,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Opacity(
              opacity: isFit ? 1.0 : 0.5,
              child: Row(
                children: [
                  // 1. Position Circle
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isFit
                          ? kAccentColor.withOpacity(0.2)
                          : Colors.white10,
                    ),
                  child: Text(
                    player.position,
                    style: TextStyle(
                      color: isFit ? kAccentColor : Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // 2. Info Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            player.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (isFit) ...[
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.check_circle,
                              size: 14,
                              color: kAccentColor,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _buildStatTag('${player.ca}', Colors.white),
                          const SizedBox(width: 8),
                          _buildStatTag('${player.age} yrs', Colors.white54),
                          const SizedBox(width: 8),
                          Text(
                            _formatCurrency(player.marketValue),
                            style: const TextStyle(
                              color: kMoneyColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 3. Action Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isFit ? kAccentColor : Colors.white10,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: isFit ? Colors.black : Colors.white54,
                  ),
                ),
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off_outlined,
            size: 48,
            color: Colors.white.withOpacity(0.2),
          ),
          const SizedBox(height: 12),
          const Text(
            'No available players',
            style: TextStyle(color: Colors.white38),
          ),
        ],
      ),
    );
  }

  // --- LOGIC HELPER ---
  bool _checkFit(Player player, TransferNeed need) {
    if (need.targetPosition != null &&
        need.targetPosition != 'Any' &&
        need.targetPosition != _mapPosition(player.position))
      return false;
    if (need.minCa != null && player.ca < need.minCa!) return false;
    return true;
  }

  String _mapPosition(String pos) {
    if (['CB', 'RB', 'LB', 'RWB', 'LWB'].contains(pos)) return 'DEF';
    if (['CM', 'DM', 'AM', 'LM', 'RM'].contains(pos)) return 'MID';
    if (['ST', 'LW', 'RW', 'CF'].contains(pos)) return 'FWD';
    if (['GK'].contains(pos)) return 'GK';
    return pos;
  }

  String _formatCurrency(int value) {
    if (value >= 1000000) return '€${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '€${(value / 1000).toStringAsFixed(0)}K';
    return '€$value';
  }

  String _formatCompact(int value) {
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(0)}K';
    return '$value';
  }
}
