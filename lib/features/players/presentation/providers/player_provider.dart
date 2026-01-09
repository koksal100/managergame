import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/player.dart';
import '../../domain/repositories/player_repository.dart';
import '../../data/repositories/player_repository_impl.dart';
import '../../../../core/database/app_database.dart' hide Player;
import '../../../../core/providers/database_provider.dart';

// Repository Provider
final playerRepositoryProvider = Provider<PlayerRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return PlayerRepositoryImpl(database);
});

// Search Query Provider (State)
final playerSearchQueryProvider = StateProvider<String>((ref) => '');

// Filtered Players Provider (Future)
final filteredPlayersProvider = FutureProvider<List<Player>>((ref) async {
  final repository = ref.watch(playerRepositoryProvider);
  final query = ref.watch(playerSearchQueryProvider);

  Either<Failure, List<Player>> result;
  
  if (query.isEmpty) {
    // Optionally return top 50 players or empty if we don't want to show all immediately
    // For now let's return all (might be heavy if 5000+) or maybe limit?
    // Let's rely on repository.getPlayers() but maybe we should limit init load.
    // Let's start with just searching.
    result = await repository.getPlayers();
  } else {
    result = await repository.searchPlayers(query);
  }

  return result.fold(
    (failure) => [],
    (players) => players,
  );
});
