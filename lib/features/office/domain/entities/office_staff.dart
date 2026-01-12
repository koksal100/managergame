
enum StaffType {
  scout,
  journalist,
  physio;

  String get label {
    switch (this) {
      case StaffType.scout: return 'Scout';
      case StaffType.journalist: return 'Journalist';
      case StaffType.physio: return 'Physiotherapist';
    }
  }
}

class OfficeStaff {
  final int id;
  final int agentId;
  final StaffType type;
  final int level;
  final int count;

  const OfficeStaff({
    required this.id,
    required this.agentId,
    required this.type,
    required this.level,
    required this.count,
  });

  // Base cost per staff per week based on level
  int get weeklyCost {
    // Example: Level 1 = 500, Level 5 = 5000?
    // User wanted weekly cost.
    // Let's maximize simplicity for now: Level * 1000?
    // Level 1: 1000, Level 5: 5000.
    return level * 1000; // Per staff
  }
  
  int get totalWeeklyCost => weeklyCost * count;
}
