import 'package:equatable/equatable.dart';

class ClubContractEntity extends Equatable {
  final int id;
  final int clubId;
  final int playerId;
  final int weeklySalary;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final int? releaseClause;

  const ClubContractEntity({
    required this.id,
    required this.clubId,
    required this.playerId,
    required this.weeklySalary,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.releaseClause,
  });

  @override
  List<Object?> get props => [id, clubId, playerId, weeklySalary, startDate, endDate, status, releaseClause];
}

class AgentContractEntity extends Equatable {
  final int id;
  final int agentId;
  final int playerId;
  final double feePercentage;
  final DateTime startDate;
  final DateTime endDate;
  final String status;

  const AgentContractEntity({
    required this.id,
    required this.agentId,
    required this.playerId,
    required this.feePercentage,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  @override
  List<Object?> get props => [id, agentId, playerId, feePercentage, startDate, endDate, status];
}
