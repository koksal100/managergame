import 'package:drift/drift.dart';
import '../../../../clubs/data/datasources/tables/clubs_table.dart';
import '../../../../players/data/datasources/tables/players_table.dart';

class TransferNeeds extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clubId => integer().references(Clubs, #id)();
  TextColumn get type => text()(); // 'buy' or 'sell'
  
  // For 'buy' needs
  TextColumn get targetPosition => text().nullable()(); // GK, DEF, MID, FWD
  IntColumn get minAge => integer().nullable()();
  IntColumn get maxAge => integer().nullable()();
  IntColumn get minCa => integer().nullable()();
  IntColumn get maxTransferBudget => integer().nullable()();
  IntColumn get maxWeeklySalary => integer().nullable()();
  
  // For 'sell' needs
  IntColumn get playerToSellId => integer().nullable().references(Players, #id)();
  IntColumn get minimumFee => integer().nullable()();
  
  BoolColumn get isFulfilled => boolean().withDefault(const Constant(false))();
}
