import 'dart:math';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../agents/domain/services/agency_progression_service.dart';
import '../../../players/domain/services/player_value_calculator.dart';

/// TransferEngine handles all AI-driven transfer logic.
/// - Generating transfer needs for clubs
/// - Creating offers between clubs
/// - Evaluating and finalizing transfers
class TransferEngine {
  final AppDatabase database;
  final Random _random = Random();

  TransferEngine(this.database);

  // Position mapping
  static const Map<String, String> positionCategories = {
    'GK': 'GK',
    'DEF': 'DEF',
    'CB': 'DEF',
    'LB': 'DEF',
    'RB': 'DEF',
    'MID': 'MID',
    'CM': 'MID',
    'DM': 'MID',
    'AM': 'MID',
    'LM': 'MID',
    'RM': 'MID',
    'FWD': 'FWD',
    'ST': 'FWD',
    'LW': 'FWD',
    'RW': 'FWD',
  };

  static const Map<String, int> minimumPlayersByCategory = {
    'GK': 2,
    'DEF': 5,
    'MID': 5,
    'FWD': 3,
  };

  /// Generate transfer needs for all clubs.
  /// Called at game start or before transfer window opens.
  Future<void> generateAllClubNeeds() async {
    final clubs = await database.select(database.clubs).get();

    for (final club in clubs) {
      await generateTransferNeedsForClub(
        club.id,
        club.transferBudget.toInt(),
        club.wageBudget.toInt(),
      );
    }
  }

  /// Analyze a club's squad and generate buy/sell needs.
  Future<void> generateTransferNeedsForClub(
    int clubId,
    int transferBudget,
    int wageBudget,
  ) async {
    // Get club's players
    final players = await (database.select(
      database.players,
    )..where((t) => t.clubId.equals(clubId))).get();

    if (players.isEmpty) return;

    // Analyze by position category
    Map<String, List<Player>> byPosition = {
      'GK': [],
      'DEF': [],
      'MID': [],
      'FWD': [],
    };
    for (var p in players) {
      final cat = positionCategories[p.position] ?? 'MID';
      byPosition[cat]?.add(p);
    }

    // Find weakest position (lowest avg CA)
    String? weakestPos;
    double lowestAvgCa = 1000;
    for (var entry in byPosition.entries) {
      if (entry.value.isEmpty) {
        weakestPos = entry.key;
        break;
      }
      final avgCa =
          entry.value.map((p) => p.ca).reduce((a, b) => a + b) /
          entry.value.length;
      if (avgCa < lowestAvgCa) {
        lowestAvgCa = avgCa;
        weakestPos = entry.key;
      }
    }

    // Create BUY need for weakest position
    if (weakestPos != null) {
      final avgCaBase = (lowestAvgCa + 2).round();
      final maxBudget = transferBudget ~/ 2;
      final budgetBasedCa = _estimateCaFromBudgetAtAge27(
        budget: maxBudget,
        positionCategory: weakestPos,
      );
      final minCa = ((avgCaBase + budgetBasedCa) / 2)
          .round()
          .clamp(40, 99)
          .toInt();

      await database
          .into(database.transferNeeds)
          .insert(
            TransferNeedsCompanion(
              clubId: Value(clubId),
              type: const Value('buy'),
              targetPosition: Value(weakestPos),
              minAge: const Value(18),
              maxAge: const Value(32),
              minCa: Value(minCa),
              maxTransferBudget: Value(maxBudget),
              maxWeeklySalary: Value(
                wageBudget ~/ 25 ~/ 52,
              ), // Roughly 1/25th of annual wage budget per player
            ),
          );
    }

    // Create diversified SELL needs (up to 2 players per window)
    // to avoid only very low-value players being listed.
    if (players.length > 20) {
      final avgCa =
          (players.map((p) => p.ca).reduce((a, b) => a + b) / players.length)
              .toDouble();
      final sellCandidates = _pickSellCandidates(
        players: players,
        avgCa: avgCa,
        count: 2,
      );

      for (final player in sellCandidates) {
        await database
            .into(database.transferNeeds)
            .insert(
              TransferNeedsCompanion(
                clubId: Value(clubId),
                type: const Value('sell'),
                playerToSellId: Value(player.id),
                minimumFee: Value((player.marketValue * 0.8).round()),
              ),
            );
      }
    }
  }

  List<Player> _pickSellCandidates({
    required List<Player> players,
    required double avgCa,
    required int count,
  }) {
    if (players.isEmpty || count <= 0) return [];

    final sortedByValue = List<Player>.from(players)
      ..sort((a, b) => a.marketValue.compareTo(b.marketValue));
    final lowIdx = (sortedByValue.length * 0.40).floor().clamp(
      0,
      sortedByValue.length - 1,
    );
    final highIdx = (sortedByValue.length * 0.80).floor().clamp(
      0,
      sortedByValue.length - 1,
    );
    final lowCut = sortedByValue[lowIdx].marketValue;
    final highCut = sortedByValue[highIdx].marketValue;

    final lowRolePool = players
        .where((p) => p.age >= 29 || p.ca <= (avgCa - 4))
        .toList();
    final midValuePool = players
        .where((p) => p.marketValue >= lowCut && p.marketValue < highCut)
        .toList();
    final highValuePool = players
        .where((p) => p.marketValue >= highCut)
        .toList();

    final selected = <Player>[];
    final selectedIds = <int>{};

    Player? pickFrom(List<Player> pool) {
      final filtered = pool.where((p) => !selectedIds.contains(p.id)).toList();
      if (filtered.isEmpty) return null;
      return filtered[_random.nextInt(filtered.length)];
    }

    for (int i = 0; i < count; i++) {
      final roll = _random.nextDouble();
      Player? chosen;

      if (roll < 0.40) {
        chosen =
            pickFrom(lowRolePool) ??
            pickFrom(midValuePool) ??
            pickFrom(highValuePool);
      } else if (roll < 0.75) {
        chosen =
            pickFrom(midValuePool) ??
            pickFrom(lowRolePool) ??
            pickFrom(highValuePool);
      } else {
        chosen =
            pickFrom(highValuePool) ??
            pickFrom(midValuePool) ??
            pickFrom(lowRolePool);
      }

      chosen ??= pickFrom(players);
      if (chosen == null) break;

      selected.add(chosen);
      selectedIds.add(chosen.id);
    }

    return selected;
  }

  int _estimateCaFromBudgetAtAge27({
    required int budget,
    required String positionCategory,
  }) {
    if (budget <= 0) return 40;

    int bestCa = 40;
    int closestDiff = 1 << 30;

    for (int ca = 40; ca <= 99; ca++) {
      final value = PlayerValueCalculator.calculateMarketValue(
        ca.toDouble(),
        27,
        positionCategory,
      );
      final diff = (value - budget).abs();
      if (diff < closestDiff) {
        closestDiff = diff;
        bestCa = ca;
      }
    }

    return bestCa;
  }

  Future<void> _reviewClubNeedsForPosition(
    int clubId,
    String positionCategory,
  ) async {
    final club = await (database.select(
      database.clubs,
    )..where((t) => t.id.equals(clubId))).getSingleOrNull();
    if (club == null) return;

    final players = await (database.select(
      database.players,
    )..where((t) => t.clubId.equals(clubId))).get();
    if (players.isEmpty) return;

    final playersInCategory = players.where((p) {
      return (positionCategories[p.position] ?? 'MID') == positionCategory;
    }).toList();

    final existingBuyNeed =
        await (database.select(database.transferNeeds)
              ..where((t) => t.clubId.equals(clubId))
              ..where((t) => t.type.equals('buy'))
              ..where((t) => t.isFulfilled.equals(false))
              ..where((t) => t.targetPosition.equals(positionCategory)))
            .getSingleOrNull();

    final minimumCount = minimumPlayersByCategory[positionCategory] ?? 4;
    final overallAvgCa =
        players.map((p) => p.ca).reduce((a, b) => a + b) / players.length;
    final categoryAvgCa = playersInCategory.isEmpty
        ? 0.0
        : playersInCategory.map((p) => p.ca).reduce((a, b) => a + b) /
              playersInCategory.length;
    final shouldCreateBuyNeed =
        playersInCategory.length < minimumCount ||
        categoryAvgCa < (overallAvgCa - 3);

    if (shouldCreateBuyNeed) {
      final avgCaBase =
          ((categoryAvgCa == 0 ? overallAvgCa : categoryAvgCa) + 2).round();
      final maxBudget = club.transferBudget.toInt() ~/ 2;
      final budgetBasedCa = _estimateCaFromBudgetAtAge27(
        budget: maxBudget,
        positionCategory: positionCategory,
      );
      final minCa = ((avgCaBase + budgetBasedCa) / 2)
          .round()
          .clamp(40, 99)
          .toInt();

      final companion = TransferNeedsCompanion(
        clubId: Value(clubId),
        type: const Value('buy'),
        targetPosition: Value(positionCategory),
        minAge: const Value(18),
        maxAge: const Value(32),
        minCa: Value(minCa),
        maxTransferBudget: Value(maxBudget),
        maxWeeklySalary: Value(club.wageBudget.toInt() ~/ 25 ~/ 52),
      );

      if (existingBuyNeed == null) {
        await database.into(database.transferNeeds).insert(companion);
      } else {
        await (database.update(
          database.transferNeeds,
        )..where((t) => t.id.equals(existingBuyNeed.id))).write(companion);
      }
    }

    if (players.length <= 20 || playersInCategory.length < minimumCount + 2) {
      return;
    }

    final existingSellNeedForCategory =
        await (database.select(database.transferNeeds)
              ..where((t) => t.clubId.equals(clubId))
              ..where((t) => t.type.equals('sell'))
              ..where((t) => t.isFulfilled.equals(false))
              ..where(
                (t) => t.playerToSellId.isIn(
                  playersInCategory.map((p) => p.id).toList(),
                ),
              ))
            .getSingleOrNull();

    if (existingSellNeedForCategory != null) return;

    final sellCandidates = List<Player>.from(playersInCategory)
      ..sort((a, b) => a.ca.compareTo(b.ca));
    final sellCandidate = sellCandidates.firstOrNull;
    if (sellCandidate == null) return;

    await database
        .into(database.transferNeeds)
        .insert(
          TransferNeedsCompanion(
            clubId: Value(clubId),
            type: const Value('sell'),
            playerToSellId: Value(sellCandidate.id),
            minimumFee: Value((sellCandidate.marketValue * 0.8).round()),
          ),
        );
  }

  /// Process offer creation. Each club creates up to 2 offers per day.
  /// Process offer creation.
  /// Optimized: Fetches all buy needs, shuffles them, and processes max 50 per day.
  /// Process offer creation.
  /// optimized: Fetches all data upfront (Batch Processing) to minimize DB I/O.
  Future<void> processOfferCreation(int season, int currentWeek) async {
    // 1. Fetch ALL unfulfilled Buy Needs
    final allBuyNeeds =
        await (database.select(database.transferNeeds)
              ..where((t) => t.type.equals('buy'))
              ..where((t) => t.isFulfilled.equals(false)))
            .get();

    if (allBuyNeeds.isEmpty) return;

    // 2. Fetch ALL unfulfilled Sell Needs
    final allSellNeeds =
        await (database.select(database.transferNeeds)
              ..where((t) => t.type.equals('sell'))
              ..where((t) => t.isFulfilled.equals(false)))
            .get();

    // 3. Batch Fetch Players involved in Sell Needs
    // Extract player IDs to fetch only necessary players
    final playerIdsToFetch = allSellNeeds
        .where((n) => n.playerToSellId != null)
        .map((n) => n.playerToSellId!)
        .toSet();

    if (playerIdsToFetch.isEmpty) return;

    final playersList = await (database.select(
      database.players,
    )..where((t) => t.id.isIn(playerIdsToFetch))).get();

    // Create a Map for O(1) lookup: PlayerID -> Player
    final Map<int, Player> playersMap = {for (var p in playersList) p.id: p};

    // 4. Batch Fetch Pending Offers to avoid duplicates
    // We only care about pending offers for the buy needs we have
    final buyNeedIds = allBuyNeeds.map((n) => n.id).toList();
    final pendingOffers =
        await (database.select(database.transferOffers)
              ..where((t) => t.needId.isIn(buyNeedIds))
              ..where((t) => t.status.equals('pending')))
            .get();

    // Create a Set of NeedIDs that already have a pending offer
    final Set<int> needsWithPendingOffers = pendingOffers
        .map((o) => o.needId)
        .toSet();

    // 5. Filter out players who already transferred THIS WINDOW
    // Rule: A player can only transfer once per window.
    int windowStartWeek = 1;
    if (currentWeek >= 29) windowStartWeek = 29;

    final recentlyTransferredOffers =
        await (database.select(database.transferOffers)
              ..where((t) => t.status.equals('accepted'))
              ..where(
                (t) => t.season.equals(season),
              ) // Filter by current season
              ..where(
                (t) => t.createdAtWeek.isBiggerOrEqualValue(windowStartWeek),
              ))
            .get();

    final recentlyTransferredPlayerIds = recentlyTransferredOffers
        .map((o) => o.playerId)
        .toSet();
    // 6. Processing & Matching (In-Memory)
    final shuffledBuyNeeds = allBuyNeeds.toList()..shuffle(_random);
    int offersCreated = 0;

    // Use a transaction/batch insert if possible, but for now simple loop of inserts
    // is fine since we calculate everything in memory first.

    for (final need in shuffledBuyNeeds) {
      if (offersCreated >= 50) break;

      // CHECK: If this need already has a pending offer, skip it
      if (needsWithPendingOffers.contains(need.id)) continue;

      bool matchFound = false;

      // 1. Try to find a match in Sell Listings
      for (final sellNeed in allSellNeeds) {
        if (sellNeed.clubId == need.clubId) continue; // Don't buy from self
        if (sellNeed.playerToSellId == null) continue;

        // CHECK: Skip if player already transferred this window
        if (recentlyTransferredPlayerIds.contains(sellNeed.playerToSellId!))
          continue;

        final player = playersMap[sellNeed.playerToSellId];
        if (player == null) continue;

        // Check if player fits buy need
        final playerCat = positionCategories[player.position] ?? 'MID';
        if (need.targetPosition != null && playerCat != need.targetPosition)
          continue;
        if (need.minCa != null && player.ca < need.minCa!) continue;
        if (need.minAge != null && player.age < need.minAge!) continue;
        if (need.maxAge != null && player.age > need.maxAge!) continue;

        // Calculate offer
        final relationshipMultiplier = await _pricingTransferMultiplier(
          player: player,
          sellingClubId: sellNeed.clubId,
        );
        final offerAmount =
            (((sellNeed.minimumFee ?? player.marketValue) *
                    relationshipMultiplier)
                .round()) +
            _random.nextInt(500000);
        if (need.maxTransferBudget != null &&
            offerAmount > need.maxTransferBudget!)
          continue;

        final proposedSalary = (player.marketValue / 200).round();
        if (need.maxWeeklySalary != null &&
            proposedSalary > need.maxWeeklySalary!)
          continue;

        // Create offer
        await database
            .into(database.transferOffers)
            .insert(
              TransferOffersCompanion(
                fromClubId: Value(need.clubId),
                toClubId: Value(sellNeed.clubId),
                playerId: Value(player.id),
                needId: Value(need.id),
                offerAmount: Value(offerAmount),
                proposedSalary: Value(proposedSalary),
                contractYears: Value(2 + _random.nextInt(3)),
                // 2-4 years
                season: Value(season),
                createdAtWeek: Value(currentWeek),
                status: const Value('pending'),
              ),
            );

        offersCreated++;
        matchFound = true;
        break; // Match found for this buy need, move to next need
      }

      // 2. FALLBACK: Search General Player Pool (Unlisted)
      if (!matchFound) {
        // Query DB for a single random candidate that matches criteria
        // We limit this query heavily to avoid perf issues
        final query = database.select(database.players)
          ..where((p) => p.clubId.isNotNull()) // Must have a club
          ..where((p) => p.clubId.equals(need.clubId).not()) // Not own player
          ..where(
            (p) => p.id.isIn(recentlyTransferredPlayerIds).not(),
          ) // EXCLUDE RECENTLY TRANSFERRED
          ..limit(10); // Get a small pool to pick from

        // Apply filters
        if (need.minAge != null)
          query.where((p) => p.age.isBiggerOrEqualValue(need.minAge!));
        if (need.maxAge != null)
          query.where((p) => p.age.isSmallerOrEqualValue(need.maxAge!));
        if (need.minCa != null)
          query.where((p) => p.ca.isBiggerOrEqualValue(need.minCa!.toDouble()));
        // Position filter is tricky with string map, simplified check:
        // Ideally we would do this in Dart for precise 'DEF' mapping, OR use LIKE
        // For performance, let's fetch first then filter by position in Dart

        final candidates = await query.get();
        final validCandidates = candidates.where((p) {
          final pCat = positionCategories[p.position] ?? 'MID';
          return need.targetPosition == null || pCat == need.targetPosition;
        }).toList();

        if (validCandidates.isNotEmpty) {
          final player =
              validCandidates[_random.nextInt(validCandidates.length)];

          // Check budget
          final relationshipMultiplier = await _pricingTransferMultiplier(
            player: player,
            sellingClubId: player.clubId!,
          );
          int estimatedFee = (player.marketValue * 1.2 * relationshipMultiplier)
              .toInt();
          if (need.maxTransferBudget == null ||
              estimatedFee <= need.maxTransferBudget!) {
            final proposedSalary = (player.marketValue / 200).round();

            if (need.maxWeeklySalary == null ||
                proposedSalary <= need.maxWeeklySalary!) {
              await database
                  .into(database.transferOffers)
                  .insert(
                    TransferOffersCompanion(
                      fromClubId: Value(need.clubId),
                      toClubId: Value(player.clubId!),
                      playerId: Value(player.id),
                      needId: Value(need.id),
                      offerAmount: Value(estimatedFee),
                      proposedSalary: Value(proposedSalary),
                      contractYears: Value(2 + _random.nextInt(3)),
                      season: Value(season),
                      createdAtWeek: Value(currentWeek),
                      status: const Value('pending'),
                    ),
                  );
              offersCreated++;
            }
          }
        }
      }
    }
  }

  /// Evaluate pending offers from previous day.
  /// Evaluate pending offers from previous day.
  /// Refactored: Groups offers by player, picks best offer, and auto-rejects others.
  Future<void> evaluateOffers(int season, int currentWeek) async {
    // Get offers created earlier than today (previous weeks/days)
    // Complex logic for season transition:
    // If season > offer.season -> Process it (it's from old season)
    // If season == offer.season AND currentWeek > offer.createdAtWeek -> Process it

    final pendingOffers = await (database.select(
      database.transferOffers,
    )..where((t) => t.status.equals('pending'))).get();

    // Filter in Dart for complex date logic
    final offersToProcess = pendingOffers.where((o) {
      if (o.season < season) return true;
      if (o.season == season && o.createdAtWeek < currentWeek) return true;
      return false;
    }).toList();

    // Group by Player ID
    final offersByPlayer = <int, List<TransferOffer>>{};
    for (var o in offersToProcess) {
      if (!offersByPlayer.containsKey(o.playerId)) {
        offersByPlayer[o.playerId] = [];
      }
      offersByPlayer[o.playerId]!.add(o);
    }

    // Process each player's offers
    for (final playerId in offersByPlayer.keys) {
      final offers = offersByPlayer[playerId]!;

      // Sort by Offer Amount DESC (Best offer first)
      offers.sort((a, b) => b.offerAmount.compareTo(a.offerAmount));

      final bestOffer = offers.first;
      final otherOffers = offers.sublist(1); // All other lower offers

      // SAFETY CHECK: Verify the player is still owned by the expected seller
      // This prevents race conditions where a player is transferred multiple times
      final currentPlayerParams = await (database.select(
        database.players,
      )..where((t) => t.id.equals(playerId))).getSingleOrNull();

      if (currentPlayerParams == null ||
          currentPlayerParams.clubId != bestOffer.toClubId) {
        // Player doesn't exist or has already moved to another club
        final allIds = offers.map((o) => o.id).toList();
        await (database.update(database.transferOffers)
              ..where((t) => t.id.isIn(allIds)))
            .write(const TransferOffersCompanion(status: Value('rejected')));
        continue;
      }

      // Evaluate ONLY the best offer
      // Get the sell need
      final sellNeed =
          await (database.select(database.transferNeeds)
                ..where((t) => t.type.equals('sell'))
                ..where((t) => t.clubId.equals(bestOffer.toClubId))
                ..where((t) => t.playerToSellId.equals(bestOffer.playerId)))
              .getSingleOrNull();

      bool accepted = false;

      final player = await (database.select(
        database.players,
      )..where((t) => t.id.equals(bestOffer.playerId))).getSingleOrNull();
      final acceptanceMultiplier = player == null
          ? 1.0
          : await _acceptanceTransferMultiplier(
              player: player,
              sellingClubId: bestOffer.toClubId,
            );

      if (sellNeed != null) {
        // Check if offer meets minimum
        final requiredFee = sellNeed.minimumFee == null
            ? 0
            : (sellNeed.minimumFee! * acceptanceMultiplier).round();
        if (sellNeed.minimumFee == null ||
            bestOffer.offerAmount >= requiredFee) {
          accepted = true;
        }
      } else {
        // No explicit sell need, decide based on offer vs market value
        if (player != null &&
            bestOffer.offerAmount >=
                (player.marketValue * 0.9 * acceptanceMultiplier)) {
          accepted = _random.nextBool(); // 50% chance
        }
      }

      if (accepted) {
        // 1. Accept Best Offer
        await _finalizeTransfer(bestOffer, season, currentWeek);
        // 2. Auto-Reject all other offers for this player
        if (otherOffers.isNotEmpty) {
          final otherIds = otherOffers.map((o) => o.id).toList();
          await (database.update(database.transferOffers)
                ..where((t) => t.id.isIn(otherIds)))
              .write(const TransferOffersCompanion(status: Value('rejected')));
        }
      } else {
        // Reject Best Offer (and implicitly reject others effectively, or we can mark ALL as rejected)
        // If the BEST offer is rejected, lower ones would definitely be rejected too.
        // So we reject ALL offers for this player this turn.
        final allIds = offers.map((o) => o.id).toList();
        await (database.update(database.transferOffers)
              ..where((t) => t.id.isIn(allIds)))
            .write(const TransferOffersCompanion(status: Value('rejected')));
      }
    }
  }

  /// Manually create an offer (e.g. from Negotiation Dialog).
  /// If [accepted] is true, it finalizes the transfer immediately.
  Future<void> createManualOffer({
    required int needId,
    required int playerId,
    required int fromClubId, // Club BUYING (Need owner)
    required int toClubId, // Club SELLING (Current owner)
    required int amount,
    required int wage,
    required int years,
    required int season,
    required int week,
    required bool accepted,
  }) async {
    // 1. Create Offer Record
    final id = await database
        .into(database.transferOffers)
        .insert(
          TransferOffersCompanion(
            needId: Value(needId),
            playerId: Value(playerId),
            fromClubId: Value(fromClubId),
            toClubId: Value(toClubId),
            offerAmount: Value(amount),
            proposedSalary: Value(wage),
            contractYears: Value(years),
            season: Value(season),
            createdAtWeek: Value(week),
            status: Value(accepted ? 'accepted' : 'rejected'),
          ),
        );

    // 2. Finalize if accepted
    if (accepted) {
      // Need to fetch the created offer object or construct it
      final offer = TransferOffer(
        id: id,
        needId: needId,
        playerId: playerId,
        fromClubId: fromClubId,
        toClubId: toClubId,
        offerAmount: amount,
        proposedSalary: wage,
        contractYears: years,
        season: season,
        createdAtWeek: week,
        status: 'accepted',
      );

      await _finalizeTransfer(offer, season, week);
    }
  }

  /// Complete a transfer: update player, create contracts, log transfer.
  Future<void> _finalizeTransfer(
    TransferOffer offer,
    int season,
    int week,
  ) async {
    final now = DateTime.now();
    final transferredPlayer = await (database.select(
      database.players,
    )..where((t) => t.id.equals(offer.playerId))).getSingleOrNull();
    final transferredPlayerCategory = transferredPlayer == null
        ? 'MID'
        : (positionCategories[transferredPlayer.position] ?? 'MID');

    // 1. Update offer status
    await (database.update(database.transferOffers)
          ..where((t) => t.id.equals(offer.id)))
        .write(const TransferOffersCompanion(status: Value('accepted')));

    // 2. Log transfer
    await database
        .into(database.transfers)
        .insert(
          TransfersCompanion(
            playerId: Value(offer.playerId),
            fromClubId: Value(offer.toClubId),
            toClubId: Value(offer.fromClubId),
            date: Value(now),
            feeAmount: Value(offer.offerAmount.toDouble()),
            type: const Value('Permanent'),
            season: Value(season),
            week: Value(week),
          ),
        );

    // 3. Update player's club
    await (database.update(database.players)
          ..where((t) => t.id.equals(offer.playerId)))
        .write(PlayersCompanion(clubId: Value(offer.fromClubId)));

    // 4. Delete old club contract, create new one
    await (database.delete(
      database.clubContracts,
    )..where((t) => t.playerId.equals(offer.playerId))).go();

    await database
        .into(database.clubContracts)
        .insert(
          ClubContractsCompanion(
            clubId: Value(offer.fromClubId),
            playerId: Value(offer.playerId),
            weeklySalary: Value(offer.proposedSalary),
            startDate: Value(now),
            endDate: Value(now.add(Duration(days: 365 * offer.contractYears))),
            status: const Value('active'),
          ),
        );

    // 5. Update Budgets
    // Selling Club (toClubId) -> Gains Transfer Fee
    final sellingClub = await (database.select(
      database.clubs,
    )..where((t) => t.id.equals(offer.toClubId))).getSingle();
    await (database.update(
      database.clubs,
    )..where((t) => t.id.equals(offer.toClubId))).write(
      ClubsCompanion(
        transferBudget: Value(sellingClub.transferBudget + offer.offerAmount),
      ),
    );

    // Buying Club (fromClubId) -> Loses Transfer Fee
    final buyingClub = await (database.select(
      database.clubs,
    )..where((t) => t.id.equals(offer.fromClubId))).getSingle();
    await (database.update(
      database.clubs,
    )..where((t) => t.id.equals(offer.fromClubId))).write(
      ClubsCompanion(
        transferBudget: Value(buyingClub.transferBudget - offer.offerAmount),
      ),
    );

    // 6. Mark buy need as fulfilled
    await (database.update(database.transferNeeds)
          ..where((t) => t.id.equals(offer.needId)))
        .write(const TransferNeedsCompanion(isFulfilled: Value(true)));

    // 7. Mark sell need as fulfilled (if exists)
    await (database.update(database.transferNeeds)
          ..where((t) => t.type.equals('sell'))
          ..where((t) => t.playerToSellId.equals(offer.playerId)))
        .write(const TransferNeedsCompanion(isFulfilled: Value(true)));

    // 8. Agent Commission
    final activeContracts = await (database.select(
      database.agentContracts,
    )..where((t) => t.playerId.equals(offer.playerId))).get();

    // Check for 'Active' (Case insensitive just in case, or match Seeder 'Active')
    final activeContract = activeContracts
        .where((c) => c.status.toLowerCase() == 'active')
        .firstOrNull;

    if (activeContract != null) {
      final agentId = activeContract.agentId;
      final feePercentage = activeContract.feePercentage;

      final commission = (offer.offerAmount * (feePercentage / 100)).toInt();

      final agent = await (database.select(
        database.agents,
      )..where((a) => a.id.equals(agentId))).getSingleOrNull();
      if (agent != null) {
        await (database.update(database.agents)
              ..where((a) => a.id.equals(agentId)))
            .write(AgentsCompanion(balance: Value(agent.balance + commission)));
      }

      final xpReward = _calculateTransferXpReward(
        offer: offer,
        player: transferredPlayer,
      );
      await AgencyProgressionService(
        database,
      ).addXp(agentId: agentId, amount: xpReward);
    }

    await _reviewClubNeedsForPosition(
      offer.toClubId,
      transferredPlayerCategory,
    );
    await _reviewClubNeedsForPosition(
      offer.fromClubId,
      transferredPlayerCategory,
    );
  }

  /// Clear all transfer needs at end of window.
  Future<void> clearTransferNeeds() async {
    await database.delete(database.transferNeeds).go();
  }

  /// Check if current week is in a transfer window.
  static bool isTransferWindow(int week) {
    return (week >= 1 && week <= 8) || (week >= 29 && week <= 32);
  }

  /// Check if next week starts a transfer window.
  static bool isTransferWindowStarting(int nextWeek) {
    return nextWeek == 1 || nextWeek == 29;
  }

  /// Check if current week ends a transfer window.
  static bool isTransferWindowEnding(int week) {
    return week == 8 || week == 32;
  }

  int _calculateTransferXpReward({
    required TransferOffer offer,
    required Player? player,
  }) {
    int reward = 8;

    if (player != null) {
      final premiumRatio = offer.offerAmount / max(1, player.marketValue);
      if (premiumRatio >= 1.20) {
        reward += 5;
      } else if (premiumRatio >= 1.05) {
        reward += 3;
      }

      final potentialGap = (player.pa - player.ca).round();
      if (potentialGap >= 12) {
        reward += 4;
      } else if (potentialGap >= 6) {
        reward += 2;
      }
    }

    return reward;
  }

  Future<double> _pricingTransferMultiplier({
    required Player player,
    required int sellingClubId,
  }) async {
    final clubRelationship = await _clubRelationshipThresholdModifier(
      agentId: player.agentId,
      clubId: sellingClubId,
    );
    final reputationModifier = await _agentReputationThresholdModifier(
      player.agentId,
    );

    return (clubRelationship * reputationModifier).clamp(0.82, 1.22);
  }

  Future<double> _acceptanceTransferMultiplier({
    required Player player,
    required int sellingClubId,
  }) async {
    final playerRelationship = await _playerRelationshipThresholdModifier(
      player,
    );
    final clubRelationship = await _clubRelationshipThresholdModifier(
      agentId: player.agentId,
      clubId: sellingClubId,
    );
    final reputationModifier = await _agentReputationThresholdModifier(
      player.agentId,
    );

    return (playerRelationship * clubRelationship * reputationModifier).clamp(
      0.78,
      1.22,
    );
  }

  Future<double> _playerRelationshipThresholdModifier(Player player) async {
    if (player.agentId == null) return 1.0;

    final relationship = await _readRelationshipScore(
      fromId: player.agentId!,
      toId: player.id,
      fromType: 'Agent',
      toType: 'Player',
    );

    if (relationship >= 80) return 1.06;
    if (relationship >= 60) return 1.03;
    if (relationship <= 19) return 0.90;
    if (relationship <= 39) return 0.96;
    return 1.0;
  }

  Future<double> _clubRelationshipThresholdModifier({
    required int? agentId,
    required int clubId,
  }) async {
    if (agentId == null) return 1.0;

    final relationship = await _readRelationshipScore(
      fromId: agentId,
      toId: clubId,
      fromType: 'Agent',
      toType: 'Club',
    );

    if (relationship >= 80) return 0.93;
    if (relationship >= 60) return 0.97;
    if (relationship <= 19) return 1.12;
    if (relationship <= 39) return 1.06;
    return 1.0;
  }

  Future<double> _agentReputationThresholdModifier(int? agentId) async {
    if (agentId == null) return 1.0;

    final agent = await (database.select(
      database.agents,
    )..where((t) => t.id.equals(agentId))).getSingleOrNull();
    if (agent == null) return 1.0;

    if (agent.reputation >= 85) return 0.95;
    if (agent.reputation >= 70) return 0.98;
    if (agent.reputation <= 25) return 1.08;
    if (agent.reputation <= 40) return 1.04;
    return 1.0;
  }

  Future<int> _readRelationshipScore({
    required int fromId,
    required int toId,
    required String fromType,
    required String toType,
  }) async {
    final row =
        await (database.select(database.relationships)
              ..where((t) => t.fromId.equals(fromId))
              ..where((t) => t.toId.equals(toId))
              ..where((t) => t.fromType.equals(fromType))
              ..where((t) => t.toType.equals(toType)))
            .getSingleOrNull();
    return row?.score ?? 50;
  }
}
