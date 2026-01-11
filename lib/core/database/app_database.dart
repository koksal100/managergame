import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
// Import tables
import '../../features/players/data/datasources/tables/players_table.dart';
import '../../features/clubs/data/datasources/tables/clubs_table.dart';
import '../../features/agents/data/datasources/tables/agents_table.dart';
import '../../features/leagues/data/datasources/tables/leagues_table.dart';
import '../../features/contracts/data/datasources/tables/agent_contracts_table.dart';
import '../../features/contracts/data/datasources/tables/club_contracts_table.dart';
import '../../features/transfers/data/datasources/tables/transfers_table.dart';
import '../../features/transfers/data/datasources/tables/transfer_needs_table.dart';
import '../../features/transfers/data/datasources/tables/transfer_offers_table.dart';
import '../../features/players/data/datasources/tables/value_histories_table.dart';
import '../../features/relationships/data/datasources/tables/relationships_table.dart';
import '../../features/countries/data/datasources/tables/countries_table.dart';
import '../../features/home/domain/entities/home_entity.dart';

import '../../features/matches/data/datasources/tables/matches_table.dart';
import '../../features/performances/data/datasources/tables/performances_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Players,
  Clubs,
  Agents,
  Leagues,
  AgentContracts,
  ClubContracts,
  Transfers,
  TransferNeeds,
  TransferOffers,
  ValueHistories,
  Relationships,
  Countries,
  Matches,
  Performances,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
