import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/repository_providers.dart';
import '../../../matches/domain/entities/match.dart'; // Import correctly? check path
import '../../../matches/domain/entities/match.dart';
import '../../../clubs/domain/entities/club.dart';

class FixtureItem extends Equatable {
  final Match match;
  final String homeClubName;
  final String awayClubName;

  const FixtureItem({
    required this.match,
    required this.homeClubName,
    required this.awayClubName,
  });

  @override
  List<Object?> get props => [match, homeClubName, awayClubName];
}

class FixtureParams extends Equatable {
  final int leagueId;
  final int week;

  const FixtureParams({required this.leagueId, required this.week});

  @override
  List<Object?> get props => [leagueId, week];
}

final fixtureProvider = FutureProvider.family<List<FixtureItem>, FixtureParams>((ref, params) async {
  final matchRepo = ref.watch(matchRepositoryProvider);
  final clubRepo = ref.watch(clubRepositoryProvider);

  // 1. Fetch Matches
  // Assuming Season 1 for now, as global gameDateProvider holds generic week.
  // We should pass season too if needed, but defaulting to 1 is fine for MVP.
  final matches = await matchRepo.getMatchesByLeagueAndWeek(params.leagueId, 1, params.week);

  // 2. Fetch Clubs for Name Mapping
  // Optimization: Could cache this at league level.
  final clubsResult = await clubRepo.getClubsByLeagueId(params.leagueId);
  
  return clubsResult.fold(
    (failure) => [], 
    (clubs) {
      final clubMap = {for (var c in clubs) c.id: c.name};

      return matches.map((m) {
        return FixtureItem(
          match: m,
          homeClubName: clubMap[m.homeClubId] ?? 'Unknown',
          awayClubName: clubMap[m.awayClubId] ?? 'Unknown',
        );
      }).toList();
    }
  );
});
