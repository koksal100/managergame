import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../providers/transfer_provider.dart';
import '../../../clubs/providers/club_provider.dart';
import '../../../players/providers/player_provider.dart';
import '../../../players/presentation/widgets/player_detail_dialog.dart';
import '../../../../core/providers/game_date_provider.dart';
import '../widgets/suggest_player_dialog.dart';

// --- ENUMS & STATE MANAGEMENT FOR SORTING ---

// Geçmiş Transferler için Sıralama (History)
enum HistoryColumn { date, fee }

final historySortColumnProvider = StateProvider<HistoryColumn>(
  (ref) => HistoryColumn.date,
);
final historySortAscendingProvider = StateProvider<bool>((ref) => false);

// İlanlar (Needs) için Sıralama
enum NeedsColumn { budget, salary, fee, age, ca }

final needsSortColumnProvider = StateProvider<NeedsColumn>(
  (ref) => NeedsColumn.budget,
);
final needsSortAscendingProvider = StateProvider<bool>((ref) => false);

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
        backgroundColor: const Color(0xFF0F0F0F),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F0F0F),
          elevation: 0,
          title: const Text(
            'MARKET',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.2,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: const Color(0xFF64FFDA),
            indicatorWeight: 2,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: const Color(0xFF64FFDA),
            unselectedLabelColor: Colors.white38,
            labelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            tabs: const [
              Tab(text: 'SELL LIST'),
              Tab(text: 'BUY REQ'),
              Tab(text: 'OFFERS'),
              Tab(text: 'HISTORY'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 1. Sell Needs (Tablo)
            sellNeedsAsync.when(
              data: (needs) => _buildNeedsTable(ref, needs, isBuy: false),
              loading: () => const Center(
                child: CircularProgressIndicator(color: Color(0xFF64FFDA)),
              ),
              error: (e, _) => Center(
                child: Text(
                  'Error: $e',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
            // 2. Buy Needs (Tablo)
            buyNeedsAsync.when(
              data: (needs) => _buildNeedsTable(ref, needs, isBuy: true),
              loading: () => const Center(
                child: CircularProgressIndicator(color: Color(0xFF64FFDA)),
              ),
              error: (e, _) => Center(
                child: Text(
                  'Error: $e',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
            // 3. Active Offers (Liste)
            activeOffersAsync.when(
              data: (offers) => _buildActiveOffersList(offers),
              loading: () => const Center(
                child: CircularProgressIndicator(color: Color(0xFF64FFDA)),
              ),
              error: (e, _) => Center(
                child: Text(
                  'Error: $e',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
            // 4. Completed Transfers (Tablo)
            completedTransfersAsync.when(
              data: (transfers) =>
                  _buildCompletedTransfersTable(ref, transfers),
              loading: () => const Center(
                child: CircularProgressIndicator(color: Color(0xFF64FFDA)),
              ),
              error: (e, _) => Center(
                child: Text(
                  'Error: $e',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 1 & 2. NEEDS TABLE (BUY & SELL)
  // ===========================================================================

  Widget _buildNeedsTable(
    WidgetRef ref,
    List<TransferNeed> needs, {
    required bool isBuy,
  }) {
    if (needs.isEmpty) {
      return _buildEmptyState(
        isBuy ? Icons.search_off : Icons.sell_outlined,
        isBuy ? 'No clubs looking to buy' : 'No players listed for sale',
      );
    }

    final sortColumn = ref.watch(needsSortColumnProvider);
    final isAscending = ref.watch(needsSortAscendingProvider);

    // Sorting Logic
    List<TransferNeed> sortedNeeds = List.from(needs);
    sortedNeeds.sort((a, b) {
      int comparison = 0;
      switch (sortColumn) {
        case NeedsColumn.budget:
          comparison = (a.maxTransferBudget ?? 0).compareTo(
            b.maxTransferBudget ?? 0,
          );
          break;
        case NeedsColumn.salary:
          comparison = (a.maxWeeklySalary ?? 0).compareTo(
            b.maxWeeklySalary ?? 0,
          );
          break;
        case NeedsColumn.fee:
          comparison = (a.minimumFee ?? 0).compareTo(b.minimumFee ?? 0);
          break;
        case NeedsColumn.age:
          comparison = (a.minAge ?? 0).compareTo(b.minAge ?? 0);
          break;
        case NeedsColumn.ca:
          comparison = (a.minCa ?? 0).compareTo(b.minCa ?? 0);
          break;
        default:
          comparison = 0;
      }
      return isAscending ? comparison : -comparison;
    });

    return Column(
      children: [
        // --- HEADER ---
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
          ),
          child: Row(
            children: [
              if (isBuy) ...[
                // BUY HEADERS: Club | Pos | MIN CA | Budget | Salary
                _buildStaticHeader('CLUB', flex: 3),
                _buildStaticHeader('POS', flex: 2),
                _buildSortableHeader(
                  ref,
                  'MIN CA',
                  NeedsColumn.ca,
                  flex: 2,
                  alignment: Alignment.center,
                ),
                _buildSortableHeader(
                  ref,
                  'BUDGET',
                  NeedsColumn.budget,
                  flex: 3,
                  alignment: Alignment.centerRight,
                ),
                _buildSortableHeader(
                  ref,
                  'SALARY',
                  NeedsColumn.salary,
                  flex: 3,
                  alignment: Alignment.centerRight,
                ),
              ] else ...[
                // SELL HEADERS: Player | Pos | Fee
                _buildStaticHeader('PLAYER', flex: 4),
                _buildStaticHeader('POS', flex: 2),
                _buildSortableHeader(
                  ref,
                  'FEE',
                  NeedsColumn.fee,
                  flex: 3,
                  alignment: Alignment.centerRight,
                ),
              ],
              // Action Button Space
              const SizedBox(width: 40),
            ],
          ),
        ),

        // --- BODY ---
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: sortedNeeds.length,
            separatorBuilder: (c, i) =>
                Divider(height: 1, color: Colors.white.withOpacity(0.05)),
            itemBuilder: (context, index) {
              return _NeedDataRow(
                need: sortedNeeds[index],
                isBuy: isBuy,
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }

  // Tıklanamayan başlık
  Widget _buildStaticHeader(
    String title, {
    int flex = 1,
    Alignment alignment = Alignment.centerLeft,
  }) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: alignment,
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Tıklanabilir ve sıralanabilir başlık
  Widget _buildSortableHeader(
    WidgetRef ref,
    String title,
    NeedsColumn column, {
    int flex = 1,
    Alignment alignment = Alignment.centerLeft,
  }) {
    final currentSort = ref.watch(needsSortColumnProvider);
    final isAscending = ref.watch(needsSortAscendingProvider);
    final isSelected = currentSort == column;

    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: () {
          if (isSelected) {
            ref.read(needsSortAscendingProvider.notifier).state = !isAscending;
          } else {
            ref.read(needsSortColumnProvider.notifier).state = column;
            ref.read(needsSortAscendingProvider.notifier).state = true;
          }
        },
        child: Container(
          alignment: alignment,
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF64FFDA) : Colors.white54,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isSelected)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(
                    isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                    size: 7,
                    color: const Color(0xFF64FFDA),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. COMPLETED TRANSFERS TABLE
  // ===========================================================================

  Widget _buildCompletedTransfersTable(
    WidgetRef ref,
    List<Transfer> transfers,
  ) {
    if (transfers.isEmpty)
      return _buildEmptyState(Icons.history_toggle_off, 'No transfer history');

    final sortColumn = ref.watch(historySortColumnProvider);
    final isAscending = ref.watch(historySortAscendingProvider);

    List<Transfer> sortedTransfers = List.from(transfers);
    sortedTransfers.sort((a, b) {
      int comparison = 0;
      switch (sortColumn) {
        case HistoryColumn.fee:
          comparison = a.feeAmount.compareTo(b.feeAmount);
          break;
        case HistoryColumn.date:
        default:
          final dateA = a.season * 100 + a.week;
          final dateB = b.season * 100 + b.week;
          comparison = dateA.compareTo(dateB);
          break;
      }
      return isAscending ? comparison : -comparison;
    });

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
          ),
          child: Row(
            children: [
              _buildHistoryHeader(ref, 'DATE', HistoryColumn.date, flex: 2),
              _buildStaticHeader('PLAYER', flex: 4),
              _buildStaticHeader('FROM', flex: 3),
              const Icon(
                Icons.arrow_forward,
                size: 12,
                color: Colors.transparent,
              ),
              _buildStaticHeader('TO', flex: 3),
              _buildHistoryHeader(
                ref,
                'FEE',
                HistoryColumn.fee,
                flex: 3,
                alignment: Alignment.centerRight,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: sortedTransfers.length,
            separatorBuilder: (c, i) =>
                Divider(height: 1, color: Colors.white.withOpacity(0.05)),
            itemBuilder: (context, index) => _TransferHistoryRow(
              transfer: sortedTransfers[index],
              index: index,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryHeader(
    WidgetRef ref,
    String title,
    HistoryColumn column, {
    int flex = 1,
    Alignment alignment = Alignment.centerLeft,
  }) {
    final currentSort = ref.watch(historySortColumnProvider);
    final isAscending = ref.watch(historySortAscendingProvider);
    final isSelected = currentSort == column;
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: () {
          if (isSelected) {
            ref.read(historySortAscendingProvider.notifier).state =
                !isAscending;
          } else {
            ref.read(historySortColumnProvider.notifier).state = column;
            ref.read(historySortAscendingProvider.notifier).state = true;
          }
        },
        child: Container(
          alignment: alignment,
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF64FFDA) : Colors.white54,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isSelected)
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Icon(
                    isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                    size: 10,
                    color: const Color(0xFF64FFDA),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // HELPERS
  // ===========================================================================

  Widget _buildActiveOffersList(List<TransferOffer> offers) {
    if (offers.isEmpty)
      return _buildEmptyState(Icons.pending_actions, 'No active offers');
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: offers.length,
      itemBuilder: (context, index) => _ActiveOfferRow(offer: offers[index]),
    );
  }

  Widget _buildEmptyState(IconData icon, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Colors.white10),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(color: Colors.white38, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// ROW WIDGETS
// ===========================================================================

class _NeedDataRow extends ConsumerWidget {
  final TransferNeed need;
  final bool isBuy;
  final int index;

  const _NeedDataRow({
    required this.need,
    required this.isBuy,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubFuture = ref
        .watch(clubRepositoryProvider)
        .getClubById(need.clubId);
    final playerFuture = (!isBuy && need.playerToSellId != null)
        ? ref
              .watch(playerRepositoryProvider)
              .getPlayerById(need.playerToSellId!)
        : Future.value(null);

    return FutureBuilder(
      future: Future.wait([clubFuture, playerFuture]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(height: 50);

        final club = (snapshot.data![0] as dynamic).fold((l) => null, (r) => r);
        final player = (snapshot.data![1] as dynamic)?.fold(
          (l) => null,
          (r) => r,
        );

        // Buy Row Cells
        List<Widget> rowChildren = [];

        if (isBuy) {
          rowChildren = [
            // Club Name
            Expanded(
              flex: 3,
              child: Text(
                club?.name ?? 'Unknown',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Position
            Expanded(
              flex: 2,
              child: Text(
                need.targetPosition ?? 'Any',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
            // MIN CA (BUY REQ'teki özellik)
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  '${need.minCa ?? '-'}',
                  style: const TextStyle(
                    color: Color(0xFF64FFDA),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            // Budget
            Expanded(
              flex: 3,
              child: Text(
                _formatCurrency(need.maxTransferBudget ?? 0),
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
            // Salary
            Expanded(
              flex: 3,
              child: Text(
                '${_formatCurrency(need.maxWeeklySalary ?? 0)}/w',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Color(0xFF64FFDA),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ];
        } else {
          // Sell Row Cells
          rowChildren = [
            // Player Name & Club
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- BURASI GÜNCELLENDİ: Oyuncu Adı (Current Ability) ---
                  Text(
                    '${player?.name ?? 'Unknown'} (${player?.ca.toString().substring(0,2) ?? '-'})',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    club?.name ?? '',
                    style: const TextStyle(color: Colors.white38, fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Position
            Expanded(
              flex: 2,
              child: Text(
                player?.position ?? '-',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
            // Fee
            Expanded(
              flex: 3,
              child: Text(
                _formatCurrency(need.minimumFee ?? 0),
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ];
        }

        return InkWell(
          onTap: () {
            if (isBuy) {
              final gameDate = ref.read(gameDateProvider);
              showDialog(
                context: context,
                builder: (context) => SuggestPlayerDialog(
                  need: need,
                  currentWeek: gameDate.week,
                  season: gameDate.season,
                ),
              );
            } else if (player != null) {
              showDialog(
                context: context,
                builder: (context) => PlayerDetailDialog(player: player),
              );
            }
          },
          child: Container(
            color: index % 2 == 0
                ? Colors.transparent
                : Colors.white.withOpacity(0.02),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            height: 60,
            child: Row(
              children: [
                ...rowChildren,
                // Action Button
                SizedBox(
                  width: 40,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      isBuy ? Icons.person_add : Icons.chevron_right,
                      color: isBuy ? const Color(0xFF64FFDA) : Colors.white24,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TransferHistoryRow extends ConsumerWidget {
  final Transfer transfer;
  final int index;

  const _TransferHistoryRow({required this.transfer, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fromClubFuture = ref
        .watch(clubRepositoryProvider)
        .getClubById(transfer.fromClubId);
    final toClubFuture = ref
        .watch(clubRepositoryProvider)
        .getClubById(transfer.toClubId);
    final playerFuture = ref
        .watch(playerRepositoryProvider)
        .getPlayerById(transfer.playerId);

    return FutureBuilder(
      future: Future.wait([fromClubFuture, toClubFuture, playerFuture]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(height: 50);
        final fromClub = (snapshot.data![0] as dynamic).fold(
          (l) => null,
          (r) => r,
        );
        final toClub = (snapshot.data![1] as dynamic).fold(
          (l) => null,
          (r) => r,
        );
        final player = (snapshot.data![2] as dynamic).fold(
          (l) => null,
          (r) => r,
        );

        if (player == null) return const SizedBox();

        return InkWell(
          onTap: () => showDialog(
            context: context,
            builder: (context) => PlayerDetailDialog(player: player),
          ),
          child: Container(
            color: index % 2 == 0
                ? Colors.transparent
                : Colors.white.withOpacity(0.02),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'S${transfer.season}/W${transfer.week}',
                    style: const TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    player.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    fromClub?.name ?? '-',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.arrow_right_alt,
                    color: Colors.white12,
                    size: 14,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    toClub?.name ?? '-',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    _formatCurrency(transfer.feeAmount.toInt()),
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Color(0xFF64FFDA),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ActiveOfferRow extends ConsumerWidget {
  final TransferOffer offer;

  const _ActiveOfferRow({required this.offer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fromClubFuture = ref
        .watch(clubRepositoryProvider)
        .getClubById(offer.fromClubId);
    final playerFuture = ref
        .watch(playerRepositoryProvider)
        .getPlayerById(offer.playerId);

    return FutureBuilder(
      future: Future.wait([fromClubFuture, playerFuture]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        final fromClub = (snapshot.data![0] as dynamic).fold(
          (l) => null,
          (r) => r,
        );
        final player = (snapshot.data![1] as dynamic).fold(
          (l) => null,
          (r) => r,
        );

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              const Icon(Icons.pending, color: Colors.amber, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player?.name ?? 'Unknown',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'From ${fromClub?.name ?? 'Unknown'}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _formatCurrency(offer.offerAmount),
                style: const TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

String _formatCurrency(int value) {
  if (value >= 1000000) return '€${(value / 1000000).toStringAsFixed(1)}M';
  if (value >= 1000) return '€${(value / 1000).toStringAsFixed(0)}K';
  return '€$value';
}
