import 'dart:math';

class PlayerValueCalculator {
  static int calculateMarketValue(
    double ca,
    int age,
    String position, {
    int? pa,
  }) {
    // Recalibrated CA curve:
    // - Raises 58-68 CA band so young talents are not undervalued.
    // - Keeps high-end growth exponential.
    final caClamped = ca.clamp(40.0, 99.0);
    double baseValue;
    if (caClamped < 60) {
      baseValue = 18000.0 * pow(1.10, (caClamped - 40));
    } else if (caClamped < 70) {
      baseValue = 220000.0 * pow(1.18, (caClamped - 60));
    } else if (caClamped < 80) {
      baseValue = 1150000.0 * pow(1.22, (caClamped - 70));
    } else if (caClamped < 90) {
      baseValue = 8500000.0 * pow(1.18, (caClamped - 80));
    } else {
      baseValue = 42000000.0 * pow(1.14, (caClamped - 90));
    }

    // Age impact: sharper premium for teenagers, controlled decay for veterans.
    double ageMultiplier = 1.0;
    if (age <= 17) {
      ageMultiplier = 1.75;
    } else if (age <= 21) {
      ageMultiplier = 1.45;
    } else if (age <= 24) {
      ageMultiplier = 1.2;
    } else if (age >= 33) {
      ageMultiplier = 0.42;
    } else if (age >= 30) {
      ageMultiplier = 0.68;
    }

    // Potential premium: only meaningful for younger players.
    double potentialMultiplier = 1.0;
    if (pa != null && pa > caClamped && age <= 24) {
      final gap = (pa - caClamped).clamp(0.0, 25.0);
      final ageWeight = age <= 17
          ? 1.0
          : age <= 21
          ? 0.75
          : 0.45;
      potentialMultiplier = 1.0 + ((gap / 20.0) * 1.6 * ageWeight);
    }

    // Position adjustments.
    double posMultiplier = 1.0;
    if (['ST', 'FWD', 'AML', 'AMR', 'AMC', 'LW', 'RW'].contains(position)) {
      posMultiplier = 1.18;
    } else if (['GK'].contains(position)) {
      posMultiplier = 0.84;
    } else if (['DC', 'DL', 'DR', 'CB', 'LB', 'RB', 'DEF'].contains(position)) {
      posMultiplier = 1.05;
    }

    final finalValue =
        baseValue * ageMultiplier * potentialMultiplier * posMultiplier;

    if (finalValue < 1000000) {
      return (finalValue / 1000).round() * 1000;
    }
    if (finalValue < 10000000) {
      return (finalValue / 10000).round() * 10000;
    }
    return (finalValue / 50000).round() * 50000;
  }
}
