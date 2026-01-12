import 'dart:math';

class PlayerValueCalculator {
  static int calculateMarketValue(double ca, int age, String position) {
    // Base Values for key CA milestones (approximate)
    // CA 60 -> 50k
    // CA 70 -> 500k
    // CA 80 -> 5M
    // CA 90 -> 30M
    // CA 100 -> 100M+

    double baseValue = 0;
    if (ca < 60) {
      baseValue = 10000.0 * pow(1.05, (ca - 40));
    } else if (ca < 70) {
      baseValue = 50000.0 * pow(1.25, (ca - 60));
    } else if (ca < 80) {
      baseValue = 500000.0 * pow(1.25, (ca - 70));
    } else if (ca < 90) {
      baseValue = 5000000.0 * pow(1.20, (ca - 80));
    } else {
      baseValue = 30000000.0 * pow(1.15, (ca - 90));
    }

    // Age Multiplier (Young players worth more)
    double ageMultiplier = 1.0;
    if (age <= 21) {
      ageMultiplier = 1.5;
    } else if (age <= 24) {
      ageMultiplier = 1.2;
    } else if (age >= 30) {
      ageMultiplier = 0.7;
    } else if (age >= 33) {
      ageMultiplier = 0.4;
    }

    // Position Multiplier (Attackers usually worth more)
    double posMultiplier = 1.0;
    // Simplified position check based on short string
    // Ideally use enum but string is robust enough here
    if (['ST', 'FWD', 'AML', 'AMR', 'AMC', 'LW', 'RW'].contains(position)) {
      posMultiplier = 1.2; // Forward/Attacker premium
    } else if (['GK'].contains(position)) {
      posMultiplier = 0.8; // GK discount
    }

    double finalValue = baseValue * ageMultiplier * posMultiplier;

    // Rounding logic for cleaner numbers
    if (finalValue < 1000000) {
      return (finalValue / 1000).round() * 1000;
    } else {
      return (finalValue / 10000).round() * 10000;
    }
  }
}
