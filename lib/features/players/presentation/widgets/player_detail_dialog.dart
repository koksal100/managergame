import 'dart:ui'; // ImageFilter için gerekli
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../agents/providers/user_agent_provider.dart';
import '../../domain/entities/player.dart';
import '../../../clubs/domain/entities/club.dart';
import '../../../clubs/providers/club_provider.dart';
import '../../../contracts/providers/contract_provider.dart';
import 'negotiation_game_dialog.dart';
import 'player_history_tab.dart';

class PlayerDetailDialog extends ConsumerWidget {
  final Player player;

  const PlayerDetailDialog({super.key, required this.player});

  // Renk Paleti
  static final Color _cardBg = const Color(0xFF1E1E1E).withOpacity(0.90);
  static const Color _accentColor = Colors.tealAccent;
  static const Color _dangerColor = Colors.redAccent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Buzlu cam efekti
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400, maxHeight: 650),
            decoration: BoxDecoration(
              color: _cardBg,
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 30, spreadRadius: 5),
              ],
            ),
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  // 1. Header Area
                  _buildHeader(player),
                  
                  // Tab Bar
                  const TabBar(
                    indicatorColor: _accentColor,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white54,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(text: "Overview"),
                      Tab(text: "History"),
                    ],
                  ),

                  // 2. Tab Content
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildOverviewTab(ref),
                        PlayerHistoryTab(player: player),
                      ],
                    ),
                  ),

                  // 3. Bottom Actions
                  _buildActionButtons(context, ref),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewTab(WidgetRef ref) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Temel Bilgiler Kartı
          _buildInfoCard([
            _buildStatRow('Age', '${player.age}', icon: Icons.cake),
            _buildStatRow('Position', player.position, icon: Icons.sports_soccer),
            _buildStatRow('Market Value', _formatCurrency(player.marketValue), icon: Icons.monetization_on, valueColor: _accentColor),
            _buildStatRow('Reputation', '${player.reputation} / 100', icon: Icons.trending_up),
          ]),

          const SizedBox(height: 20),
          _buildSectionTitle('Scout Report'),
          const SizedBox(height: 10),

          // Yetenek Barları (FM Style)
          _buildAbilityBar('Current Ability', player.ca),
          const SizedBox(height: 8),
          _buildAbilityBar('Potential Ability', player.pa.toDouble(), isPotential: true),

          const SizedBox(height: 20),
          _buildSectionTitle('Career Info'),
          const SizedBox(height: 10),

          // Kulüp ve Menajer Bilgisi
          _buildClubRow(ref),
          const SizedBox(height: 8),
          _buildAgentRow(ref),
        ],
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildHeader(Player player) {
    return Stack(
      children: [
        Container(
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey.shade900, Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          top: -20,
          right: -20,
          child: Icon(Icons.shield, size: 150, color: Colors.white.withOpacity(0.05)),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _accentColor, width: 2),
                  boxShadow: [BoxShadow(color: _accentColor.withOpacity(0.3), blurRadius: 10)],
                ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey.shade800,
                  child: Text(
                    player.position,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.name,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, height: 1.1),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Professional Footballer',
                        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 10, letterSpacing: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildStatRow(String label, String value, {IconData? icon, Color? valueColor, Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: Colors.white54),
            const SizedBox(width: 8),
          ],
          Text(label, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13)),
          const Spacer(),
          Text(value, style: TextStyle(color: valueColor ?? Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
          if (trailing != null) ...[const SizedBox(width: 8), trailing],
        ],
      ),
    );
  }

  Widget _buildAbilityBar(String label, double value, {bool isPotential = false}) {
    final double percentage = (value / 100).clamp(0.0, 1.0);
    final Color barColor = isPotential ? Colors.amber : (value > 80 ? Colors.greenAccent : (value > 50 ? Colors.blueAccent : Colors.orangeAccent));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            Text("${value.toStringAsFixed(1)}/100", style: TextStyle(color: barColor, fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey.shade800,
            color: barColor,
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color: _accentColor.withOpacity(0.8),
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildClubRow(WidgetRef ref) {
    final clubFuture = player.clubId != null
        ? ref.watch(clubRepositoryProvider).getClubById(player.clubId!)
        : null;

    return _buildInteractiveRow(
      ref: ref,
      icon: Icons.shield_outlined,
      label: 'Club',
      futureValue: clubFuture == null
          ? Future.value('Free Agent')
          : clubFuture.then((res) => res.fold((l) => 'Unknown', (r) => r.name)),
      onTap: () async {
        if(player.clubId == null) return;
        final contract = await ref.read(playerClubContractProvider(player.id).future);
        if (contract != null && ref.context.mounted) {
          _showContractDetails(ref.context, "Club Contract", [
            MapEntry("Weekly Salary", _formatCurrency(contract.weeklySalary)),
            MapEntry("Duration", "${_formatDate(contract.startDate)} - ${_formatDate(contract.endDate)}"),
            if (contract.releaseClause != null) MapEntry("Release Clause", _formatCurrency(contract.releaseClause!)),
          ]);
        }
      },
    );
  }

  Widget _buildAgentRow(WidgetRef ref) {
    return _buildInteractiveRow(
      ref: ref,
      icon: Icons.person_outline,
      label: 'Agent',
      // Burası gerçek Agent adı çekmek için güncellenmeli, şimdilik statik
      futureValue: Future.value(player.agentId == 1 ? 'You (My Agency)' : (player.agentId != null ? 'Other Agent' : 'None')),
      onTap: () async {
        if(player.agentId == null) return;
        final contract = await ref.read(playerAgentContractProvider(player.id).future);
        if (contract != null && ref.context.mounted) {
          _showContractDetails(ref.context, "Agent Contract", [
            MapEntry("Fee Percentage", "%${contract.feePercentage}"),
            MapEntry("Duration", "${_formatDate(contract.startDate)} - ${_formatDate(contract.endDate)}"),
          ]);
        }
      },
    );
  }

  Widget _buildInteractiveRow({
    required WidgetRef ref,
    required IconData icon,
    required String label,
    required Future<String> futureValue,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11)),
                    FutureBuilder<String>(
                      future: futureValue,
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data ?? '...',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white24, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    final bool isMyPlayer = player.agentId == 1;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white70,
                side: BorderSide(color: Colors.white.withOpacity(0.2)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Close'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () => isMyPlayer
                  ? _handleTerminate(context, ref)
                  : _handleNegotiation(context, ref),
              style: ElevatedButton.styleFrom(
                backgroundColor: isMyPlayer ? _dangerColor.withOpacity(0.2) : _accentColor,
                foregroundColor: isMyPlayer ? _dangerColor : Colors.black,
                elevation: isMyPlayer ? 0 : 5,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                isMyPlayer ? 'Terminate Contract' : 'Offer Representation',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- LOGIC METHODS (Code Separation) ---

  Future<void> _handleTerminate(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(userAgentProvider.notifier);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2C),
        title: const Text("Terminate Contract?", style: TextStyle(color: Colors.white)),
        content: Text("Are you sure you want to release ${player.name}? This cannot be undone.",
            style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancel")),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Terminate", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await notifier.releasePlayer(player.id);
      if (context.mounted) {
        Navigator.of(context).pop(); // Close Dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${player.name} released.'),
            backgroundColor: Colors.orangeAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _handleNegotiation(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(userAgentProvider.notifier);

    // 1. Check Capacity
    if (!await notifier.checkCapacity()) {
      if (context.mounted) _showSnack(context, 'Capacity Full!', isError: true);
      return;
    }

    // 2. Check Offer Limit
    if (!await notifier.checkCanMakeOffer()) {
      if (context.mounted) _showSnack(context, 'Weekly Offer Limit Reached!', isError: true);
      return;
    }

    // 3. Play Game
    await notifier.incrementOfferCount();
    final userAgent = ref.read(userAgentProvider).value;
    final managerRep = userAgent?.reputation ?? 0;

    if (!context.mounted) return;

    final success = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => NegotiationGameDialog(
        playerReputation: player.reputation,
        managerReputation: managerRep,
        playerName: player.name,
      ),
    );

    if (success != true) {
      if (context.mounted) _showSnack(context, 'Negotiation Failed.', isError: true);
      return;
    }

    // 4. Sign Player
    final error = await notifier.signPlayer(player.id);
    if (context.mounted) {
      if (error != null) {
        _showSnack(context, error, isError: true);
      } else {
        Navigator.of(context).pop(); // Close Main Dialog
        _showSnack(context, 'Success! ${player.name} joined your agency.', isError: false);
      }
    }
  }

  void _showSnack(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.teal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showContractDetails(BuildContext context, String title, List<MapEntry<String, String>> details) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder( borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (c) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(color: Colors.white24, height: 30),
            ...details.map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(e.key, style: const TextStyle(color: Colors.white60)),
                  Text(e.value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- FORMATTERS ---

  String _formatCurrency(int value) {
    if (value >= 1000000) {
      double millions = value / 1000000;
      return '€${millions.toStringAsFixed(millions.truncateToDouble() == millions ? 0 : 1)}M';
    } else if (value >= 1000) {
      return '€${(value / 1000).toStringAsFixed(0)}K';
    }
    return '€$value';
  }

  String _formatDate(DateTime date) => "${date.day}/${date.month}/${date.year}";
}