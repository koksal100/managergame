import 'package:equatable/equatable.dart';

class Relationship extends Equatable {
  final int id;
  final int fromId;
  final int toId;
  final String fromType;
  final String toType;
  final int score;

  const Relationship({
    required this.id,
    required this.fromId,
    required this.toId,
    required this.fromType,
    required this.toType,
    required this.score,
  });

  @override
  List<Object?> get props => [id, fromId, toId, fromType, toType, score];
}
