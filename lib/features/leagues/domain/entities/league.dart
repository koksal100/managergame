import 'package:equatable/equatable.dart';

class League extends Equatable {
  final int id;
  final String name;
  final int countryId;
  final int reputation;

  const League({
    required this.id,
    required this.name,
    required this.countryId,
    required this.reputation,
  });

  @override
  List<Object?> get props => [id, name, countryId, reputation];
}
