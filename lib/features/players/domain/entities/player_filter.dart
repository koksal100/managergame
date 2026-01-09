import 'package:equatable/equatable.dart';


enum PlayerSortType {
  ca,
  pa,
  age,
  name,
  reputation,
  marketValue
}

class PlayerFilter extends Equatable {
  final String? nameQuery;
  final List<String>? positions;
  final int? minAge;
  final int? maxAge;
  final int? minCa;
  final int? minPa;
  final int? minMarketValue;
  final int? maxMarketValue;
  final PlayerSortType sortType;
  final bool ascending;

  const PlayerFilter({
    this.nameQuery,
    this.positions,
    this.minAge,
    this.maxAge,
    this.minCa,
    this.minPa,
    this.minMarketValue,
    this.maxMarketValue,
    this.sortType = PlayerSortType.ca,
    this.ascending = false,
  });

  PlayerFilter copyWith({
    String? nameQuery,
    List<String>? positions,
    int? minAge,
    int? maxAge,
    int? minCa,
    int? minPa,
    int? minMarketValue,
    int? maxMarketValue,
    PlayerSortType? sortType,
    bool? ascending,
  }) {
    return PlayerFilter(
      nameQuery: nameQuery ?? this.nameQuery,
      positions: positions ?? this.positions,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      minCa: minCa ?? this.minCa,
      minPa: minPa ?? this.minPa,
      minMarketValue: minMarketValue ?? this.minMarketValue,
      maxMarketValue: maxMarketValue ?? this.maxMarketValue,
      sortType: sortType ?? this.sortType,
      ascending: ascending ?? this.ascending,
    );
  }

  bool get isEmpty => 
    (nameQuery == null || nameQuery!.isEmpty) &&
    (positions == null || positions!.isEmpty) &&
    minAge == null &&
    maxAge == null &&
    minCa == null &&
    minPa == null &&
    minMarketValue == null &&
    maxMarketValue == null &&
    sortType == PlayerSortType.ca && // Default sort
    ascending == false;

  @override
  List<Object?> get props => [nameQuery, positions, minAge, maxAge, minCa, minPa, minMarketValue, maxMarketValue, sortType, ascending];
}
