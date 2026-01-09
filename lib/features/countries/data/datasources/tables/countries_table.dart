import 'package:drift/drift.dart';

class Countries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get code => text()(); // ISO Code e.g. TR, EN
  IntColumn get reputation => integer()(); // For random generation weights
}
