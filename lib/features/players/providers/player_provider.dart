import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/repository_providers.dart';
import '../domain/entities/player.dart';

// State Management (AsyncNotifier)
// This provider manages the list of players.
final playersProvider = AsyncNotifierProvider<PlayersNotifier, List<Player>>(
  () {
    return PlayersNotifier();
  },
);

class PlayersNotifier extends AsyncNotifier<List<Player>> {
  // Initial Fetch
  @override
  Future<List<Player>> build() async {
    return _fetchPlayers();
  }

  Future<List<Player>> _fetchPlayers() async {
    final repository = ref.read(playerRepositoryProvider);
    final result = await repository.getPlayers();

    return result.fold(
      (failure) => throw Exception(failure.message),
      (players) => players,
    );
  }

  // Create
  Future<void> addPlayer(Player player) async {
    // Set loading state if desired, or just wait
    // state = const AsyncValue.loading(); // Optional optimistic

    final repository = ref.read(playerRepositoryProvider);
    final result = await repository.createPlayer(player);

    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (id) async {
        // Refresh list after add
        // Ideally we just append to list locally to match "Optimistic UI"
        // But refetching is safer for ensuring DB consistency
        state = const AsyncValue.loading();
        state = await AsyncValue.guard(() => _fetchPlayers());
      },
    );
  }

  // Add other methods (update, delete) as needed...
}
