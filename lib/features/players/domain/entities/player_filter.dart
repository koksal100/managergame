import 'package:equatable/equatable.dart';

class PlayerFilter extends Equatable {
  final String? nameQuery;
  final List<String>? positions;
  final int? minAge;
  final int? maxAge;
  final int? minCa;
  final int? minPa;

  const PlayerFilter({
    this.nameQuery,
    this.positions,
    this.minAge,
    this.maxAge,
    this.minCa,
    this.minPa,
  });

  PlayerFilter copyWith({
    String? nameQuery,
    List<String>? positions,
    int? minAge,
    int? maxAge,
    int? minCa,
    int? minPa,
  }) {
    return PlayerFilter(
      nameQuery: nameQuery ?? this.nameQuery,
      positions: positions ?? this.positions,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      minCa: minCa ?? this.minCa,
      minPa: minPa ?? this.minPa,
    );
  }

  bool get isEmpty => 
    (nameQuery == null || nameQuery!.isEmpty) &&
    (positions == null || positions!.isEmpty) &&
    minAge == null &&
    maxAge == null &&
    minCa == null &&
    minPa == null;

  @override
  List<Object?> get props => [nameQuery, positions, minAge, maxAge, minCa, minPa];
}
