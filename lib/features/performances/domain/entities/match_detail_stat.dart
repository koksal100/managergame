import 'package:equatable/equatable.dart';

class MatchDetailStat extends Equatable {
  final int playerId;
  final String playerName;
  final int clubId;
  final int goals;
  final int assists;
  final double rating;

  const MatchDetailStat({
    required this.playerId,
    required this.playerName,
    required this.clubId,
    required this.goals,
    required this.assists,
    required this.rating,
  });

  @override
  List<Object?> get props => [playerId, playerName, clubId, goals, assists, rating];
}
