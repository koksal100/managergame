class GameTime {
  final int season;
  final int week;

  const GameTime(this.season, this.week);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameTime &&
          runtimeType == other.runtimeType &&
          season == other.season &&
          week == other.week;

  @override
  int get hashCode => season.hashCode ^ week.hashCode;

  @override
  String toString() {
    return 'Season $season, Week $week';
  }
}
