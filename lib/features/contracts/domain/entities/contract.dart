import 'package:equatable/equatable.dart';

class Contract extends Equatable {
  final int id;
  final int playerId;
  final int? agentId;
  final DateTime startDate;
  final DateTime endDate;
  final double wage;
  final double releaseClause;
  final String status;

  const Contract({
    required this.id,
    required this.playerId,
    this.agentId,
    required this.startDate,
    required this.endDate,
    required this.wage,
    required this.releaseClause,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id, playerId, agentId, startDate, endDate, wage, releaseClause, status
  ];
}
