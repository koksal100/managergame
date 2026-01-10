import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/simulation_service.dart';
import '../../../../core/providers/repository_providers.dart';

final simulationServiceProvider = Provider<SimulationService>((ref) {
  return SimulationService(
    matchRepository: ref.watch(matchRepositoryProvider),
    performanceRepository: ref.watch(performanceRepositoryProvider),
    clubRepository: ref.watch(clubRepositoryProvider),
    playerRepository: ref.watch(playerRepositoryProvider),
  );
});
