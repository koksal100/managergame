import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import 'player_value_calculator.dart';

class PlayerGrowthService {
  final AppDatabase database;

  PlayerGrowthService(this.database);

  /// Run player growth cycle if applicable for the current week.
  /// Cycle: First time Week 14, then every 5 weeks (19, 24, 29, 34, 39, 44, 49).
  Future<void> processGrowthCycle(int season, int currentWeek) async {
    // Check if it's a growth week
    // Logic: Starts at 14, repeats every 5.
    // (14 - 14) % 5 == 0 -> True
    // (19 - 14) % 5 == 0 -> True
    // Also must be >= 14
    if (currentWeek < 14 || (currentWeek - 14) % 5 != 0) {
      return;
    }

    print('[PlayerGrowthService] Starting growth cycle for Season $season Week $currentWeek');
    final startTime = DateTime.now();

    // 1. Fetch all active players
    final players = await database.select(database.players).get();
    
    // 2. Fetch Performance Stats for the last 5 weeks
    // We need to count matches played per player in the relevant period.
    // Period: [currentWeek - 5, currentWeek - 1] basically.
    // Since this runs AFTER matches of currentWeek might be simulated or BEFORE?
    // Usually SimulationService calls this *after* generic updates or *during* week processing.
    // Let's assume it runs at start of week processing or end.
    // If it runs at start of Week 14, it processes performance up to Week 13.
    // Let's assume we look at all performances for this season so far, or just last 5 weeks?
    // "son 5 hafta boyunca" -> Last 5 weeks.
    
    final lookbackStartWeek = currentWeek - 5;
    
    final performances = await (database.select(database.performances)
      ..where((p) => p.season.equals(season))
      ..where((p) => p.week.isBiggerOrEqualValue(lookbackStartWeek))
      ..where((p) => p.week.isSmallerThanValue(currentWeek)))
      .get();

    // Map PlayerId -> Match Count
    final Map<int, int> matchCounts = {};
    for (var p in performances) {
      matchCounts[p.playerId] = (matchCounts[p.playerId] ?? 0) + 1;
    }

    int updatedCount = 0;

    // 3. Process each player
    for (var player in players) {
      // Calculate limit based on age
      // 18yo -> 5 matches
      // 30yo -> 15 matches
      // Linear interpolation
      double requiredMatches;
      if (player.age <= 18) {
        requiredMatches = 5.0;
      } else if (player.age >= 30) {
        requiredMatches = 15.0;
      } else {
        // Slope m = (15 - 5) / (30 - 18) = 10 / 12 = 0.833
        // y - 5 = 0.833 * (x - 18)
        requiredMatches = 5.0 + (0.8333 * (player.age - 18));
      }

      final playedMatches = matchCounts[player.id] ?? 0;
      
      // Determine Growth
      // If played >= required -> +1 CA (or fraction since CA is now double?)
      // User said: "oyuncunun currentAbilitysini doubleye çevirelim... ondalıklı hesaplamalar"
      // "18 yaşında... 5 maçta oynadıysa 1 artacak" -> Full +1 update?
      // Since we run every 5 weeks, +1 every 5 weeks is HUGE. That's +10 per season.
      // Maybe user means +1.0 is the full reward?
      // Standard progression is slower. But let's follow user instruction: "1 artacak".
      // Let's stick to user request.
      
      double change = 0.0;
      if (playedMatches >= requiredMatches) {
         change = 1.0;
      } else {
         // Maybe partial growth or decay?
         // User didn't specify decay, but usually lack of playtime = stagnation or subtle decay.
         // Let's implement stagnation (0) for now unless partial is better.
         // "son 5 hafta boyunca her maçta oynadıysa 1 artacak" implies strict threshold.
         // But what if 4 matches? 
         // Let's allow partial growth proportional to playtime? 
         // "aradaki yaşlarıda da oranlamayı lineer yap" referred to age/matches requirement.
         // I will strictly Add 1.0 if threshold met, else 0.
         // Actually, "1 artacak" might be integer +1.
      }
      
      // Cap CA at PA
      double newCa = player.ca + change;
      if (newCa > player.pa) newCa = player.pa.toDouble();
      // Hard cap at 99 or 100?
      if (newCa > 99) newCa = 99.0;

      // Update Database if changed or just periodically update value history
      if (change > 0 || (currentWeek % 5 == 0)) { // Update value anyway periodically
         // Recalculate Value
         final newVal = PlayerValueCalculator.calculateMarketValue(newCa, player.age, player.position);
         
         // Update Player
         await (database.update(database.players)..where((t) => t.id.equals(player.id)))
           .write(PlayersCompanion(
             ca: Value(newCa),
             marketValue: Value(newVal),
             reputation: Value(newCa.round()), // Rep synonymous with CA often
           ));
           
         // Log CA History
         await database.into(database.currentAbilityHistories).insert(
           CurrentAbilityHistoriesCompanion(
             playerId: Value(player.id),
             season: Value(season),
             week: Value(currentWeek),
             ca: Value(newCa),
           )
         );
         
         // Log Value History
         await database.into(database.valueHistories).insert(
           ValueHistoriesCompanion(
             playerId: Value(player.id),
             season: Value(season),
             week: Value(currentWeek),
             value: Value(newVal.toDouble()),
           )
         );
         
         updatedCount++;
      }
    }

    final duration = DateTime.now().difference(startTime);
    print('[PlayerGrowthService] Updated $updatedCount players in ${duration.inMilliseconds}ms');
  }
}
