
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/player_history.dart';
import '../../../players/presentation/providers/player_provider.dart';

// Provider to fetch value history
final playerValueHistoryProvider = FutureProvider.family<List<PlayerValueHistory>, int>((ref, playerId) async {
  final repository = ref.read(playerRepositoryProvider);
  final result = await repository.getValueHistory(playerId);
  return result.fold((l) => [], (r) => r);
});

// Provider to fetch CA history
final playerCaHistoryProvider = FutureProvider.family<List<PlayerCaHistory>, int>((ref, playerId) async {
  final repository = ref.read(playerRepositoryProvider);
  final result = await repository.getCaHistory(playerId);
  return result.fold((l) => [], (r) => r);
});

class PlayerHistoryTab extends ConsumerWidget {
  final Player player;

  const PlayerHistoryTab({super.key, required this.player});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final caHistory = ref.watch(playerCaHistoryProvider(player.id));
    final valueHistory = ref.watch(playerValueHistoryProvider(player.id));

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Development Progress (CA)'),
          const SizedBox(height: 8),
          SizedBox(
            height: 140,
            child: caHistory.when(
              data: (data) => _buildCaChart(data),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.white))),
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Market Value History'),
          const SizedBox(height: 8),
          SizedBox(
            height: 140,
            child: valueHistory.when(
              data: (data) => _buildValueChart(data),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
        color: Colors.tealAccent,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildCaChart(List<PlayerCaHistory> history) {
    if (history.isEmpty) return const Center(child: Text("No data yet.", style: TextStyle(color: Colors.white54)));

    // Create spots
    // X axis: sequential index (could be time, but simple index is robust)
    // Or better: (season * 52 + week)
    
    // Sort just in case
    // history.sort((a, b) => (a.season * 52 + a.week).compareTo(b.season * 52 + b.week));

    final spots = history.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.ca);
    }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (value) => FlLine(color: Colors.white10, strokeWidth: 1)),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: max(1, (history.length / 5).toDouble()), // Show ~5 labels
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < history.length) {
                  final h = history[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "S${h.season}W${h.week}",
                      style: const TextStyle(color: Colors.white54, fontSize: 10),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 5, // CA interval
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString(), style: const TextStyle(color: Colors.white54, fontSize: 10));
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (history.length - 1).toDouble(),
        minY: (history.map((e) => e.ca).reduce(min) - 5).clamp(0, 200),
        maxY: (history.map((e) => e.ca).reduce(max) + 5).clamp(0, 200),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.tealAccent,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.tealAccent.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueChart(List<PlayerValueHistory> history) {
    if (history.isEmpty) return const Center(child: Text("No history data.", style: TextStyle(color: Colors.white54)));

    final spots = history.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.value);
    }).toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (value) => FlLine(color: Colors.white10, strokeWidth: 1)),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: max(1, (history.length / 5).toDouble()), 
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < history.length) {
                  final h = history[index];
                   return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "S${h.season}W${h.week}",
                      style: const TextStyle(color: Colors.white54, fontSize: 10),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
           leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50, // More space for Value
              getTitlesWidget: (value, meta) {
                if (value == 0) return const Text('0', style: TextStyle(color: Colors.white54, fontSize: 10));
                // Simplify large numbers
                if (value >= 1000000) {
                     return Text('${(value/1000000).toStringAsFixed(1)}M', style: const TextStyle(color: Colors.white54, fontSize: 10));
                }
                 return Text('${(value/1000).toStringAsFixed(0)}K', style: const TextStyle(color: Colors.white54, fontSize: 10));
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (history.length - 1).toDouble(),
         // Auto-scale Y
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.orangeAccent,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
             belowBarData: BarAreaData(
              show: true,
              color: Colors.orangeAccent.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}

// Helpers for min/max
double min(double a, double b) => a < b ? a : b;
double max(double a, double b) => a > b ? a : b;
