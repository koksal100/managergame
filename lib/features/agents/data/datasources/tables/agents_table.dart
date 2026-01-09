import 'package:drift/drift.dart';

class Agents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get balance => real()();
  IntColumn get reputation => integer()();
  IntColumn get negotiationSkill => integer()();
  IntColumn get scoutingSkill => integer()();
  IntColumn get level => integer()();
}
