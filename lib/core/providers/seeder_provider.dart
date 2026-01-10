import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database_provider.dart';
import '../seeder/game_seeder.dart';

final gameSeederProvider = Provider<GameSeeder>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return GameSeeder(database);
});

final initializationProvider = FutureProvider<void>((ref) async {
  final seeder = ref.watch(gameSeederProvider);
  // Simple check: if no countries, assume empty and seed
  final countries = await seeder.database.select(seeder.database.countries).get();
  if (countries.isEmpty) {
    await seeder.seed();
    await seeder.seedFixtures();
  } else {
    // Ensure fixtures are seeded even if DB exists
    await seeder.seedFixtures();
    // Ensure user agent exists for upgraded saves
    await seeder.seedUserAgent();
  }
});
