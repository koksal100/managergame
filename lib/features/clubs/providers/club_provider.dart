import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/database_provider.dart';
import '../data/repositories/club_repository_impl.dart';
import '../domain/entities/club.dart';
import '../domain/repositories/club_repository.dart';

final clubRepositoryProvider = Provider<ClubRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return ClubRepositoryImpl(database);
});

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
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (id) async {
         state = const AsyncValue.loading();
         state = await AsyncValue.guard(() => _fetchClubs());
      },
    );
  }
  
  // Implement update/delete similarly if needed
}

final clubsByLeagueProvider = FutureProvider.family<List<Club>, int>((ref, leagueId) async {
  final repository = ref.watch(clubRepositoryProvider);
  final result = await repository.getClubsByLeagueId(leagueId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (clubs) => clubs,
  );
});
