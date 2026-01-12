import 'package:equatable/equatable.dart';

class PlayerValueHistory extends Equatable {
  final int id;
  final int playerId;
  final int season;
  final int week;
  final double value;

  const PlayerValueHistory({
    required this.id,
    required this.playerId,
    required this.season,
    required this.week,
    required this.value,
  });

  @override
  List<Object?> get props => [id, playerId, season, week, value];
}

class PlayerCaHistory extends Equatable {
  final int id;
  final int playerId;
  final int season;
  final int week;
  final double ca;

  const PlayerCaHistory({
    required this.id,
    required this.playerId,
    required this.season,
    required this.week,
    required this.ca,
  });

  @override
  List<Object?> get props => [id, playerId, season, week, ca];
}
