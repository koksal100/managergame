import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/database_provider.dart'; // Import this
import '../../../../core/database/app_database.dart';
import '../../../../main.dart'; // For database provider (assuming global provider or passing it)
import 'package:drift/drift.dart' as drift;

class ClubTransferHistory extends ConsumerStatefulWidget {
  final int clubId;

  const ClubTransferHistory({super.key, required this.clubId});

  @override
  ConsumerState<ClubTransferHistory> createState() => _ClubTransferHistoryState();
}

class _ClubTransferHistoryState extends ConsumerState<ClubTransferHistory> {
  List<TransferWithDetails> _transfers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTransfers();
  }

  Future<void> _loadTransfers() async {
    // Access database directly for complex join
    // Ideally should be in Repository
    // Using a manual approach to get 'database' object assuming it's available via Provider/GetIt or similar
    // Since we don't have global variable for 'database' exposed here easily without Riverpod ref 
    // And I saw 'appDatabaseProvider' in club_provider.dart
    
    // We will use a Consumer to get database from provider
    // But since this is checking inside initState, we have to wait or use ref.read in a method
    
    // Changing approach: logic moves to build or a separate provider, 
    // but for now let's just use ref.read in this method (called from initState, usually fine if provider is alive)
    // Actually, initState cannot use ref.read safely for watching, but reading once is ok-ish,
    // Better to use ref.read inside body or use FutureProvider.
  }

  @override
  Widget build(BuildContext context) {
    // Let's use FutureBuilder with a query
    final database = ref.watch(appDatabaseProvider);
    
    return FutureBuilder<List<TransferWithDetails>>(
      future: _fetchHistory(database),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
           return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
           return Center(child: Text("Error: ${snapshot.error}"));
        }
        
        final transfers = snapshot.data ?? [];
        if (transfers.isEmpty) {
           return const Center(child: Text("No transfer history available.", style: TextStyle(color: Colors.white)));
        }

        return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: transfers.length,
            itemBuilder: (context, index) {
              final transfer = transfers[index];
              final isIncoming = transfer.toClubId == widget.clubId;
              
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    isIncoming ? Icons.arrow_back : Icons.arrow_forward,
                    color: isIncoming ? Colors.green : Colors.red,
                  ),
                  title: Text(transfer.playerName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    (isIncoming 
                      ? "From: ${transfer.fromClubName}" 
                      : "To: ${transfer.toClubName}") + " • S${transfer.season} W${transfer.week}",
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                  trailing: Text(
                    "€${(transfer.feeAmount / 1000000).toStringAsFixed(1)}M",
                    style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              );
            },
          );
      },
    );
  }

  Future<List<TransferWithDetails>> _fetchHistory(AppDatabase database) async {
      // Raw query or joined drift query
      // Let's do a join
      // Select * from Transfers join Players join Clubs(from) join Clubs(to)
      
      final query = database.select(database.transfers).join([
        drift.innerJoin(database.players, database.players.id.equalsExp(database.transfers.playerId)),
        drift.innerJoin(database.clubs, database.clubs.id.equalsExp(database.transfers.fromClubId), useColumns: false),
        drift.innerJoin(database.clubs, database.clubs.id.equalsExp(database.transfers.toClubId), useColumns: false),
      ]);
      
      // Alias for joined tables is tricky in Drift simple joins without aliases
      // Actually, we can fetch all and map, or use alias.
      // Simpler approach:
      // Fetch transfers filtering by club ID
      final transfersRows = await (database.select(database.transfers)
        ..where((t) => t.fromClubId.equals(widget.clubId) | t.toClubId.equals(widget.clubId))
        ..orderBy([(t) => drift.OrderingTerm(expression: t.date, mode: drift.OrderingMode.desc)])
        ).get();
        
      if (transfersRows.isEmpty) return [];
      
      // Collect IDs
      final playerIds = transfersRows.map((t) => t.playerId).toSet();
      final clubIds = transfersRows.map((t) => t.fromClubId).followedBy(transfersRows.map((t) => t.toClubId)).toSet();
      
      // Fetch details
      final players = await (database.select(database.players)..where((t) => t.id.isIn(playerIds))).get();
      final clubs = await (database.select(database.clubs)..where((t) => t.id.isIn(clubIds))).get();
      
      final playerMap = {for (var p in players) p.id: p.name};
      final clubMap = {for (var c in clubs) c.id: c.name};
      
      return transfersRows.map((t) {
        return TransferWithDetails(
          playerName: playerMap[t.playerId] ?? 'Unknown Player',
          fromClubName: clubMap[t.fromClubId] ?? 'Unknown Club',
          toClubName: clubMap[t.toClubId] ?? 'Unknown Club',
          feeAmount: t.feeAmount,
          fromClubId: t.fromClubId,
          toClubId: t.toClubId,
          season: t.season,
          week: t.week,
        );
      }).toList();
  }
}

class TransferWithDetails {
  final String playerName;
  final String fromClubName;
  final String toClubName;
  final double feeAmount;
  final int fromClubId;
  final int toClubId;
  final int season;
  final int week;

  TransferWithDetails({
    required this.playerName,
    required this.fromClubName,
    required this.toClubName,
    required this.feeAmount,
    required this.fromClubId,
    required this.toClubId,
    required this.season,
    required this.week,
  });
}
