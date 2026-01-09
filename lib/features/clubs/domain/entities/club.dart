import 'package:equatable/equatable.dart';

class Club extends Equatable {
  final int id;
  final String name;
  final int? leagueId;
  final int reputation;
  final double transferBudget;
  final double wageBudget;

  const Club({
    required this.id,
    required this.name,
    this.leagueId,
    required this.reputation,
    required this.transferBudget,
    required this.wageBudget,
  });

  @override
  List<Object?> get props => [
    id, name, leagueId, reputation, transferBudget, wageBudget
  ];
}
