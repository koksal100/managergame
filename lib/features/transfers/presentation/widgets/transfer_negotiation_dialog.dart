import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart' hide Player;
import '../../../players/domain/entities/player.dart';
import '../../../clubs/providers/club_provider.dart';
import '../../providers/transfer_provider.dart';
import '../../domain/services/transfer_engine.dart';
import '../../../agents/providers/user_agent_provider.dart';
import '../../../players/presentation/providers/player_provider.dart';

// --- THEME CONSTANTS ---
const kDialogBgColor = Color(0xFF1E1E1E);
const kSurfaceColor = Color(0xFF2C2C2C);
const kAccentColor = Color(0xFF64FFDA); // Teal
const kMoneyColor = Color(0xFFFFD700); // Gold
const kDangerColor = Color(0xFFFF5252);
const kTextSecondary = Colors.white54;

class TransferNegotiationDialog extends ConsumerStatefulWidget {
  final Player player;
  final TransferNeed need;
  final int currentWeek;
  final int season;

  const TransferNegotiationDialog({
    super.key,
    required this.player,
    required this.need,
    required this.currentWeek,
    required this.season,
  });

  @override
  ConsumerState<TransferNegotiationDialog> createState() => _TransferNegotiationDialogState();
}

class _TransferNegotiationDialogState extends ConsumerState<TransferNegotiationDialog> {
  late double _offerAmount;
  late double _wageAmount;
  late int _years;

  @override
  void initState() {
    super.initState();
    // Default values
    _offerAmount = (widget.player.marketValue * 1.2).clamp(0, 500000000);
    _wageAmount = (widget.player.marketValue / 200).clamp(0, 5000000);
    _years = 3;
  }

  int get _probability {
    int score = 0;

    // 1. Fee Evaluation
    final maxBudget = widget.need.maxTransferBudget?.toDouble() ?? (widget.player.marketValue * 1.5);
    if (_offerAmount <= maxBudget * 0.8) {
      score += 40;
    } else if (_offerAmount <= maxBudget) {
      score += 20;
    } else if (_offerAmount <= maxBudget * 1.1) {
      score += 5;
    } else {
      score -= 50;
    }

    // 2. Wage Evaluation
    final maxWage = widget.need.maxWeeklySalary?.toDouble() ?? (_wageAmount * 1.5);
    if (_wageAmount <= maxWage * 0.8) {
      score += 30;
    } else if (_wageAmount <= maxWage) {
      score += 15;
    } else if (_wageAmount <= maxWage * 1.1) {
      score += 0;
    } else {
      score -= 30;
    }

    // 3. Player Fit Evaluation
    if (widget.need.minCa != null && widget.player.ca >= widget.need.minCa!) score += 20;

    // 4. Market Value Logic (Selling too cheap logic)
    if (_offerAmount < widget.player.marketValue * 0.5) score -= 20; // Suspiciously low

    return score.clamp(0, 100);
  }

  void _submitOffer() async {
    final probability = _probability;
    final randomValue = Random().nextInt(100);
    bool accepted = randomValue < probability;

    final engine = ref.read(transferEngineProvider);

    if (accepted) {
      await engine.createManualOffer(
        needId: widget.need.id,
        playerId: widget.player.id,
        fromClubId: widget.need.clubId,
        toClubId: widget.player.clubId!,
        amount: _offerAmount.toInt(),
        wage: _wageAmount.toInt(),
        years: _years,
        season: widget.season,
        week: widget.currentWeek,
        accepted: true,
      );

      // Invalidate Providers to refresh UI
      ref.invalidate(buyNeedsProvider);
      ref.invalidate(sellNeedsProvider);
      ref.invalidate(activeOffersProvider);
      ref.invalidate(completedTransfersProvider);
      
      // Refresh Agent's Player List
      ref.invalidate(userAgentProvider); // Refresh Balance/Reputation
      final agentState = ref.read(userAgentProvider);
      if (agentState.value != null) {
        ref.invalidate(playersByAgentProvider(agentState.value!.id));
      }

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(children: const [Icon(Icons.check_circle, color: Colors.white), SizedBox(width: 8), Text('Offer Accepted! Deal Sealed.')]),
            backgroundColor: Colors.green[700],
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } else {
      // ...
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(children: const [Icon(Icons.error_outline, color: Colors.white), SizedBox(width: 8), Text('Offer Rejected. Club walked away.')]),
            backgroundColor: Colors.red[700],
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Probability Color Logic
    final prob = _probability;
    Color probColor = prob >= 75 ? Colors.greenAccent : (prob >= 40 ? Colors.amber : kDangerColor);

    // Fetch Club Name
    final clubFuture = ref.watch(clubRepositoryProvider).getClubById(widget.need.clubId);

    return Dialog(
      backgroundColor: kDialogBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      insetPadding: const EdgeInsets.all(16),
      child: FutureBuilder(
          future: clubFuture,
          builder: (context, snapshot) {
            final clubName = (snapshot.data as dynamic)?.fold((l) => 'Unknown Club', (r) => r.name) ?? '...';

            return Container(
              padding: const EdgeInsets.all(20),
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- HEADER ---
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.handshake_rounded, color: kAccentColor, size: 24),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('NEGOTIATION', style: TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
                            Text(clubName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white10, height: 24),

                  // --- PLAYER PROFILE ---
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kSurfaceColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kAccentColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            widget.player.position,
                            style: const TextStyle(color: kAccentColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.player.name,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${widget.player.age} yrs • CA: ${widget.player.ca} • ${_formatCurrency(widget.player.marketValue.toDouble())}',
                                style: const TextStyle(color: Colors.white54, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(color: Colors.white10, height: 24),

                  // --- CONTROLS ---

                  // 1. Fee Slider
                  _buildMoneySlider(
                    label: 'TRANSFER FEE',
                    value: _offerAmount,
                    min: 0,
                    max: (widget.need.maxTransferBudget?.toDouble() ?? 100000000) * 2.5,
                    onChanged: (v) => setState(() => _offerAmount = v),
                    referenceValue: widget.player.marketValue.toDouble(),
                    referenceLabel: 'Market Val',
                  ),

                  const SizedBox(height: 20),

                  // 2. Wage Slider
                  _buildMoneySlider(
                    label: 'WEEKLY WAGE',
                    value: _wageAmount,
                    min: 0,
                    max: (widget.need.maxWeeklySalary?.toDouble() ?? 500000) * 2.5,
                    onChanged: (v) => setState(() => _wageAmount = v),
                    isWage: true,
                  ),

                  const SizedBox(height: 20),

                  // 3. Contract Length
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('CONTRACT LENGTH', style: TextStyle(color: kTextSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
                      Container(
                        decoration: BoxDecoration(color: kSurfaceColor, borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            _buildCountBtn(icon: Icons.remove, onPressed: () => setState(() => _years = max(1, _years - 1))),
                            SizedBox(
                              width: 60,
                              child: Text(
                                  '$_years Yrs',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                              ),
                            ),
                            _buildCountBtn(icon: Icons.add, onPressed: () => setState(() => _years = min(5, _years + 1))),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Divider(color: Colors.white10, height: 40),

                  // --- PROBABILITY & ACTIONS ---

                  // Probability Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('ACCEPTANCE CHANCE', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
                      Text('$prob%', style: TextStyle(color: probColor, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: prob / 100,
                      minHeight: 6,
                      backgroundColor: Colors.white10,
                      valueColor: AlwaysStoppedAnimation<Color>(probColor),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                          child: const Text('CANCEL', style: TextStyle(color: Colors.white38)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _submitOffer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kAccentColor,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          child: const Text('SUBMIT OFFER', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildMoneySlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required Function(double) onChanged,
    double? referenceValue,
    String? referenceLabel,
    bool isWage = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(label, style: const TextStyle(color: kTextSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
            Text(
                _formatCurrency(value) + (isWage ? '/w' : ''),
                style: TextStyle(color: isWage ? kAccentColor : kMoneyColor, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'monospace')
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: isWage ? kAccentColor : kMoneyColor,
            inactiveTrackColor: Colors.white10,
            thumbColor: Colors.white,
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
        if (referenceValue != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    '$referenceLabel: ${_formatCurrency(referenceValue)}',
                    style: const TextStyle(color: Colors.white24, fontSize: 10)
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCountBtn({required IconData icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: Colors.white54, size: 16),
      ),
    );
  }

  String _formatCurrency(double value) {
    if (value >= 1000000) return '€${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '€${(value / 1000).toStringAsFixed(0)}K';
    return '€${value.toStringAsFixed(0)}';
  }
}