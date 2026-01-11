import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final int id;
  final String name;
  final int age;
  final int? clubId;
  final int? agentId;
  final String position;
  final int ca; // Current Ability
  final int pa; // Potential Ability
  final int reputation;
  final int marketValue;

  const Player({
    required this.id,
    required this.name,
    required this.age,
    this.clubId,
    this.agentId,
    required this.position,
    required this.ca,
    required this.pa,
    required this.reputation,
    required this.marketValue,
  });

  @override
  List<Object?> get props => [
    id, name, age, clubId, agentId, position, ca, pa, reputation, marketValue
  ];
}


