import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/database_provider.dart';
import '../data/repositories/league_repository_impl.dart';
import '../domain/entities/league.dart';
import '../domain/repositories/league_repository.dart';

final leagueRepositoryProvider = Provider<LeagueRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return LeagueRepositoryImpl(database);
});

final leaguesProvider = AsyncNotifierProvider<LeaguesNotifier, List<League>>(() {
  return LeaguesNotifier();
});

class LeaguesNotifier extends AsyncNotifier<List<League>> {
  @override
  Future<List<League>> build() async {
    final repository = ref.read(leagueRepositoryProvider);
    final result = await repository.getLeagues();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (leagues) => leagues,
    );
  }
}
