import 'package:drift/drift.dart';
import '../../../../matches/data/datasources/tables/matches_table.dart';
import '../../../../players/data/datasources/tables/players_table.dart';

class Performances extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get matchId => integer().references(Matches, #id)();
  IntColumn get playerId => integer().references(Players, #id)();
  IntColumn get minutesPlayed => integer().withDefault(const Constant(0))();
  IntColumn get goals => integer().withDefault(const Constant(0))();
  IntColumn get assists => integer().withDefault(const Constant(0))();
  IntColumn get yellowCards => integer().withDefault(const Constant(0))();
  IntColumn get redCards => integer().withDefault(const Constant(0))();
  IntColumn get season => integer().withDefault(const Constant(1))();
  RealColumn get rating => real().withDefault(const Constant(0.0))();
}
