import 'package:drift/drift.dart';
import '../../../../clubs/data/datasources/tables/clubs_table.dart';

class Matches extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get homeClubId => integer().references(Clubs, #id)();
  IntColumn get awayClubId => integer().references(Clubs, #id)();
  IntColumn get homeScore => integer().nullable()();
  IntColumn get awayScore => integer().nullable()();
  IntColumn get season => integer()();
  IntColumn get week => integer()();
  BoolColumn get isPlayed => boolean().withDefault(const Constant(false))();
}
