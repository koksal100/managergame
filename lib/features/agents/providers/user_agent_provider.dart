import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../../core/database/app_database.dart' hide Player, Agent;
import '../../agents/domain/entities/agent.dart';
import '../../agents/providers/agent_provider.dart';
import '../../players/presentation/providers/player_provider.dart';
import '../../../../core/providers/game_date_provider.dart';

// Provides the current user agent (Agent ID 1)
final userAgentProvider = AsyncNotifierProvider<UserAgentNotifier, Agent?>(() {
  return UserAgentNotifier();
});

class UserAgentNotifier extends AsyncNotifier<Agent?> {
  static const int _userId = 1;
  static const int _weeklyOfferLimit = 2; // Limit per week

  @override
  Future<Agent?> build() async {
    return _fetchUserAgent();
  }

  Future<Agent?> _fetchUserAgent() async {
    final repository = ref.read(agentRepositoryProvider);
    final result = await repository.getAgentById(_userId);
    return result.fold(
      (failure) => null, // Handle error gracefully or return null
      (agent) => agent,
    );
  }

  // Capacity Formula: Linear increase from 2 (Lvl 1) to 20 (Lvl 60)
  int get capacity {
    final level = state.value?.level ?? 1;
    // Formula: 2 + ((level - 1) * (20 - 2) / (60 - 1))
    return 2 + ((level - 1) * 18 / 59).floor();
  }

  // --- ACTIONS ---

  // Sign a player to the agency
  Future<String?> signPlayer(int playerId) async {
    final db = ref.read(appDatabaseProvider);
    
    // 1. Check Capacity
    final myPlayersCount = await (db.select(db.players)..where((tbl) => tbl.agentId.equals(_userId))).get().then((l) => l.length);
    
    if (myPlayersCount >= capacity) {
      return "Capacity Full! Upgrade your level.";
    }

    // 2. Sign Player
    await (db.update(db.players)..where((tbl) => tbl.id.equals(playerId))).write(
      const PlayersCompanion(agentId: Value(_userId)),
    );

    // 2b. Create Agent Contract
    // Deactivate old contracts
    await (db.update(db.agentContracts)..where((t) => t.playerId.equals(playerId)))
      .write(const AgentContractsCompanion(status: Value('Inactive')));
    
    // Insert new contract
    final now = DateTime.now();
    await db.into(db.agentContracts).insert(
      AgentContractsCompanion(
        agentId: const Value(_userId),
        playerId: Value(playerId),
        startDate: Value(now),
        endDate: Value(now.add(const Duration(days: 365 * 2))), // 2 Years default
        feePercentage: const Value(10.0), // Default 10%
        wage: const Value(0),
        releaseClause: const Value(0),
        status: const Value('Active'),
      ),
    );

    // Refresh state
    ref.invalidateSelf(); 
    
    // Refresh Player Lists to update UI immediately
    ref.invalidate(playersByAgentProvider(_userId));
    ref.invalidate(filteredPlayersProvider);

    return null; // Success
  }

  // Helper: Check if capacity allows signing
  Future<bool> checkCapacity() async {
    final db = ref.read(appDatabaseProvider);
    final myPlayersCount = await (db.select(db.players)..where((tbl) => tbl.agentId.equals(_userId))).get().then((l) => l.length);
    return myPlayersCount < capacity;
  }

  // Release a player (Terminate Contract)
  Future<void> releasePlayer(int playerId) async {
    final db = ref.read(appDatabaseProvider);
    
    await (db.update(db.players)..where((tbl) => tbl.id.equals(playerId))).write(
      const PlayersCompanion(agentId: Value(null)),
    );

    // Terminate Contract
    await (db.update(db.agentContracts)
      ..where((t) => t.playerId.equals(playerId))
      ..where((t) => t.agentId.equals(_userId))
      ..where((t) => t.status.equals('Active'))) // Case insensitive? Standardizing on 'Active'
      .write(const AgentContractsCompanion(status: Value('Terminated')));

    // Refresh UI
    ref.invalidateSelf();
    ref.invalidate(playersByAgentProvider(_userId));
    ref.invalidate(filteredPlayersProvider);
  }

  // Debug: Level Up
  Future<void> levelUp() async {
     final db = ref.read(appDatabaseProvider);
     final currentLevel = state.value?.level ?? 1;

     if (currentLevel < 60) {
       await (db.update(db.agents)..where((tbl) => tbl.id.equals(_userId))).write(
         AgentsCompanion(level: Value(currentLevel + 1)),
       );
       ref.invalidateSelf();
       ref.invalidateSelf();
     }
  }

  // Update Manager Name
  Future<void> updateName(String newName) async {
    final db = ref.read(appDatabaseProvider);
    await (db.update(db.agents)..where((tbl) => tbl.id.equals(_userId))).write(
      AgentsCompanion(name: Value(newName)),
    );
    ref.invalidateSelf();
  }

  // --- NEGOTIATION LIMITS ---

  String _getOfferKey(int week) => 'weekly_offers_used_week_$week';

  Future<int> getWeeklyOffersUsed() async {
    final currentGameTime = ref.read(gameDateProvider);
    final currentWeek = currentGameTime.week;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_getOfferKey(currentWeek)) ?? 0;
  }

  Future<bool> checkCanMakeOffer() async {
    final used = await getWeeklyOffersUsed();
    return used < _weeklyOfferLimit;
  }

  Future<void> incrementOfferCount() async {
    final currentGameTime = ref.read(gameDateProvider);
    final currentWeek = currentGameTime.week;
    final prefs = await SharedPreferences.getInstance();
    final key = _getOfferKey(currentWeek);
    final current = prefs.getInt(key) ?? 0;
    await prefs.setInt(key, current + 1);
  }
}
