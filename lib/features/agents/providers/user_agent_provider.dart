import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../../core/database/app_database.dart' hide Player, Agent;
import '../../agents/domain/entities/agent.dart';
import '../../agents/providers/agent_provider.dart';
import '../../players/presentation/providers/player_provider.dart';

// Provides the current user agent (Agent ID 1)
final userAgentProvider = AsyncNotifierProvider<UserAgentNotifier, Agent?>(() {
  return UserAgentNotifier();
});

class UserAgentNotifier extends AsyncNotifier<Agent?> {
  static const int _userId = 1;

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

  // Capacity Formula: Base 5 + (Level / 3)
  int get capacity {
    final level = state.value?.level ?? 1;
    return 5 + (level / 3).floor();
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

    // Refresh state
    ref.invalidateSelf(); 
    
    // Refresh Player Lists to update UI immediately
    ref.invalidate(playersByAgentProvider(_userId));
    ref.invalidate(filteredPlayersProvider);

    return null; // Success
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
}
