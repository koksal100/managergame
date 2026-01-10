class PlayerStat {
  final int playerId;
  final String playerName;
  final String clubName;
  final int goals;
  final int assists;
  final double averageRating;
  final int matchesPlayed;

  PlayerStat({
    required this.playerId,
    required this.playerName,
    required this.clubName,
    required this.goals,
    required this.assists,
    required this.averageRating,
    required this.matchesPlayed,
  });
}
