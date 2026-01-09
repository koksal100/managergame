import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/player.dart';
import '../../domain/repositories/player_repository.dart';
import '../../data/repositories/player_repository_impl.dart';
import '../../../../core/database/app_database.dart' hide Player;
import '../../../../core/providers/database_provider.dart';
import '../../domain/entities/player_filter.dart';

// Repository Provider
final playerRepositoryProvider = Provider<PlayerRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return PlayerRepositoryImpl(database);
});


// Filter State Provider
final playerFilterProvider = StateProvider<PlayerFilter>((ref) => const PlayerFilter());

// Filtered Players Provider (Future)
final filteredPlayersProvider = FutureProvider<List<Player>>((ref) async {
  final repository = ref.watch(playerRepositoryProvider);
  final filter = ref.watch(playerFilterProvider);

  final result = await repository.getPlayers(filter: filter);

  return result.fold(
    (failure) => <Player>[], // Return empty list on failure or handle error differently
    (players) => players,
  );
});

// Players by Club Provider (Family)
final playersByClubProvider = FutureProvider.family<List<Player>, int>((ref, clubId) async {
  final repository = ref.watch(playerRepositoryProvider);
  final result = await repository.getPlayersByClubId(clubId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (players) => players,
  );
});
