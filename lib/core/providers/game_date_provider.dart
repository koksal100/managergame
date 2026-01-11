import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_time.dart';

final gameDateProvider = StateNotifierProvider<GameDateNotifier, GameTime>((ref) {
  return GameDateNotifier();
});

class GameDateNotifier extends StateNotifier<GameTime> {
  GameDateNotifier() : super(const GameTime(1, 1)) {
    _loadDate();
  }

  static const _keySeason = 'game_season';
  static const _keyWeek = 'game_week';

  Future<void> _loadDate() async {
    final prefs = await SharedPreferences.getInstance();
    final season = prefs.getInt(_keySeason) ?? 1;
    final week = prefs.getInt(_keyWeek) ?? 1;
    state = GameTime(season, week);
  }

  Future<void> advanceWeek() async {
    int nextWeek = state.week + 1;
    int nextSeason = state.season;

    if (nextWeek > 52) {
      nextWeek = 1;
      nextSeason++;
    }

    state = GameTime(nextSeason, nextWeek);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keySeason, nextSeason);
    await prefs.setInt(_keyWeek, nextWeek);
  }
}
