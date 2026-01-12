import 'dart:math';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';

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
    'DEF': 'DEF', 'CB': 'DEF', 'LB': 'DEF', 'RB': 'DEF',
    'MID': 'MID', 'CM': 'MID', 'DM': 'MID', 'AM': 'MID', 'LM': 'MID', 'RM': 'MID',
    'FWD': 'FWD', 'ST': 'FWD', 'LW': 'FWD', 'RW': 'FWD',
  };

  /// Generate transfer needs for all clubs.
  /// Called at game start or before transfer window opens.
  Future<void> generateAllClubNeeds() async {
    print('[TransferEngine] generateAllClubNeeds() called');
    final clubs = await database.select(database.clubs).get();
    print('[TransferEngine] Found ${clubs.length} clubs');
    
    int needsCreated = 0;
    for (final club in clubs) {
      await generateTransferNeedsForClub(club.id, club.transferBudget.toInt(), club.wageBudget.toInt());
      needsCreated++;
    }
    print('[TransferEngine] Generated needs for $needsCreated clubs');
    
    // Verify
    final allNeeds = await database.select(database.transferNeeds).get();
    print('[TransferEngine] Total needs in DB: ${allNeeds.length}');
  }

  /// Analyze a club's squad and generate buy/sell needs.
  Future<void> generateTransferNeedsForClub(int clubId, int transferBudget, int wageBudget) async {
    // Get club's players
    final players = await (database.select(database.players)
      ..where((t) => t.clubId.equals(clubId)))
      .get();

    if (players.isEmpty) return;

    // Analyze by position category
    Map<String, List<Player>> byPosition = {'GK': [], 'DEF': [], 'MID': [], 'FWD': []};
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
      final avgCa = entry.value.map((p) => p.ca).reduce((a, b) => a + b) / entry.value.length;
      if (avgCa < lowestAvgCa) {
        lowestAvgCa = avgCa;
        weakestPos = entry.key;
      }
    }

    // Create BUY need for weakest position
    if (weakestPos != null) {
      final avgCa = lowestAvgCa.round();
      await database.into(database.transferNeeds).insert(TransferNeedsCompanion(
        clubId: Value(clubId),
        type: const Value('buy'),
        targetPosition: Value(weakestPos),
        minAge: const Value(18),
        maxAge: const Value(32),
        minCa: Value(avgCa), // Want someone at least as good as current avg
        maxTransferBudget: Value(transferBudget ~/ 2), // Willing to spend half budget
        maxWeeklySalary: Value(wageBudget ~/ 25 ~/ 52), // Roughly 1/25th of annual wage budget per player
      ));
    }

    // Create SELL need for worst player (if > 20 players)
    if (players.length > 20) {
      final sorted = List<Player>.from(players)..sort((a, b) => a.ca.compareTo(b.ca));
      final worstPlayer = sorted.first;
      
      await database.into(database.transferNeeds).insert(TransferNeedsCompanion(
        clubId: Value(clubId),
        type: const Value('sell'),
        playerToSellId: Value(worstPlayer.id),
        minimumFee: Value((worstPlayer.marketValue * 0.7).round()), // Accept 70% of market value
      ));
    }
  }

  /// Process offer creation. Each club creates up to 2 offers per day.
  /// Process offer creation.
  /// Optimized: Fetches all buy needs, shuffles them, and processes max 50 per day.
  /// Process offer creation.
  /// optimized: Fetches all data upfront (Batch Processing) to minimize DB I/O.
  Future<void> processOfferCreation(int season, int currentWeek) async {
    final startTime = DateTime.now();
    print('[TransferEngine] processOfferCreation started for Season $season Week $currentWeek');

    // 1. Fetch ALL unfulfilled Buy Needs
    final allBuyNeeds = await (database.select(database.transferNeeds)
      ..where((t) => t.type.equals('buy'))..where((t) =>
          t.isFulfilled.equals(false)))
        .get();

    if (allBuyNeeds.isEmpty) return;

    // 2. Fetch ALL unfulfilled Sell Needs
    final allSellNeeds = await (database.select(database.transferNeeds)
      ..where((t) => t.type.equals('sell'))..where((t) =>
          t.isFulfilled.equals(false)))
        .get();

    // 3. Batch Fetch Players involved in Sell Needs
    // Extract player IDs to fetch only necessary players
    final playerIdsToFetch = allSellNeeds
        .where((n) => n.playerToSellId != null)
        .map((n) => n.playerToSellId!)
        .toSet();

    if (playerIdsToFetch.isEmpty) return;

    final playersList = await (database.select(database.players)
      ..where((t) => t.id.isIn(playerIdsToFetch)))
        .get();

    // Create a Map for O(1) lookup: PlayerID -> Player
    final Map<int, Player> playersMap = {
      for (var p in playersList) p.id: p
    };

    // 4. Batch Fetch Pending Offers to avoid duplicates
    // We only care about pending offers for the buy needs we have
    final buyNeedIds = allBuyNeeds.map((n) => n.id).toList();
    final pendingOffers = await (database.select(database.transferOffers)
      ..where((t) => t.needId.isIn(buyNeedIds))..where((t) =>
          t.status.equals('pending')))
        .get();

    // Create a Set of NeedIDs that already have a pending offer
    final Set<int> needsWithPendingOffers = pendingOffers
        .map((o) => o.needId)
        .toSet();

    // 5. Filter out players who already transferred THIS WINDOW
    // Rule: A player can only transfer once per window.
    int windowStartWeek = 1;
    if (currentWeek >= 29) windowStartWeek = 29;
    
    final recentlyTransferredOffers = await (database.select(database.transferOffers)
      ..where((t) => t.status.equals('accepted'))
      ..where((t) => t.season.equals(season)) // Filter by current season
      ..where((t) => t.createdAtWeek.isBiggerOrEqualValue(windowStartWeek)))
      .get();
      
    final recentlyTransferredPlayerIds = recentlyTransferredOffers.map((o) => o.playerId).toSet();
    print('[TransferEngine] Found ${recentlyTransferredPlayerIds.length} players already transferred this window. Excluding them.');

    // 6. Processing & Matching (In-Memory)
    final shuffledBuyNeeds = allBuyNeeds.toList()
      ..shuffle(_random);
    int offersCreated = 0;
    int needsProcessed = 0;

    // Use a transaction/batch insert if possible, but for now simple loop of inserts 
    // is fine since we calculate everything in memory first.

    print('[TransferEngine] Data fetch complete in ${DateTime
        .now()
        .difference(startTime)
        .inMilliseconds}ms');
    print('[TransferEngine] Processing ${shuffledBuyNeeds
        .length} buy needs against ${allSellNeeds.length} sell needs');

    for (final need in shuffledBuyNeeds) {
      if (offersCreated >= 50) break;
      needsProcessed++;

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
        final offerAmount = (sellNeed.minimumFee ?? player.marketValue) +
            _random.nextInt(500000);
        if (need.maxTransferBudget != null &&
            offerAmount > need.maxTransferBudget!) continue;

        final proposedSalary = (player.marketValue / 200).round();
        if (need.maxWeeklySalary != null &&
            proposedSalary > need.maxWeeklySalary!) continue;

        // Create offer
        await database.into(database.transferOffers).insert(
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
            ));

        offersCreated++;
        matchFound = true;
        print('[TransferEngine] OFFER CREATED (Listed): ${need
            .clubId} offered €${offerAmount / 1000000}M for Player ${player
            .id} to Club ${sellNeed.clubId}');
        break; // Match found for this buy need, move to next need
      }

      // 2. FALLBACK: Search General Player Pool (Unlisted)
      if (!matchFound) {
        // Query DB for a single random candidate that matches criteria
        // We limit this query heavily to avoid perf issues
        final query = database.select(database.players)

          ..where((p) => p.clubId.isNotNull()) // Must have a club
          ..where((p) => p.clubId.equals(need.clubId).not()) // Not own player
          ..where((p) =>
              p.id
                  .isIn(recentlyTransferredPlayerIds)
                  .not()) // EXCLUDE RECENTLY TRANSFERRED
          ..limit(10); // Get a small pool to pick from

        // Apply filters
        if (need.minAge != null) query.where((p) =>
            p.age.isBiggerOrEqualValue(need.minAge!));
        if (need.maxAge != null) query.where((p) =>
            p.age.isSmallerOrEqualValue(need.maxAge!));
        if (need.minCa != null) query.where((p) =>
            p.ca.isBiggerOrEqualValue(need.minCa!.toDouble()));
        // Position filter is tricky with string map, simplified check:
        // Ideally we would do this in Dart for precise 'DEF' mapping, OR use LIKE
        // For performance, let's fetch first then filter by position in Dart

        final candidates = await query.get();
        final validCandidates = candidates.where((p) {
          final pCat = positionCategories[p.position] ?? 'MID';
          return need.targetPosition == null || pCat == need.targetPosition;
        }).toList();

        if (validCandidates.isNotEmpty) {
          final player = validCandidates[_random.nextInt(
              validCandidates.length)];

          // Check budget
          int estimatedFee = (player.marketValue * 1.2)
              .toInt(); // 20% premium for unlisted
          if (need.maxTransferBudget == null ||
              estimatedFee <= need.maxTransferBudget!) {
            final proposedSalary = (player.marketValue / 200).round();

            if (need.maxWeeklySalary == null ||
                proposedSalary <= need.maxWeeklySalary!) {
              await database.into(database.transferOffers).insert(
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
                  ));
              offersCreated++;
              print('[TransferEngine] OFFER CREATED (Unlisted): ${need
                  .clubId} offered €${estimatedFee /
                  1000000}M for Player ${player.id} to Club ${player.clubId}');
            }
          }
        }
      }

      final endTime = DateTime.now();
      print(
          '[TransferEngine] Created $offersCreated offers. Total time: ${endTime
              .difference(startTime)
              .inMilliseconds}ms');
    }}

  /// Evaluate pending offers from previous day.
  /// Evaluate pending offers from previous day.
  /// Refactored: Groups offers by player, picks best offer, and auto-rejects others.
  Future<void> evaluateOffers(int season, int currentWeek) async {
    // Get offers created earlier than today (previous weeks/days)
    // Complex logic for season transition:
    // If season > offer.season -> Process it (it's from old season)
    // If season == offer.season AND currentWeek > offer.createdAtWeek -> Process it
    
    final pendingOffers = await (database.select(database.transferOffers)
      ..where((t) => t.status.equals('pending')))
      .get();
      
    // Filter in Dart for complex date logic
    final offersToProcess = pendingOffers.where((o) {
       if (o.season < season) return true;
       if (o.season == season && o.createdAtWeek < currentWeek) return true;
       return false;
    }).toList();
    
    // Group by Player ID
    final offersByPlayer = <int, List<TransferOffer>>{};
    for (var o in pendingOffers) {
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
      final currentPlayerParams = await (database.select(database.players)..where((t) => t.id.equals(playerId))).getSingleOrNull();
      
      if (currentPlayerParams == null || currentPlayerParams.clubId != bestOffer.toClubId) {
         // Player doesn't exist or has already moved to another club
         print('[TransferEngine] INVALID OFFER: Player $playerId is no longer at Club ${bestOffer.toClubId}. Rejecting offers.');
         final allIds = offers.map((o) => o.id).toList();
         await (database.update(database.transferOffers)..where((t) => t.id.isIn(allIds)))
            .write(const TransferOffersCompanion(status: Value('rejected')));
         continue; 
      }

      // Evaluate ONLY the best offer
      // Get the sell need
      final sellNeed = await (database.select(database.transferNeeds)
        ..where((t) => t.type.equals('sell'))
        ..where((t) => t.clubId.equals(bestOffer.toClubId))
        ..where((t) => t.playerToSellId.equals(bestOffer.playerId)))
        .getSingleOrNull();
      
      bool accepted = false;
      
      if (sellNeed != null) {
        // Check if offer meets minimum
        if (sellNeed.minimumFee == null || bestOffer.offerAmount >= sellNeed.minimumFee!) {
          accepted = true;
        }
      } else {
        // No explicit sell need, decide based on offer vs market value
        final player = await (database.select(database.players)..where((t) => t.id.equals(bestOffer.playerId))).getSingleOrNull();
        if (player != null && bestOffer.offerAmount >= player.marketValue * 0.9) {
          accepted = _random.nextBool(); // 50% chance
        }
      }
      
      if (accepted) {
        // 1. Accept Best Offer
        await _finalizeTransfer(bestOffer, season, currentWeek);
        print('[TransferEngine] ACCEPTED best offer for Player $playerId: €${bestOffer.offerAmount}');
        
        // 2. Auto-Reject all other offers for this player
        if (otherOffers.isNotEmpty) {
           final otherIds = otherOffers.map((o) => o.id).toList();
           await (database.update(database.transferOffers)..where((t) => t.id.isIn(otherIds)))
            .write(const TransferOffersCompanion(status: Value('rejected')));
           print('[TransferEngine] AUTO-REJECTED ${otherOffers.length} lower offers for Player $playerId');
        }
      } else {
        // Reject Best Offer (and implicitly reject others effectively, or we can mark ALL as rejected)
        // If the BEST offer is rejected, lower ones would definitely be rejected too.
        // So we reject ALL offers for this player this turn.
        final allIds = offers.map((o) => o.id).toList();
        await (database.update(database.transferOffers)..where((t) => t.id.isIn(allIds)))
          .write(const TransferOffersCompanion(status: Value('rejected')));
          
        print('[TransferEngine] REJECTED all ${offers.length} offers for Player $playerId (Best offer was €${bestOffer.offerAmount})');
      }
    }
  }



  /// Complete a transfer: update player, create contracts, log transfer.
  Future<void> _finalizeTransfer(TransferOffer offer, int season, int week) async {
    final now = DateTime.now();
    
    // 1. Update offer status
    await (database.update(database.transferOffers)..where((t) => t.id.equals(offer.id)))
      .write(const TransferOffersCompanion(status: Value('accepted')));
    
    // 2. Log transfer
    await database.into(database.transfers).insert(TransfersCompanion(
      playerId: Value(offer.playerId),
      fromClubId: Value(offer.toClubId),
      toClubId: Value(offer.fromClubId),
      date: Value(now),
      feeAmount: Value(offer.offerAmount.toDouble()),
      type: const Value('Permanent'),
      season: Value(season),
      week: Value(week),
    ));
    
    // 3. Update player's club
    await (database.update(database.players)..where((t) => t.id.equals(offer.playerId)))
      .write(PlayersCompanion(clubId: Value(offer.fromClubId)));
    
    // 4. Delete old club contract, create new one
    await (database.delete(database.clubContracts)..where((t) => t.playerId.equals(offer.playerId))).go();
    
    await database.into(database.clubContracts).insert(ClubContractsCompanion(
      clubId: Value(offer.fromClubId),
      playerId: Value(offer.playerId),
      weeklySalary: Value(offer.proposedSalary),
      startDate: Value(now),
      endDate: Value(now.add(Duration(days: 365 * offer.contractYears))),
      status: const Value('active'),
    ));
    
    // 5. Update Budgets
    // Selling Club (toClubId) -> Gains Transfer Fee
    final sellingClub = await (database.select(database.clubs)..where((t) => t.id.equals(offer.toClubId))).getSingle();
    await (database.update(database.clubs)..where((t) => t.id.equals(offer.toClubId)))
      .write(ClubsCompanion(transferBudget: Value(sellingClub.transferBudget + offer.offerAmount)));
      
    // Buying Club (fromClubId) -> Loses Transfer Fee
    final buyingClub = await (database.select(database.clubs)..where((t) => t.id.equals(offer.fromClubId))).getSingle();
    await (database.update(database.clubs)..where((t) => t.id.equals(offer.fromClubId)))
      .write(ClubsCompanion(transferBudget: Value(buyingClub.transferBudget - offer.offerAmount)));

    // 6. Mark buy need as fulfilled
    await (database.update(database.transferNeeds)..where((t) => t.id.equals(offer.needId)))
      .write(const TransferNeedsCompanion(isFulfilled: Value(true)));
    
    // 7. Mark sell need as fulfilled (if exists)
    await (database.update(database.transferNeeds)
      ..where((t) => t.type.equals('sell'))
      ..where((t) => t.playerToSellId.equals(offer.playerId)))
      .write(const TransferNeedsCompanion(isFulfilled: Value(true)));

    print('[TransferEngine] TRANSFER FINALIZED: Player ${offer.playerId} moved from Club ${offer.toClubId} to Club ${offer.fromClubId} for €${offer.offerAmount / 1000000}M');
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
}
