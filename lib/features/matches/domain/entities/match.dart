import 'package:equatable/equatable.dart';

class Match extends Equatable {
  final int id;
  final int homeClubId;
  final int awayClubId;
  final int? homeScore;
  final int? awayScore;
  final int season;
  final int week;
  final bool isPlayed;

  const Match({
    required this.id,
    required this.homeClubId,
    required this.awayClubId,
    this.homeScore,
    this.awayScore,
    required this.season,
    required this.week,
    this.isPlayed = false,
  });

  @override
  List<Object?> get props => [id, homeClubId, awayClubId, homeScore, awayScore, season, week, isPlayed];
}
