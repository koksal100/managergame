import 'dart:math';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

class RelationshipWindowReview {
  const RelationshipWindowReview({required this.messages});

  final List<String> messages;

  bool get hasEvents => messages.isNotEmpty;
}

class RelationshipRuleService {
  RelationshipRuleService(this.database);

  final AppDatabase database;
  final Random _random = Random();

  Future<RelationshipWindowReview> evaluateTransferWindowStart({
    int agentId = 1,
  }) async {
    final managedPlayers = await (database.select(
      database.players,
    )..where((t) => t.agentId.equals(agentId))).get();
    if (managedPlayers.isEmpty) {
      return const RelationshipWindowReview(messages: []);
    }

    final relationshipRows =
        await (database.select(database.relationships)
              ..where((t) => t.fromId.equals(agentId))
              ..where((t) => t.fromType.equals('Agent'))
              ..where((t) => t.toType.equals('Player'))
              ..where(
                (t) => t.toId.isIn(managedPlayers.map((p) => p.id).toList()),
              ))
            .get();

    final relationshipByPlayer = {
      for (final row in relationshipRows) row.toId: row,
    };

    final messages = <String>[];
    for (final player in managedPlayers) {
      final score = relationshipByPlayer[player.id]?.score ?? 50;
      if (score <= 19) {
        await _handleCriticalRelationship(
          agentId: agentId,
          player: player,
          score: score,
          messages: messages,
        );
      } else if (score <= 39) {
        await _handleWeakRelationship(
          agentId: agentId,
          player: player,
          score: score,
          messages: messages,
        );
      }
    }

    return RelationshipWindowReview(messages: messages);
  }

  Future<void> _handleWeakRelationship({
    required int agentId,
    required Player player,
    required int score,
    required List<String> messages,
  }) async {
    final activeContract = await _getActiveAgentContract(agentId, player.id);
    if (activeContract == null) return;

    final roll = _random.nextDouble();
    if (roll < 0.55) {
      final feeIncrease = score <= 29 ? 2.0 : 1.0;
      final nextFee = (activeContract.feePercentage + feeIncrease).clamp(
        5.0,
        20.0,
      );

      await (database.update(database.agentContracts)
            ..where((t) => t.id.equals(activeContract.id)))
          .write(AgentContractsCompanion(feePercentage: Value(nextFee)));

      messages.add(
        '${player.name} daha guclu bir bonus yapisi istedi. Komisyon orani %${nextFee.toStringAsFixed(1)} oldu.',
      );
      return;
    }

    messages.add(
      '${player.name} ile iliski kirilgan. Bu transfer doneminde kopma riski yuksek.',
    );
  }

  Future<void> _handleCriticalRelationship({
    required int agentId,
    required Player player,
    required int score,
    required List<String> messages,
  }) async {
    final activeContract = await _getActiveAgentContract(agentId, player.id);
    if (activeContract == null) return;

    final roll = _random.nextDouble();
    if (roll < 0.40) {
      await (database.update(database.players)
            ..where((t) => t.id.equals(player.id)))
          .write(const PlayersCompanion(agentId: Value(null)));

      await (database.update(database.agentContracts)
            ..where((t) => t.playerId.equals(player.id))
            ..where((t) => t.agentId.equals(agentId))
            ..where((t) => t.status.equals('Active')))
          .write(const AgentContractsCompanion(status: Value('Terminated')));

      final agent = await (database.select(
        database.agents,
      )..where((t) => t.id.equals(agentId))).getSingleOrNull();
      if (agent != null) {
        await (database.update(
          database.agents,
        )..where((t) => t.id.equals(agentId))).write(
          AgentsCompanion(
            reputation: Value((agent.reputation - 2).clamp(0, 100)),
          ),
        );
      }

      await _setRelationshipScore(
        agentId: agentId,
        playerId: player.id,
        score: score.clamp(0, 5).toInt(),
      );

      messages.add(
        '${player.name} temsil anlasmasini bitirdi. Dusuk iliski yuzunden oyuncu agency\'den ayrildi.',
      );
      return;
    }

    final nextFee = (activeContract.feePercentage + 2.5).clamp(5.0, 22.0);
    await (database.update(database.agentContracts)
          ..where((t) => t.id.equals(activeContract.id)))
        .write(AgentContractsCompanion(feePercentage: Value(nextFee)));

    messages.add(
      '${player.name} kopma noktasina geldi ve daha agir bir pay istedi. Komisyon orani %${nextFee.toStringAsFixed(1)} oldu.',
    );
  }

  Future<AgentContract?> _getActiveAgentContract(int agentId, int playerId) {
    return (database.select(database.agentContracts)
          ..where((t) => t.playerId.equals(playerId))
          ..where((t) => t.agentId.equals(agentId))
          ..where((t) => t.status.equals('Active')))
        .getSingleOrNull();
  }

  Future<void> _setRelationshipScore({
    required int agentId,
    required int playerId,
    required int score,
  }) async {
    final existing =
        await (database.select(database.relationships)
              ..where((t) => t.fromId.equals(agentId))
              ..where((t) => t.toId.equals(playerId))
              ..where((t) => t.fromType.equals('Agent'))
              ..where((t) => t.toType.equals('Player')))
            .getSingleOrNull();

    if (existing == null) {
      await database
          .into(database.relationships)
          .insert(
            RelationshipsCompanion(
              fromId: Value(agentId),
              toId: Value(playerId),
              fromType: const Value('Agent'),
              toType: const Value('Player'),
              score: Value(score.clamp(0, 100).toInt()),
            ),
          );
      return;
    }

    await (database.update(
      database.relationships,
    )..where((t) => t.id.equals(existing.id))).write(
      RelationshipsCompanion(score: Value(score.clamp(0, 100).toInt())),
    );
  }
}
