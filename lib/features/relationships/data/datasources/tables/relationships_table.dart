import 'package:drift/drift.dart';

class Relationships extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fromId => integer()(); // Polymorphic FK
  IntColumn get toId => integer()();
  TextColumn get fromType => text()(); // 'Agent', 'Player'
  TextColumn get toType => text()();   // 'Club', 'Manager'
  IntColumn get score => integer()();
}
