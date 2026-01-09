import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final gameDateProvider = StateNotifierProvider<GameDateNotifier, int>((ref) {
  return GameDateNotifier();
});

class GameDateNotifier extends StateNotifier<int> {
  GameDateNotifier() : super(1) {
    _loadDate();
  }

  static const _keyWeek = 'game_week';

  Future<void> _loadDate() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getInt(_keyWeek) ?? 1;
  }

  Future<void> advanceWeek() async {
    state++;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyWeek, state);
  }
}
