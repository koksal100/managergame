import 'package:equatable/equatable.dart';

class Agent extends Equatable {
  final int id;
  final String name;
  final double balance;
  final int reputation;
  final int negotiationSkill;
  final int scoutingSkill;
  final int level;

  const Agent({
    required this.id,
    required this.name,
    required this.balance,
    required this.reputation,
    required this.negotiationSkill,
    required this.scoutingSkill,
    required this.level,
  });

  Agent copyWith({
    int? id,
    String? name,
    double? balance,
    int? reputation,
    int? negotiationSkill,
    int? scoutingSkill,
    int? level,
  }) {
    return Agent(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      reputation: reputation ?? this.reputation,
      negotiationSkill: negotiationSkill ?? this.negotiationSkill,
      scoutingSkill: scoutingSkill ?? this.scoutingSkill,
      level: level ?? this.level,
    );
  }

  @override
  List<Object?> get props => [
    id, name, balance, reputation, negotiationSkill, scoutingSkill, level
  ];
}
