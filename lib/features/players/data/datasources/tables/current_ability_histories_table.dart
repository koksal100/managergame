import 'package:drift/drift.dart';
import 'players_table.dart';

class CurrentAbilityHistories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  IntColumn get season => integer()();
  IntColumn get week => integer()();
  RealColumn get ca => real()();
}
