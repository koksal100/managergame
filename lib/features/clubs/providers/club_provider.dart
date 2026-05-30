import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/repository_providers.dart';
import '../domain/entities/club.dart';

final clubsProvider = AsyncNotifierProvider<ClubsNotifier, List<Club>>(() {
  return ClubsNotifier();
});

class ClubsNotifier extends AsyncNotifier<List<Club>> {
  @override
  Future<List<Club>> build() async {
    return _fetchClubs();
  }

  Future<List<Club>> _fetchClubs() async {
    final repository = ref.read(clubRepositoryProvider);
    final result = await repository.getClubs();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (clubs) => clubs,
    );
  }

  Future<void> addClub(Club club) async {
    final repository = ref.read(clubRepositoryProvider);
    final result = await repository.createClub(club);

    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (id) async {
        state = const AsyncValue.loading();
        state = await AsyncValue.guard(() => _fetchClubs());
      },
    );
  }

  // Implement update/delete similarly if needed
}

final clubsByLeagueProvider = FutureProvider.family<List<Club>, int>((
  ref,
  leagueId,
) async {
  final repository = ref.watch(clubRepositoryProvider);
  final result = await repository.getClubsByLeagueId(leagueId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (clubs) => clubs,
  );
});

final clubByIdProvider = FutureProvider.family<Club, int>((ref, clubId) async {
  final repository = ref.watch(clubRepositoryProvider);
  final result = await repository.getClubById(clubId);
  return result.fold((failure) => throw Exception(failure), (club) => club);
});
