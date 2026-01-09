import 'package:drift/drift.dart';
import '../../../../leagues/data/datasources/tables/leagues_table.dart';

class Clubs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get leagueId => integer().nullable().references(Leagues, #id)();
  IntColumn get reputation => integer()();
  RealColumn get transferBudget => real()(); // Double for RealColumn
  RealColumn get wageBudget => real()();
}
