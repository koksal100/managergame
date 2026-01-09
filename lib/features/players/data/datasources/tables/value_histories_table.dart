import 'package:drift/drift.dart';
import '../../../../players/data/datasources/tables/players_table.dart';

class ValueHistories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  DateTimeColumn get date => dateTime()();
  RealColumn get value => real()();
}
