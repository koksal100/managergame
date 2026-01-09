import 'package:drift/drift.dart';

class Leagues extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get countryId => integer()();
  IntColumn get reputation => integer()();
}
