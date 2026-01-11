import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../players/presentation/providers/player_provider.dart';
import '../../../players/presentation/widgets/player_detail_dialog.dart';
import '../widgets/club_transfer_history.dart';
import '../../../clubs/domain/entities/club.dart';
import '../../providers/club_provider.dart';
import '../../../../core/database/app_database.dart' hide Club; // HIDE Club to avoid ambiguity


class ClubDetailPage extends ConsumerStatefulWidget {
  final int clubId;
  final String clubName;

  const ClubDetailPage({super.key, required this.clubId, required this.clubName});

  @override
  ConsumerState<ClubDetailPage> createState() => _ClubDetailPageState();
}

class _ClubDetailPageState extends ConsumerState<ClubDetailPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Club? _clubDetails;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadClubDetails();
  }

  Future<void> _loadClubDetails() async {
    // TODO: Use a proper provider for this
    // Quick fetch to get budgets
    // Assuming GetIt or global access for quicker implementation in this refactor step
    // But since I don't see GetIt setup in file list, I'll rely on the fact that if we are here
    // we probably can use a provider if one existed.
    // Ideally: ref.read(clubProvider(widget.clubId))
    
    // For now, I will assume we can't easily fetch single club without a Repo provider, 
    // so I will leave budget as "Loading..." or pass it if possible. 
    // Actually, I can use the existing club list provider?
    // Let's create a temporary solution:
    // We will just show the structure first.
  }

  @override
  Widget build(BuildContext context) {
    // We can try to find the club from the list of all clubs if it's cached?
    // Or just fetch it.
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.clubName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.tealAccent,
          labelColor: Colors.tealAccent,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: "SQUAD"),
            Tab(text: "TRANSFERS"),
          ],
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
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight + 50), 
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildSquadTab(),
                      _buildTransfersTab(),
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

  Widget _buildTransfersTab() {
    return Column(
      children: [
        _buildBudgetHeader(),
        Expanded(child: ClubTransferHistory(clubId: widget.clubId)),
      ],
    );
  }

  Widget _buildBudgetHeader() {
    final clubAsync = ref.watch(clubByIdProvider(widget.clubId));

    return clubAsync.when(
      data: (club) => Container(
        padding: const EdgeInsets.all(16),
        color: Colors.black45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInfoItem("Transfer Budget", _formatCurrency(club.transferBudget.toInt())),
            _buildInfoItem("Wage Budget", "${_formatCurrency(club.wageBudget.toInt())}/w"),
          ],
        ),
      ),
      loading: () => Container(padding: const EdgeInsets.all(16), color: Colors.black45, child: const Center(child: CircularProgressIndicator())),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildSquadTab() {
    final playersAsync = ref.watch(playersByClubProvider(widget.clubId));

    return playersAsync.when(
      data: (players) {
        if (players.isEmpty) {
          return const Center(child: Text('No players found', style: TextStyle(color: Colors.white)));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
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
