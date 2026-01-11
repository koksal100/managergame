import 'package:drift/drift.dart';
import '../../../../players/data/datasources/tables/players_table.dart';
import '../../../../clubs/data/datasources/tables/clubs_table.dart';

class Transfers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  IntColumn get fromClubId => integer().references(Clubs, #id)();
  IntColumn get toClubId => integer().references(Clubs, #id)();
  DateTimeColumn get date => dateTime()();
  RealColumn get feeAmount => real()();
  TextColumn get type => text()(); // Loan, Permanent
  IntColumn get season => integer().withDefault(const Constant(1))();
  IntColumn get week => integer().withDefault(const Constant(1))();
}
