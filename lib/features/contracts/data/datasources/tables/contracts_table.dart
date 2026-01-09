import 'package:drift/drift.dart';
// Will import Players and Agents likely via lazy reference or assume they are in the same db scope.
// However, direct file import is good for type safety if classes are public.
// But circular imports: Players -> Contracts -> Players ??
// Players has currentContractId referencing Contracts.
// Contracts has playerId referencing Players.
// This is a circular dependency in Dart files if I import them.
// Drift doesn't strictly require the class import for the `references` if using the symbol #id IF they are in the same file.
// But they are in separate files.
// To avoid circular import in Dart, we might need to be careful.
// Let's import. Dart handles circular imports well usually, unless it's const constructors or mixins sometimes.
// But for `references(Players, #id)` `Players` class must be visible.

import '../../../../players/data/datasources/tables/players_table.dart';
import '../../../../agents/data/datasources/tables/agents_table.dart';

class Contracts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playerId => integer().references(Players, #id)();
  IntColumn get agentId => integer().nullable().references(Agents, #id)();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  RealColumn get wage => real()();
  RealColumn get releaseClause => real()();
  TextColumn get status => text()(); // Active, Pending vs.
}
