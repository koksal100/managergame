import 'package:drift/drift.dart';
import '../../../../clubs/data/datasources/tables/clubs_table.dart';
import '../../../../players/data/datasources/tables/players_table.dart';

class ClubContracts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clubId => integer().references(Clubs, #id)();
  IntColumn get playerId => integer().references(Players, #id)();
  
  // Financials
  IntColumn get weeklySalary => integer()(); // e.g. 50000 (Euros)
  IntColumn get releaseClause => integer().nullable()(); // Optional release clause
  
  // Duration
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  
  // Status
  TextColumn get status => text().withDefault(const Constant('active'))(); // active, offered, expired
}
