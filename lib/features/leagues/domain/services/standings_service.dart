


import '../../../clubs/domain/entities/club.dart';
import '../../../clubs/domain/repositories/club_repository.dart';
import '../../../matches/domain/repositories/match_repository.dart';

class LeagueStanding {
  final Club club;
  final int played;
  final int won;
  final int drawn;
  final int lost;
  final int goalsFor;
  final int goalsAgainst;

  int get goalDifference => goalsFor - goalsAgainst;
  int get points => (won * 3) + drawn;

  LeagueStanding({
    required this.club,
    this.played = 0,
    this.won = 0,
    this.drawn = 0,
    this.lost = 0,
    this.goalsFor = 0,
    this.goalsAgainst = 0,
  });
}

class StandingsService {
  final ClubRepository _clubRepository;
  final MatchRepository _matchRepository;

  StandingsService(this._clubRepository, this._matchRepository);

  Future<List<LeagueStanding>> getStandings(int leagueId) async {
    // 1. Get clubs in league
    final result = await _clubRepository.getClubsByLeagueId(leagueId);

    return result.fold(
      (failure) => [], // Return empty list on failure
      (clubs) async {
        List<LeagueStanding> standings = [];

        for (var club in clubs) {
          // 2. Get matches for this club
          final matches = await _matchRepository.getMatchesByClub(club.id);
          
          int played = 0;
          int won = 0;
          int drawn = 0;
          int lost = 0;
          int gf = 0;
          int ga = 0;

          for (var match in matches) {
            if (!match.isPlayed) continue;
            
            // Check if home or away
            bool isHome = match.homeClubId == club.id;
            int myScore = isHome ? (match.homeScore ?? 0) : (match.awayScore ?? 0);
            int opScore = isHome ? (match.awayScore ?? 0) : (match.homeScore ?? 0);

            played++;
            gf += myScore;
            ga += opScore;

            if (myScore > opScore) {
              won++;
            } else if (myScore == opScore) {
              drawn++;
            } else {
              lost++;
            }
          }

          standings.add(LeagueStanding(
            club: club,
            played: played,
            won: won,
            drawn: drawn,
            lost: lost,
            goalsFor: gf,
            goalsAgainst: ga,
          ));
        }

        // 3. Sort
        standings.sort((a, b) {
          if (b.points != a.points) return b.points.compareTo(a.points);
          if (b.goalDifference != a.goalDifference) return b.goalDifference.compareTo(a.goalDifference);
          return b.goalsFor.compareTo(a.goalsFor);
        });

        return standings;
      },
    );
  }
}
