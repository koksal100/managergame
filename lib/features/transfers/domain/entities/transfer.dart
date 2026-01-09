import 'package:equatable/equatable.dart';

class Transfer extends Equatable {
  final int id;
  final int playerId;
  final int fromClubId;
  final int toClubId;
  final DateTime date;
  final double feeAmount;
  final String type;

  const Transfer({
    required this.id,
    required this.playerId,
    required this.fromClubId,
    required this.toClubId,
    required this.date,
    required this.feeAmount,
    required this.type,
  });

  @override
  List<Object?> get props => [
    id, playerId, fromClubId, toClubId, date, feeAmount, type
  ];
}
