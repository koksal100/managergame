import 'package:drift/drift.dart';
import '../../../../clubs/data/datasources/tables/clubs_table.dart';
import '../../../../agents/data/datasources/tables/agents_table.dart';

class Players extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get age => integer()();
  // Foreign Key definitions:
  IntColumn get clubId => integer().nullable().references(Clubs, #id)();
  IntColumn get agentId => integer().nullable().references(Agents, #id)();
  TextColumn get position => text()();
  IntColumn get ca => integer()(); // Current Ability
  IntColumn get pa => integer()(); // Potential Ability
  IntColumn get reputation => integer()();
  IntColumn get marketValue => integer()();
  // Using nullable references for circular dependencies might be needed, 
  // but drift handles simple references.
}
