import 'package:drift/drift.dart';
import '../../../../clubs/data/datasources/tables/clubs_table.dart';
import '../../../../players/data/datasources/tables/players_table.dart';
import 'transfer_needs_table.dart';

class TransferOffers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fromClubId => integer().references(Clubs, #id)();
  IntColumn get toClubId => integer().references(Clubs, #id)();
  IntColumn get playerId => integer().references(Players, #id)();
  IntColumn get needId => integer().references(TransferNeeds, #id)();
  
  IntColumn get offerAmount => integer()();
  IntColumn get proposedSalary => integer()();
  IntColumn get contractYears => integer()();
  
  IntColumn get season => integer().withDefault(const Constant(1))();
  IntColumn get createdAtWeek => integer()();
  TextColumn get status => text().withDefault(const Constant('pending'))(); // pending, accepted, rejected
}
