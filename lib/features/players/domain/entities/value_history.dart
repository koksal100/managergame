import 'package:equatable/equatable.dart';

class ValueHistory extends Equatable {
  final int id;
  final int playerId;
  final DateTime date;
  final double value;

  const ValueHistory({
    required this.id,
    required this.playerId,
    required this.date,
    required this.value,
  });

  @override
  List<Object?> get props => [id, playerId, date, value];
}
