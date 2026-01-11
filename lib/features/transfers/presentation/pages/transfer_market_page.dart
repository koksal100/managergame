import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../providers/transfer_provider.dart';
import '../../../clubs/providers/club_provider.dart';
import '../../../players/providers/player_provider.dart';
import '../../../players/presentation/widgets/player_detail_dialog.dart';

class TransferMarketPage extends ConsumerWidget {
  const TransferMarketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buyNeedsAsync = ref.watch(buyNeedsProvider);
    final sellNeedsAsync = ref.watch(sellNeedsProvider);
    final activeOffersAsync = ref.watch(activeOffersProvider);
    final completedTransfersAsync = ref.watch(completedTransfersProvider);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Transfer Market', style: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: TabBar(
            indicatorColor: Colors.tealAccent,
            labelColor: Colors.tealAccent,
            unselectedLabelColor: Colors.white54,
            isScrollable: false, // Force fit on screen
            labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold), // Smaller font
            labelPadding: const EdgeInsets.symmetric(horizontal: 4), // Reduce padding
            tabs: const [
              Tab(text: 'SELL LISTINGS'),
              Tab(text: 'BUY REQUESTS'),
              Tab(text: 'OFFERS'),
              Tab(text: 'COMPLETED'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Sell Needs Tab
            sellNeedsAsync.when(
              data: (needs) => _buildNeedsList(ref, needs, isBuy: false),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.red))),
            ),
            // Buy Needs Tab
            buyNeedsAsync.when(
              data: (needs) => _buildNeedsList(ref, needs, isBuy: true),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.red))),
            ),
            // Active Offers Tab
            activeOffersAsync.when(
              data: (offers) => _buildActiveOffersList(offers),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.red))),
            ),
            // Completed Transfers Tab
            completedTransfersAsync.when(
              data: (transfers) => _buildCompletedTransfersList(ref, transfers),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: Colors.red))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveOffersList(List<TransferOffer> offers) {
    if (offers.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pending_actions, size: 64, color: Colors.white24),
            SizedBox(height: 16),
            Text('No active offers pending', style: TextStyle(color: Colors.white54, fontSize: 16)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: offers.length,
      itemBuilder: (context, index) {
        return _ActiveOfferCard(offer: offers[index]);
      },
    );
  }

  Widget _buildNeedsList(WidgetRef ref, List<TransferNeed> needs, {required bool isBuy}) {
    if (needs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isBuy ? Icons.search_off : Icons.sell_outlined, size: 64, color: Colors.white24),
            const SizedBox(height: 16),
            Text(
              isBuy ? 'No clubs looking to buy' : 'No players for sale',
              style: const TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: needs.length,
      itemBuilder: (context, index) {
        final need = needs[index];
        return _TransferNeedCard(need: need, isBuy: isBuy);
      },
    );
  }

  Widget _buildCompletedTransfersList(WidgetRef ref, List<Transfer> transfers) {
    final currentSort = ref.watch(completedTransfersSortProvider);

    return Column(
      children: [
        // Sort Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
            color: Colors.black12,
            border: Border(bottom: BorderSide(color: Colors.white10)),
          ),
          child: Row(
            children: [
              const Icon(Icons.sort, color: Colors.white54, size: 16),
              const SizedBox(width: 8),
              const Text('Sort by:', style: TextStyle(color: Colors.white54, fontSize: 13)),
              const SizedBox(width: 12),
              _buildSortChip(ref, currentSort, 'Date', TransferSort.dateDesc),
              const SizedBox(width: 8),
              _buildSortChip(ref, currentSort, 'Fee', TransferSort.feeDesc),
            ],
          ),
        ),

        // List Content
        Expanded(
          child: transfers.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history_toggle_off, size: 64, color: Colors.white24),
                      SizedBox(height: 16),
                      Text('No transfers completed yet', style: TextStyle(color: Colors.white54, fontSize: 16)),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: transfers.length,
                  itemBuilder: (context, index) {
                    return _CompletedTransferCard(transfer: transfers[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildSortChip(WidgetRef ref, TransferSort currentSort, String label, TransferSort sortValue) {
    final isSelected = currentSort == sortValue;
    return GestureDetector(
      onTap: () {
        ref.read(completedTransfersSortProvider.notifier).state = sortValue;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.tealAccent.withOpacity(0.2) : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.tealAccent : Colors.white12,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.tealAccent : Colors.white70,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _ActiveOfferCard extends ConsumerWidget {
  final TransferOffer offer;

  const _ActiveOfferCard({required this.offer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fromClubFuture = ref.watch(clubRepositoryProvider).getClubById(offer.fromClubId);
    final toClubFuture = ref.watch(clubRepositoryProvider).getClubById(offer.toClubId);
    final playerFuture = ref.watch(playerRepositoryProvider).getPlayerById(offer.playerId);

    return FutureBuilder(
      future: Future.wait([fromClubFuture, toClubFuture, playerFuture]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        final fromClub = (snapshot.data![0] as dynamic).fold((l) => null, (r) => r);
        final toClub = (snapshot.data![1] as dynamic).fold((l) => null, (r) => r);
        final player = (snapshot.data![2] as dynamic).fold((l) => null, (r) => r);

        if (player == null) return const SizedBox();

        return Card(
          color: Colors.white.withOpacity(0.05),
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => PlayerDetailDialog(player: player),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.amber.withOpacity(0.5)),
                        ),
                        child: const Text(
                          'PENDING',
                          style: TextStyle(color: Colors.amber, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Amount
                      Text(
                        _formatCurrency(offer.offerAmount),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white10, height: 24),
                  Row(
                    children: [
                      // From Club (Bidder)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(fromClub?.name ?? 'Unknown', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                            Text('Bidder', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10)),
                          ],
                        ),
                      ),
                      // Arrow
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.arrow_forward, color: Colors.white24, size: 16),
                      ),
                      // To Club (Owner)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(toClub?.name ?? 'Unknown', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                            Text('Owner', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Player Name
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        player.name,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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

class _TransferNeedCard extends ConsumerWidget {
  final TransferNeed need;
  final bool isBuy;

  const _TransferNeedCard({required this.need, required this.isBuy});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubFuture = ref.watch(clubRepositoryProvider).getClubById(need.clubId);

    // Fetch player if it's a sell need
    final playerFuture = (!isBuy && need.playerToSellId != null)
        ? ref.watch(playerRepositoryProvider).getPlayerById(need.playerToSellId!)
        : Future.value(null);

    return FutureBuilder(
      future: Future.wait([clubFuture, playerFuture]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();

        final club = (snapshot.data![0] as dynamic).fold((l) => null, (r) => r);
        final playerResult = snapshot.data![1];
        final player = (playerResult is! Future && playerResult != null)
             ? (playerResult as dynamic).fold((l) => null, (r) => r)
             : null;

        final clubName = club?.name ?? 'Unknown';

        // Determine Main Title and Subtitle
        String mainTitle = clubName;
        String? subtitle;
        IconData icon = isBuy ? Icons.add_shopping_cart : Icons.sell;
        Color color = isBuy ? Colors.greenAccent : Colors.orangeAccent;

        if (!isBuy && player != null) {
          mainTitle = player.name;
          subtitle = clubName; // Club name becomes subtitle
        } else if (isBuy) {
           subtitle = 'Looking to Buy';
        } else {
           subtitle = 'Looking to Sell';
        }

        return Card(
          color: Colors.white.withOpacity(0.05),
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: () {
               if (player != null) {
                 showDialog(
                   context: context,
                   builder: (context) => PlayerDetailDialog(player: player),
                 );
               }
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: isBuy ? Colors.green.withOpacity(0.2) : Colors.orange.withOpacity(0.2),
                        child: Icon(
                          icon,
                          color: color,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(mainTitle, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          if (subtitle != null)
                            Text(
                              subtitle,
                              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white10),
                  const SizedBox(height: 8),

                  if (isBuy) ...[
                    _buildInfoRow('Position', need.targetPosition ?? 'Any'),
                    _buildInfoRow('Age Range', '${need.minAge ?? 16} - ${need.maxAge ?? 40}'),
                    _buildInfoRow('Min Ability', '${need.minCa ?? 0}'),
                    _buildInfoRow('Max Budget', _formatCurrency(need.maxTransferBudget ?? 0)),
                    _buildInfoRow('Max Salary', '${_formatCurrency(need.maxWeeklySalary ?? 0)}/week'),
                  ] else ...[
                    if (player != null) _buildInfoRow('Age', '${player.age}'),
                    if (player != null) _buildInfoRow('Position', player.position),
                    if (player != null) _buildInfoRow('Ability', '${player.ca}'),
                    _buildInfoRow('Minimum Fee', _formatCurrency(need.minimumFee ?? 0)),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13)),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        ],
      ),
    );
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

class _CompletedTransferCard extends ConsumerWidget {
  final Transfer transfer;

  const _CompletedTransferCard({required this.transfer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fromClubFuture = ref.watch(clubRepositoryProvider).getClubById(transfer.fromClubId);
    final toClubFuture = ref.watch(clubRepositoryProvider).getClubById(transfer.toClubId);
    final playerFuture = ref.watch(playerRepositoryProvider).getPlayerById(transfer.playerId);

    return FutureBuilder(
      future: Future.wait([fromClubFuture, toClubFuture, playerFuture]),
      builder: (context, snapshot) {
         if (!snapshot.hasData) return const SizedBox();

        final fromClub = (snapshot.data![0] as dynamic).fold((l) => null, (r) => r);
        final toClub = (snapshot.data![1] as dynamic).fold((l) => null, (r) => r);
        final player = (snapshot.data![2] as dynamic).fold((l) => null, (r) => r);

        if (player == null) return const SizedBox();

        return Card(
          color: Colors.white.withOpacity(0.05),
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: () {
               showDialog(
                 context: context,
                 builder: (context) => PlayerDetailDialog(player: player),
               );
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // Date
                        'Season ${transfer.season} | Week ${transfer.week}',
                        style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
                      ),
                      // Fee
                      Text(
                        _formatCurrency(transfer.feeAmount.toInt()),
                        style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white10, height: 24),
                  Row(
                    children: [
                      // From Club
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(fromClub?.name ?? 'Unknown', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                            Text('From', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10)),
                          ],
                        ),
                      ),
                      // Arrow
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.arrow_forward, color: Colors.white24, size: 16),
                      ),
                      // To Club
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(toClub?.name ?? 'Unknown', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                            Text('To', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Player Name
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        player.name,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
