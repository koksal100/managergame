import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widgets/glass_container.dart';
import '../../../agents/providers/user_agent_provider.dart';
import '../../../contracts/presentation/pages/contracts_page.dart';
import '../../../office/providers/office_provider.dart';
import '../providers/player_provider.dart';
import '../widgets/player_detail_dialog.dart';

class PlayersPage extends ConsumerStatefulWidget {
  const PlayersPage({super.key});

  @override
  ConsumerState<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends ConsumerState<PlayersPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (!_tabController.indexIsChanging) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/players_background.png',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.45),
                  Colors.black.withOpacity(0.84),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _ClubAppBar(tabController: _tabController),
                _ClubTabSummary(selectedIndex: _tabController.index),
                const SizedBox(height: 8),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      _MyAgencyTab(),
                      OfficeManagementPanel(
                        bottomPadding: 120,
                        showHeader: false,
                      ),
                    ],
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

class _ClubAppBar extends StatelessWidget {
  final TabController tabController;

  const _ClubAppBar({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.tealAccent,
        indicatorWeight: 2,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white54,
        dividerColor: Colors.white10,
        labelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.7,
        ),
        tabs: const [
          Tab(text: 'MY AGENCY'),
          Tab(text: 'OFFICE'),
        ],
      ),
    );
  }
}

class _ClubTabSummary extends ConsumerWidget {
  final int selectedIndex;

  const _ClubTabSummary({required this.selectedIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      child: selectedIndex == 0
          ? const _AgencySummary(key: ValueKey('agency-summary'))
          : const _OfficeSummary(key: ValueKey('office-summary')),
    );
  }
}

class _AgencySummary extends ConsumerWidget {
  const _AgencySummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAgentAsync = ref.watch(userAgentProvider);
    final userAgentNotifier = ref.read(userAgentProvider.notifier);
    final myPlayersAsync = ref.watch(playersByAgentProvider(1));

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        children: [
          _SummaryChip(
            icon: Icons.group,
            text: myPlayersAsync.maybeWhen(
              data: (players) =>
                  '${players.length}/${userAgentNotifier.capacity} Players',
              orElse: () => 'Capacity ${userAgentNotifier.capacity}',
            ),
            color: Colors.blueAccent,
          ),
          const SizedBox(width: 10),
          userAgentAsync.when(
            data: (agent) => _SummaryChip(
              icon: Icons.star,
              text: 'Rep ${agent?.reputation ?? 0}',
              color: Colors.amberAccent,
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _OfficeSummary extends ConsumerWidget {
  const _OfficeSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAgentAsync = ref.watch(userAgentProvider);
    final totalCostAsync = ref.watch(officeStaffCostProvider(1));

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        children: [
          userAgentAsync.when(
            data: (agent) => _SummaryChip(
              icon: Icons.attach_money,
              text: '\$${agent?.balance.toStringAsFixed(0) ?? '0'}',
              color: Colors.greenAccent,
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(width: 10),
          totalCostAsync.when(
            data: (cost) => _SummaryChip(
              icon: Icons.payments_outlined,
              text: '-\$$cost / week',
              color: Colors.redAccent,
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _SummaryChip({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.28),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 15),
          const SizedBox(width: 6),
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

class _MyAgencyTab extends ConsumerWidget {
  const _MyAgencyTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myPlayersAsync = ref.watch(playersByAgentProvider(1));

    return myPlayersAsync.when(
      data: (players) {
        if (players.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_off_outlined,
                  size: 60,
                  color: Colors.white.withOpacity(0.3),
                ),
                const SizedBox(height: 20),
                Text(
                  "No players signed yet.",
                  style: TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
                const SizedBox(height: 10),
                Text(
                  "Go to Scout to find talent.",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.3),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  title: Text(
                    player.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Age: ${player.age} • OVR: ${player.ca}",
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                  trailing: Text(
                    _formatCurrency(player.marketValue),
                    style: const TextStyle(
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.bold,
                    ),
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
      loading: () =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
      error: (err, stack) => Center(
        child: Text("Error: $err", style: const TextStyle(color: Colors.red)),
      ),
    );
  }
}

Color _getPositionColor(String position) {
  if (['GK'].contains(position)) return Colors.orange;
  if (['DL', 'DC', 'DR'].contains(position)) return Colors.green;
  if (['DMC', 'MC', 'AMC', 'ML', 'MR'].contains(position)) {
    return Colors.amber.shade700;
  }
  if (['AML', 'AMR', 'ST', 'FWD'].contains(position)) {
    return Colors.redAccent;
  }
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
