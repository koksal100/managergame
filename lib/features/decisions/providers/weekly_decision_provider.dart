import 'dart:math';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/providers/database_provider.dart';
import '../../agents/domain/services/agency_progression_service.dart';
import '../../players/domain/services/player_value_calculator.dart';
import '../../transfers/domain/services/transfer_engine.dart';

final weeklyDecisionServiceProvider = Provider<WeeklyDecisionService>((ref) {
  return WeeklyDecisionService(ref.watch(appDatabaseProvider));
});

enum WeeklyDecisionCategory {
  finance,
  playerDevelopment,
  playerRelationship,
  clubRelationship,
  reputation,
  riskManagement,
}

enum DecisionSeasonPhase { earlySeason, transferWindow, midSeason, seasonRunIn }

class WeeklyDecisionService {
  WeeklyDecisionService(this.database);

  final AppDatabase database;
  final Random _random = Random();

  static const String _lastCategoryKey = 'weekly_decision_last_category';

  Future<WeeklyDecision?> maybeGenerateDecision(int season, int week) async {
    if (_random.nextDouble() > 0.69) return null;

    final userAgent = await (database.select(
      database.agents,
    )..where((t) => t.id.equals(1))).getSingleOrNull();
    if (userAgent == null) return null;

    final managedPlayers = await (database.select(
      database.players,
    )..where((t) => t.agentId.equals(1))).get();

    final player = managedPlayers.isEmpty
        ? null
        : managedPlayers[_random.nextInt(managedPlayers.length)];
    final club = player?.clubId == null
        ? null
        : await (database.select(
            database.clubs,
          )..where((t) => t.id.equals(player!.clubId!))).getSingleOrNull();

    final phase = _resolvePhase(week);
    final templates = _buildTemplatesForPhase(
      phase: phase,
      userAgent: userAgent,
      player: player,
      club: club,
      season: season,
      week: week,
    );
    if (templates.isEmpty) return null;

    final prefs = await SharedPreferences.getInstance();
    final lastCategoryName = prefs.getString(_lastCategoryKey);
    final lastCategory = WeeklyDecisionCategory.values.where((category) {
      return category.name == lastCategoryName;
    }).firstOrNull;

    var candidatePool = templates;
    final nonRepeating = templates
        .where((decision) => decision.category != lastCategory)
        .toList();
    if (nonRepeating.isNotEmpty) {
      candidatePool = nonRepeating;
    }

    final decision = candidatePool[_random.nextInt(candidatePool.length)];
    await prefs.setString(_lastCategoryKey, decision.category.name);
    return decision;
  }

  Future<void> applyDecisionOption(WeeklyDecisionOption option) async {
    final agent = await (database.select(
      database.agents,
    )..where((t) => t.id.equals(1))).getSingleOrNull();
    if (agent == null) return;

    final nextReputation = (agent.reputation + option.reputationDelta).clamp(
      0,
      100,
    );

    await (database.update(
      database.agents,
    )..where((t) => t.id.equals(1))).write(
      AgentsCompanion(
        balance: Value(agent.balance + option.balanceDelta),
        reputation: Value(nextReputation),
      ),
    );

    final progressionService = AgencyProgressionService(database);
    if (option.xpDelta != 0) {
      await progressionService.addXp(agentId: 1, amount: option.xpDelta);
    }

    if (option.playerId != null) {
      final player = await (database.select(
        database.players,
      )..where((t) => t.id.equals(option.playerId!))).getSingleOrNull();
      if (player != null) {
        final nextCa = (player.ca + option.playerCaDelta).clamp(
          1.0,
          player.pa.toDouble(),
        );
        final nextValue = PlayerValueCalculator.calculateMarketValue(
          nextCa,
          player.age,
          player.position,
          pa: player.pa,
        );
        await (database.update(
          database.players,
        )..where((t) => t.id.equals(player.id))).write(
          PlayersCompanion(
            ca: Value(nextCa),
            reputation: Value(nextCa.round()),
            marketValue: Value(nextValue),
          ),
        );

        await _upsertRelationship(
          fromId: 1,
          toId: player.id,
          fromType: 'Agent',
          toType: 'Player',
          delta: option.playerRelationshipDelta,
        );
      }
    }

    if (option.clubId != null) {
      await _upsertRelationship(
        fromId: 1,
        toId: option.clubId!,
        fromType: 'Agent',
        toType: 'Club',
        delta: option.clubRelationshipDelta,
      );
    }
  }

  List<WeeklyDecision> _buildTemplatesForPhase({
    required DecisionSeasonPhase phase,
    required Agent userAgent,
    required Player? player,
    required Club? club,
    required int season,
    required int week,
  }) {
    switch (phase) {
      case DecisionSeasonPhase.transferWindow:
        return [
          if (player != null) _buildSponsorDecision(userAgent, player, club),
          _buildNetworkingDecision(userAgent, club),
          if (player != null)
            _buildTransferLeakDecision(userAgent, player, club),
        ];
      case DecisionSeasonPhase.earlySeason:
        return [
          _buildAgencyEducationDecision(userAgent),
          if (player != null) _buildSeasonPlanDecision(userAgent, player, club),
          if (player != null) _buildSponsorDecision(userAgent, player, club),
        ];
      case DecisionSeasonPhase.midSeason:
        return [
          if (player != null)
            _buildPerformanceBonusDecision(userAgent, player, club),
          if (player != null)
            _buildRestVsExposureDecision(userAgent, player, club),
          if (player != null) _buildRecoveryDecision(userAgent, player, club),
        ];
      case DecisionSeasonPhase.seasonRunIn:
        return [
          _buildAwardCircuitDecision(userAgent, season, week),
          if (player != null)
            _buildLoyaltyBonusDecision(userAgent, player, club),
          _buildAgencyEducationDecision(userAgent),
        ];
    }
  }

  DecisionSeasonPhase _resolvePhase(int week) {
    if (TransferEngine.isTransferWindow(week)) {
      return DecisionSeasonPhase.transferWindow;
    }
    if (week <= 12) {
      return DecisionSeasonPhase.earlySeason;
    }
    if (week >= 45) {
      return DecisionSeasonPhase.seasonRunIn;
    }
    return DecisionSeasonPhase.midSeason;
  }

  WeeklyDecision _buildSponsorDecision(Agent agent, Player player, Club? club) {
    final sponsorMoney = 220000 + (agent.reputation * 2200);
    return WeeklyDecision(
      category: WeeklyDecisionCategory.finance,
      phase: DecisionSeasonPhase.transferWindow,
      title: 'Sponsor Shoot',
      description:
          '${player.name} icin ticari cekim teklifi geldi. Nakit akisi iyi olabilir ama oyuncunun haftalik odagi bozulabilir.',
      options: [
        WeeklyDecisionOption(
          label: 'Anlasmayi kabul et',
          summary: '+Para, +Rep, +XP, -Oyuncu iliskisi, -Gelisim',
          balanceDelta: sponsorMoney,
          reputationDelta: 2,
          xpDelta: 10,
          playerId: player.id,
          playerCaDelta: -0.05,
          playerRelationshipDelta: -4,
          clubRelationshipDelta: club == null ? 0 : -1,
          clubId: club?.id,
        ),
        WeeklyDecisionOption(
          label: 'Oyuncuyu koru',
          summary: '-Para, +Oyuncu iliskisi, +Gelisim, +Rep',
          balanceDelta: -50000,
          reputationDelta: 1,
          xpDelta: 6,
          playerId: player.id,
          playerCaDelta: 0.06,
          playerRelationshipDelta: 5,
          clubId: club?.id,
        ),
      ],
    );
  }

  WeeklyDecision _buildPerformanceBonusDecision(
    Agent agent,
    Player player,
    Club? club,
  ) {
    final bonusCost = 120000 + (player.ca.round() * 1200);
    return WeeklyDecision(
      category: WeeklyDecisionCategory.playerRelationship,
      phase: DecisionSeasonPhase.midSeason,
      title: 'Performance Bonus Promise',
      description:
          '${player.name} daha agresif bir bonus paketi istiyor. Kabul edersen baglilik artabilir ama kasa etkilenir.',
      options: [
        WeeklyDecisionOption(
          label: 'Bonusu ver',
          summary: '-Para, +Oyuncu iliskisi, +Gelisim, +XP',
          balanceDelta: -bonusCost,
          xpDelta: 8,
          playerId: player.id,
          playerCaDelta: 0.08,
          playerRelationshipDelta: 7,
          clubId: club?.id,
          clubRelationshipDelta: 1,
        ),
        WeeklyDecisionOption(
          label: 'Sert pazarlik yap',
          summary: '+Rep, -Oyuncu iliskisi, +Kulup iliskisi',
          reputationDelta: 1,
          xpDelta: 3,
          playerId: player.id,
          playerRelationshipDelta: -6,
          clubId: club?.id,
          clubRelationshipDelta: 3,
        ),
      ],
    );
  }

  WeeklyDecision _buildNetworkingDecision(Agent agent, Club? club) {
    final eventCost = 160000 + (agent.reputation * 1500);
    return WeeklyDecision(
      category: WeeklyDecisionCategory.clubRelationship,
      phase: DecisionSeasonPhase.transferWindow,
      title: 'Executive Networking',
      description:
          'Ligde etkili isimlerle pahali bir networking firsati dogdu. Kisa vadede masrafli ama agency prestijini ve kulup iliskilerini etkileyebilir.',
      options: [
        WeeklyDecisionOption(
          label: 'Katil',
          summary: '-Para, +Rep, +XP, +Kulup iliskisi',
          balanceDelta: -eventCost,
          reputationDelta: 3,
          xpDelta: 14,
          clubId: club?.id,
          clubRelationshipDelta: 5,
        ),
        WeeklyDecisionOption(
          label: 'Pas gec',
          summary: '+Para koru, -Rep, -Kulup iliskisi',
          balanceDelta: 0,
          reputationDelta: -1,
          xpDelta: 1,
          clubId: club?.id,
          clubRelationshipDelta: -2,
        ),
      ],
    );
  }

  WeeklyDecision _buildRestVsExposureDecision(
    Agent agent,
    Player player,
    Club? club,
  ) {
    final appearanceMoney = 150000 + (agent.reputation * 1700);
    return WeeklyDecision(
      category: WeeklyDecisionCategory.playerDevelopment,
      phase: DecisionSeasonPhase.midSeason,
      title: 'Public Appearance Request',
      description:
          '${player.name} icin yogun ilgi var. Oyuncuyu one cikarmak deger yaratabilir ama fiziksel ve zihinsel yuku artar.',
      options: [
        WeeklyDecisionOption(
          label: 'Gorunurlugu artir',
          summary: '+Para, +Rep, -Gelisim, -Oyuncu iliskisi',
          balanceDelta: appearanceMoney,
          reputationDelta: 2,
          xpDelta: 7,
          playerId: player.id,
          playerCaDelta: -0.04,
          playerRelationshipDelta: -3,
          clubId: club?.id,
        ),
        WeeklyDecisionOption(
          label: 'Dinlenmesini sagla',
          summary: '-Rep, +Gelisim, +Oyuncu iliskisi',
          reputationDelta: -1,
          xpDelta: 5,
          playerId: player.id,
          playerCaDelta: 0.05,
          playerRelationshipDelta: 4,
          clubId: club?.id,
        ),
      ],
    );
  }

  WeeklyDecision _buildAgencyEducationDecision(Agent agent) {
    final workshopCost = 180000 + (agent.level * 2500);
    return WeeklyDecision(
      category: WeeklyDecisionCategory.reputation,
      phase: DecisionSeasonPhase.earlySeason,
      title: 'Agency Workshop',
      description:
          'Kendi ekibin icin egitim kampi duzenleyebilirsin. Hemen para yakar ama uzun vadede profilini yukseltebilir.',
      options: [
        WeeklyDecisionOption(
          label: 'Egitime yatirim yap',
          summary: '-Para, +XP, +Rep',
          balanceDelta: -workshopCost,
          xpDelta: 18,
          reputationDelta: 2,
        ),
        WeeklyDecisionOption(
          label: 'Nakit koru',
          summary: '+Para koru, -Rep, dusuk XP',
          balanceDelta: 0,
          xpDelta: 2,
          reputationDelta: -1,
        ),
      ],
    );
  }

  WeeklyDecision _buildTransferLeakDecision(
    Agent agent,
    Player player,
    Club? club,
  ) {
    final leakMoney = 130000 + max(0, (agent.reputation - 40)) * 1800;
    return WeeklyDecision(
      category: WeeklyDecisionCategory.riskManagement,
      phase: DecisionSeasonPhase.transferWindow,
      title: 'Transfer Leak',
      description:
          '${player.name} hakkinda sizintili bir haber cikarma sansin var. Kisa vadede talebi kizistirabilir ama kulup tarafini da gerer.',
      options: [
        WeeklyDecisionOption(
          label: 'Haberi sizdir',
          summary: '+Para, +Rep, -Kulup iliskisi, -Oyuncu iliskisi',
          balanceDelta: leakMoney,
          reputationDelta: 1,
          xpDelta: 9,
          playerId: player.id,
          playerRelationshipDelta: -3,
          clubId: club?.id,
          clubRelationshipDelta: -5,
        ),
        WeeklyDecisionOption(
          label: 'Sessiz kal',
          summary: '+Kulup iliskisi, +Oyuncu iliskisi, az XP',
          xpDelta: 4,
          playerId: player.id,
          playerRelationshipDelta: 2,
          clubId: club?.id,
          clubRelationshipDelta: 3,
        ),
      ],
    );
  }

  WeeklyDecision _buildSeasonPlanDecision(
    Agent agent,
    Player player,
    Club? club,
  ) {
    return WeeklyDecision(
      category: WeeklyDecisionCategory.playerDevelopment,
      phase: DecisionSeasonPhase.earlySeason,
      title: 'Season Development Plan',
      description:
          '${player.name} icin sezon basi planini secmen gerekiyor. Daha parlak vitrin mi, daha sakin gelisim yolu mu?',
      options: [
        WeeklyDecisionOption(
          label: 'Gelisim odakli plan',
          summary: '-Kisa para, +Gelisim, +Oyuncu iliskisi, +XP',
          balanceDelta: -70000,
          xpDelta: 9,
          playerId: player.id,
          playerCaDelta: 0.07,
          playerRelationshipDelta: 4,
          clubId: club?.id,
        ),
        WeeklyDecisionOption(
          label: 'Vitrin odakli plan',
          summary: '+Para, +Rep, -Gelisim',
          balanceDelta: 170000,
          reputationDelta: 2,
          xpDelta: 6,
          playerId: player.id,
          playerCaDelta: -0.03,
          playerRelationshipDelta: -2,
          clubId: club?.id,
        ),
      ],
    );
  }

  WeeklyDecision _buildRecoveryDecision(
    Agent agent,
    Player player,
    Club? club,
  ) {
    return WeeklyDecision(
      category: WeeklyDecisionCategory.riskManagement,
      phase: DecisionSeasonPhase.midSeason,
      title: 'Recovery Week',
      description:
          '${player.name} arka arkaya yogun sureler aldi. Bu noktada yuklenmeye devam etmek mi, kontrollu toparlanma mi daha dogru?',
      options: [
        WeeklyDecisionOption(
          label: 'Toparlanma penceresi ac',
          summary: '-Rep, +Gelisim, +Oyuncu iliskisi',
          reputationDelta: -1,
          xpDelta: 5,
          playerId: player.id,
          playerCaDelta: 0.05,
          playerRelationshipDelta: 4,
          clubId: club?.id,
        ),
        WeeklyDecisionOption(
          label: 'Takvimi zorla',
          summary: '+Para, +Rep, -Gelisim, -Oyuncu iliskisi',
          balanceDelta: 140000,
          reputationDelta: 1,
          xpDelta: 4,
          playerId: player.id,
          playerCaDelta: -0.05,
          playerRelationshipDelta: -5,
          clubId: club?.id,
        ),
      ],
    );
  }

  WeeklyDecision _buildAwardCircuitDecision(Agent agent, int season, int week) {
    final prestigePayout = 250000 + (agent.reputation * 2600);
    return WeeklyDecision(
      category: WeeklyDecisionCategory.reputation,
      phase: DecisionSeasonPhase.seasonRunIn,
      title: 'Award Circuit',
      description:
          'Sezon sonu yaklasirken agency vitrinini buyutecek odul ve medya programlari acildi. Yatirim yaparsan profile etkisi buyuk olabilir.',
      options: [
        WeeklyDecisionOption(
          label: 'Buyuk sahneye cik',
          summary: '+Para, +Rep, +XP',
          balanceDelta: prestigePayout,
          reputationDelta: 3,
          xpDelta: 16,
        ),
        WeeklyDecisionOption(
          label: 'Temkinli kal',
          summary: '+Rep koru, dusuk XP',
          reputationDelta: 1,
          xpDelta: 4,
        ),
      ],
    );
  }

  WeeklyDecision _buildLoyaltyBonusDecision(
    Agent agent,
    Player player,
    Club? club,
  ) {
    final loyaltyCost =
        140000 + ((player.pa - player.ca).round().clamp(0, 20) * 9000);
    return WeeklyDecision(
      category: WeeklyDecisionCategory.playerRelationship,
      phase: DecisionSeasonPhase.seasonRunIn,
      title: 'Loyalty Bonus',
      description:
          '${player.name} sezon sonuna girerken senden net bir baglilik mesaji bekliyor. Bu, iliskiyi guclendirebilir ama kasayi zorlar.',
      options: [
        WeeklyDecisionOption(
          label: 'Bonusu onayla',
          summary: '-Para, +Oyuncu iliskisi, +Gelisim, +XP',
          balanceDelta: -loyaltyCost,
          xpDelta: 10,
          playerId: player.id,
          playerCaDelta: 0.05,
          playerRelationshipDelta: 8,
          clubId: club?.id,
          clubRelationshipDelta: 1,
        ),
        WeeklyDecisionOption(
          label: 'Beklemeye al',
          summary: '+Para koru, -Oyuncu iliskisi, -Rep',
          reputationDelta: -1,
          xpDelta: 2,
          playerId: player.id,
          playerRelationshipDelta: -5,
          clubId: club?.id,
        ),
      ],
    );
  }

  Future<void> _upsertRelationship({
    required int fromId,
    required int toId,
    required String fromType,
    required String toType,
    required int delta,
  }) async {
    if (delta == 0) return;

    final existing =
        await (database.select(database.relationships)
              ..where((t) => t.fromId.equals(fromId))
              ..where((t) => t.toId.equals(toId))
              ..where((t) => t.fromType.equals(fromType))
              ..where((t) => t.toType.equals(toType)))
            .getSingleOrNull();

    if (existing == null) {
      await database
          .into(database.relationships)
          .insert(
            RelationshipsCompanion(
              fromId: Value(fromId),
              toId: Value(toId),
              fromType: Value(fromType),
              toType: Value(toType),
              score: Value((50 + delta).clamp(0, 100).toInt()),
            ),
          );
      return;
    }

    await (database.update(
      database.relationships,
    )..where((t) => t.id.equals(existing.id))).write(
      RelationshipsCompanion(
        score: Value((existing.score + delta).clamp(0, 100).toInt()),
      ),
    );
  }
}

class WeeklyDecision {
  const WeeklyDecision({
    required this.category,
    required this.phase,
    required this.title,
    required this.description,
    required this.options,
  });

  final WeeklyDecisionCategory category;
  final DecisionSeasonPhase phase;
  final String title;
  final String description;
  final List<WeeklyDecisionOption> options;

  String get categoryLabel {
    switch (category) {
      case WeeklyDecisionCategory.finance:
        return 'FINANCE';
      case WeeklyDecisionCategory.playerDevelopment:
        return 'PLAYER DEVELOPMENT';
      case WeeklyDecisionCategory.playerRelationship:
        return 'PLAYER RELATIONSHIP';
      case WeeklyDecisionCategory.clubRelationship:
        return 'CLUB RELATIONSHIP';
      case WeeklyDecisionCategory.reputation:
        return 'REPUTATION';
      case WeeklyDecisionCategory.riskManagement:
        return 'RISK MANAGEMENT';
    }
  }
}

class WeeklyDecisionOption {
  const WeeklyDecisionOption({
    required this.label,
    required this.summary,
    this.balanceDelta = 0,
    this.xpDelta = 0,
    this.reputationDelta = 0,
    this.playerId,
    this.playerCaDelta = 0,
    this.playerRelationshipDelta = 0,
    this.clubId,
    this.clubRelationshipDelta = 0,
  });

  final String label;
  final String summary;
  final int balanceDelta;
  final int xpDelta;
  final int reputationDelta;
  final int? playerId;
  final double playerCaDelta;
  final int playerRelationshipDelta;
  final int? clubId;
  final int clubRelationshipDelta;
}
