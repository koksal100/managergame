import 'package:flutter_test/flutter_test.dart';
import 'package:managergame/core/models/game_time.dart';
import 'package:managergame/features/players/domain/services/player_value_calculator.dart';

void main() {
  test('game time value equality works', () {
    expect(const GameTime(1, 12), equals(const GameTime(1, 12)));
    expect(const GameTime(1, 12), isNot(equals(const GameTime(2, 12))));
  });

  test('players aged 33 and over receive the veteran value discount', () {
    final age32Value = PlayerValueCalculator.calculateMarketValue(
      80,
      32,
      'MID',
    );
    final age33Value = PlayerValueCalculator.calculateMarketValue(
      80,
      33,
      'MID',
    );

    expect(age33Value, lessThan(age32Value));
  });
}
