import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/repository_providers.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/player_filter.dart';

// Filter State Provider
final playerFilterProvider = StateProvider<PlayerFilter>(
  (ref) => const PlayerFilter(),
);

// Filtered Players Provider (Future)
final filteredPlayersProvider = FutureProvider<List<Player>>((ref) async {
  final repository = ref.watch(playerRepositoryProvider);
  final filter = ref.watch(playerFilterProvider);

  final result = await repository.getPlayers(filter: filter);

  return result.fold(
    (failure) =>
        <Player>[], // Return empty list on failure or handle error differently
    (players) => players,
  );
});

// Players by Club Provider (Family)
final playersByClubProvider = FutureProvider.family<List<Player>, int>((
  ref,
  clubId,
) async {
  final repository = ref.watch(playerRepositoryProvider);
  final result = await repository.getPlayersByClubId(clubId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (players) => players,
  );
});

// Players by Agent Provider (Family)
final playersByAgentProvider = FutureProvider.family<List<Player>, int>((
  ref,
  agentId,
) async {
  final repository = ref.watch(playerRepositoryProvider);
  final result = await repository.getPlayersByAgentId(agentId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (players) => players,
  );
});
