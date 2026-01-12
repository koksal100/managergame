
import 'package:drift/drift.dart';

import '../../../domain/entities/office_staff.dart';

class AgentStaffs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get agentId => integer()();
  IntColumn get staffType => intEnum<StaffType>()();
  IntColumn get level => integer()();
  IntColumn get count => integer().withDefault(const Constant(0))();

  @override
  List<String> get customConstraints => [
    'UNIQUE(agent_id, staff_type, level)' // Prevent duplicate rows for same type/level
  ];
}
