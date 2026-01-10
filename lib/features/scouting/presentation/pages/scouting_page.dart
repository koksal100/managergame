import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widgets/game_button.dart'; // Adjust path if needed
import '../../../players/domain/entities/player.dart';
import '../../../players/domain/entities/player_filter.dart';
import '../../../players/presentation/providers/player_provider.dart';
import '../../../players/presentation/widgets/player_detail_dialog.dart';
import '../../../players/presentation/widgets/player_filter_modal.dart';

class ScoutingPage extends ConsumerWidget {
  const ScoutingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsyncValue = ref.watch(filteredPlayersProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/scout_background.png',
            fit: BoxFit.cover,
          ),
          
          // Overlay Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),

          // Content
          Column(
            children: [
              const SizedBox(height: 50), // Spacing for AppBar

              // Search Bar & Filter
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          // Update only name part of filter
                          final currentFilter = ref.read(playerFilterProvider);
                          ref.read(playerFilterProvider.notifier).state = currentFilter.copyWith(nameQuery: value);
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search Player Name...',
                          hintStyle: const TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          prefixIcon: const Icon(Icons.search, color: Colors.white54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Filter Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.teal.withOpacity(0.5)),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.filter_list, color: Colors.tealAccent),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const PlayerFilterModal(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Sorting Headers Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Row(
                  children: [
                    _buildSortHeader(ref, 'Name', PlayerSortType.name),
                    const SizedBox(width: 8),
                    _buildSortHeader(ref, 'Age', PlayerSortType.age, flex: 0, width: 40),
                    const SizedBox(width: 8),
                    _buildSortHeader(ref, 'CA', PlayerSortType.ca, flex: 0, width: 40),
                    const SizedBox(width: 8),
                    _buildSortHeader(ref, 'PA', PlayerSortType.pa, flex: 0, width: 40),
                    const SizedBox(width: 8),
                    _buildSortHeader(ref, 'Value', PlayerSortType.marketValue, flex: 0, width: 60), // Added Value Sort
                    const SizedBox(width: 32), // Space for arrow icon
                  ],
                ),
              ),

              // Player List
              Expanded(
                child: playersAsyncValue.when(
                  data: (players) {
                    if (players.isEmpty) {
                      return const Center(
                        child: Text(
                          'No players found.',
                          style: TextStyle(color: Colors.white54),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      itemCount: players.length,
                      itemBuilder: (context, index) {
                        final player = players[index];
                        return _buildPlayerCard(context, player);
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator(color: Colors.teal)),
                  error: (err, stack) => Center(
                    child: Text('Error: $err', style: const TextStyle(color: Colors.redAccent)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerCard(BuildContext context, Player player) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => PlayerDetailDialog(player: player),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            // Player Icon / Avatar
            CircleAvatar(
              backgroundColor: Colors.blueGrey.shade900,
              child: Text(
                player.position, 
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            
            // Player Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Age: ${player.age} • CA: ${player.ca} • Val: ${_formatCurrency(player.marketValue)}',
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),

            // Action / Status
            const Icon(Icons.chevron_right, color: Colors.white54),
          ],
        ),
      ),
    );
  }

  Widget _buildSortHeader(WidgetRef ref, String text, PlayerSortType type, {int flex = 1, double? width}) {
    final currentFilter = ref.watch(playerFilterProvider);
    final isSelected = currentFilter.sortType == type;
    final isAscending = currentFilter.ascending;
    
    Widget content = Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center text in fixed width containers
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.tealAccent : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12
          ),
        ),
        if (isSelected)
          Icon(
            isAscending ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            color: Colors.tealAccent,
            size: 16,
          )
      ],
    );

    // Apply GestureDetector First
    Widget clickableContent = GestureDetector(
      onTap: () {
        PlayerSortType nextSortType = type;
        bool nextAscending = false; // Default to Descending (High to Low)

        if (isSelected) {
          if (!isAscending) {
            // State 1 (Desc) -> State 2 (Asc)
            nextAscending = true;
          } else {
            // State 2 (Asc) -> State 3 (Reset / Default)
            // Reset to CA Descending default
            nextSortType = PlayerSortType.ca;
            nextAscending = false;
          }
        } else {
          // New Column -> State 1 (Desc)
          nextAscending = false;
        }

        ref.read(playerFilterProvider.notifier).state = currentFilter.copyWith(
          sortType: nextSortType,
          ascending: nextAscending,
        );
      },
      child: content,
    );
    
    // Apply Size Constraints Last
    if (flex > 0) {
      return Expanded(flex: flex, child: clickableContent);
    } else if (width != null) {
      return SizedBox(width: width, child: clickableContent);
    }

    return clickableContent;
  }

  String _formatCurrency(int value) {
    if (value >= 1000000) {
      double millions = value / 1000000;
      return '€${millions.toStringAsFixed(millions.truncateToDouble() == millions ? 0 : 1)}M';
    } else if (value >= 1000) {
      return '€${(value / 1000).toStringAsFixed(0)}K';
    } else {
      return '€$value';
    }
  }
}
