import 'package:equatable/equatable.dart';

class Performance extends Equatable {
  final int id;
  final int matchId;
  final int playerId;
  final int minutesPlayed;
  final int goals;
  final int assists;
  final int yellowCards;
  final int redCards;
  final int season;
  final double rating;

  const Performance({
    required this.id,
    required this.matchId,
    required this.playerId,
    required this.minutesPlayed,
    required this.goals,
    required this.assists,
    required this.yellowCards,
    required this.redCards,
    required this.season,
    required this.rating,
  });

  @override
  List<Object?> get props => [id, matchId, playerId, minutesPlayed, goals, assists, yellowCards, redCards, season, rating];
}
