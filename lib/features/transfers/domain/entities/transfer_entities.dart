import 'package:equatable/equatable.dart';

class TransferNeedEntity extends Equatable {
  final int id;
  final int clubId;
  final String type; // 'buy' or 'sell'
  
  // For buy needs
  final String? targetPosition;
  final int? minAge;
  final int? maxAge;
  final int? minCa;
  final int? maxTransferBudget;
  final int? maxWeeklySalary;
  
  // For sell needs
  final int? playerToSellId;
  final int? minimumFee;
  
  final bool isFulfilled;

  const TransferNeedEntity({
    required this.id,
    required this.clubId,
    required this.type,
    this.targetPosition,
    this.minAge,
    this.maxAge,
    this.minCa,
    this.maxTransferBudget,
    this.maxWeeklySalary,
    this.playerToSellId,
    this.minimumFee,
    this.isFulfilled = false,
  });

  @override
  List<Object?> get props => [id, clubId, type, targetPosition, minAge, maxAge, minCa, maxTransferBudget, maxWeeklySalary, playerToSellId, minimumFee, isFulfilled];
}

class TransferOfferEntity extends Equatable {
  final int id;
  final int fromClubId;
  final int toClubId;
  final int playerId;
  final int needId;
  final int offerAmount;
  final int proposedSalary;
  final int contractYears;
  final int createdAtWeek;
  final String status; // pending, accepted, rejected

  const TransferOfferEntity({
    required this.id,
    required this.fromClubId,
    required this.toClubId,
    required this.playerId,
    required this.needId,
    required this.offerAmount,
    required this.proposedSalary,
    required this.contractYears,
    required this.createdAtWeek,
    required this.status,
  });

  @override
  List<Object?> get props => [id, fromClubId, toClubId, playerId, needId, offerAmount, proposedSalary, contractYears, createdAtWeek, status];
}
