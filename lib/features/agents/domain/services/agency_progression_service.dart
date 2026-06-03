import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/database/app_database.dart';

class AgencyProgressionResult {
  const AgencyProgressionResult({
    required this.previousXp,
    required this.currentXp,
    required this.previousLevel,
    required this.currentLevel,
  });

  final int previousXp;
  final int currentXp;
  final int previousLevel;
  final int currentLevel;

  bool get leveledUp => currentLevel > previousLevel;
}

class AgencyProgressionService {
  AgencyProgressionService(this.database);

  final AppDatabase database;

  static String _xpKey(int agentId) => 'agency_xp_$agentId';

  Future<int> getXp(int agentId) async {
    return _readOrSeedXp(agentId);
  }

  Future<int> _readOrSeedXp(int agentId) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getInt(_xpKey(agentId));
    if (existing != null) return existing;

    final agent = await (database.select(
      database.agents,
    )..where((t) => t.id.equals(agentId))).getSingleOrNull();
    final seededXp = xpRequiredForLevel(agent?.level ?? 1);
    await prefs.setInt(_xpKey(agentId), seededXp);
    return seededXp;
  }

  int xpRequiredForLevel(int level) {
    if (level <= 1) return 0;
    final n = level - 1;
    return (n * n * 18) + (n * 60);
  }

  int levelForXp(int xp) {
    for (int level = 60; level >= 1; level--) {
      if (xp >= xpRequiredForLevel(level)) {
        return level;
      }
    }
    return 1;
  }

  Future<AgencyProgressionResult> addXp({
    required int agentId,
    required int amount,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final previousXp = await _readOrSeedXp(agentId);
    final currentXp = (previousXp + amount).clamp(0, 999999).toInt();
    await prefs.setInt(_xpKey(agentId), currentXp);

    final previousLevel = levelForXp(previousXp);
    final currentLevel = levelForXp(currentXp);

    final agent = await (database.select(
      database.agents,
    )..where((t) => t.id.equals(agentId))).getSingleOrNull();
    if (agent != null && agent.level != currentLevel) {
      await (database.update(database.agents)
            ..where((t) => t.id.equals(agentId)))
          .write(AgentsCompanion(level: Value(currentLevel)));
    }

    return AgencyProgressionResult(
      previousXp: previousXp,
      currentXp: currentXp,
      previousLevel: previousLevel,
      currentLevel: currentLevel,
    );
  }
}
