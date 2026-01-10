import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/game_button.dart';
import '../../../players/presentation/pages/players_page.dart';
import '../../../scouting/presentation/pages/scouting_page.dart';
import '../../../scouting/presentation/pages/scouting_page.dart';
import '../../../contracts/presentation/pages/contracts_page.dart';
import '../../../leagues/presentation/pages/leagues_page.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/seeder_provider.dart';
import '../../../../core/providers/game_date_provider.dart';
import '../../../simulation/presentation/providers/simulation_provider.dart';
import '../../../leagues/presentation/providers/standings_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const PlayersPage(),
    const ScoutingPage(),
    const ContractsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final initialization = ref.watch(initializationProvider);

    return initialization.when(
      data: (_) => Scaffold(
        extendBody: true,
        body: _pages[_currentIndex],
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Leads: Leagues / Trophy (Bottom Left)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const LeaguesPage()),
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white.withAlpha(70), width: 1),
                      ),
                      child: const Icon(Icons.emoji_events, color: Colors.amberAccent, size: 28),
                    ),
                  ),

                  // Trailing: Settings (Bottom Right)
                  GestureDetector(
                    onTap: () {
                       // TODO: Settings
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white.withAlpha(70), width: 1),
                      ),
                      child: const Icon(Icons.settings, color: Colors.white70, size: 28),
                    ),
                  ),
                ],
              ),
            ),
            const _TickerWidget(),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                child: NavigationBarTheme(
                  data: NavigationBarThemeData(
                    backgroundColor: Colors.transparent,
                    indicatorColor: Colors.blue.shade900.withOpacity(0.5),
                    labelTextStyle: WidgetStateProperty.all(
                      const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    iconTheme: WidgetStateProperty.resolveWith((states) {
                       if (states.contains(WidgetState.selected)) {
                         return const IconThemeData(color: Colors.white, size: 32);
                       }
                       return const IconThemeData(color: Colors.white54, size: 24);
                    }),
                  ),
                  child: NavigationBar(
                    selectedIndex: _currentIndex,
                    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                    height: 70,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    onDestinationSelected: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.people_outline),
                        selectedIcon: Icon(Icons.people),
                        label: 'Players',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.search_outlined),
                        selectedIcon: Icon(Icons.search),
                        label: 'Scouting',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.description_outlined),
                        selectedIcon: Icon(Icons.description),
                        label: 'Contracts',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      loading: () => Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
            Container(color: Colors.black54),
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.teal),
                  SizedBox(height: 20),
                  Text(
                    'Setting up Game World...',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      error: (err, stack) => Scaffold(
        body: Center(
          child: Text('Error initializing game: $err'),
        ),
      ),
    );
  }
}

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeek = ref.watch(gameDateProvider);

    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Image.asset(
          'assets/images/background.png',
          fit: BoxFit.cover,
        ),
        
        // Overlay Gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),

        // Calendar Widget (Top Left)
        Positioned(
          top: 60,
          left: 20,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3), // Dark transparent background
              borderRadius: BorderRadius.circular(5), // More rounded
              border: Border.all(
                color: Colors.white.withAlpha(70), // Subtle border
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Label
                Text(
                  'WEEK',
                  style: TextStyle(
                    color: Colors.blueGrey.shade100,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 4),
                // Number
                Text(
                  '$currentWeek',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                    shadows: [
                      Shadow(offset: Offset(-1, -1), color: Colors.black),
                      Shadow(offset: Offset(1, -1), color: Colors.black),
                      Shadow(offset: Offset(1, 1), color: Colors.black),
                      Shadow(offset: Offset(-1, 1), color: Colors.black),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Next Week Button (Top Right)
        Positioned(
          top: 60,
          right: 20,
          child: GestureDetector(
            onTap: () async {
              // Show loading dialog
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );

              try {
                // Simulate the CURRENT week's matches before moving to next
                // Assuming Season 1 for now
                final simulationService = ref.read(simulationServiceProvider); 
                await simulationService.simulateWeek(1, currentWeek);

                // Advance date
                await ref.read(gameDateProvider.notifier).advanceWeek();
                
                // Force refresh of Standings and Stats
                ref.invalidate(standingsProvider);
                ref.invalidate(topScorersProvider);
                ref.invalidate(topAssistersProvider);
                ref.invalidate(topRatedProvider);
                ref.invalidate(tickerMatchesProvider); // Update ticker
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Simulation Error: $e')),
                  );
                }
              } finally {
                // Close dialog
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3), // Match other buttons
                borderRadius: BorderRadius.circular(5), 
                border: Border.all(
                  color: Colors.white.withAlpha(70),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                '>>',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -2,
                ),
              ),
            ),
          ),
        ),
       ]
    );

  }
}


class _TickerWidget extends ConsumerStatefulWidget {
  const _TickerWidget();

  @override
  ConsumerState<_TickerWidget> createState() => _TickerWidgetState();
}

class _TickerWidgetState extends ConsumerState<_TickerWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _text = "";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 70),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tickerAsync = ref.watch(tickerMatchesProvider);

    return Container(
      width: double.infinity,
      height: 26,
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.white, width: 1.0),
        ),
      ),
      child: ClipRect(
        child: tickerAsync.when(
          data: (matches) {
            String displayText = matches.isEmpty 
               ? "NO MATCHES PLAYED • PREPARE FOR NEXT WEEK • " 
               : matches.join("   •   ") + "   •   ";

             // Update text if changed
             if (_text != displayText) {
               _text = displayText;
             }
             
             return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final screenWidth = constraints.maxWidth;
                      
                      // Approx width calculation
                      final textWidth = _text.length * 9.5; 
                      
                      // Proper scrolling logic: Text moves LEFT.
                      // Offset starts at screenWidth and goes to -textWidth
                      
                      // NOTE: Original code logic:
                      // offset = screenWidth - (screenWidth + textWidth) * value
                      // At 0: offset = screenWidth (Right edge)
                      // At 1: offset = screenWidth - screenWidth - textWidth = -textWidth (Left edge offscreen)
                      // This ensures text fully passes through.
                      
                      final totalDistance = screenWidth + textWidth;
                      final offset = screenWidth - (totalDistance * _controller.value);
                      
                      return Stack(
                        children: [
                          Positioned(
                            left: offset,
                            top: 4,
                            child: Text(
                              _text,
                              style: const TextStyle(
                                color: Color(0xFF89CFF0), // Baby Blue
                                fontFamily: 'Courier', 
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
             );
          },
          loading: () => const Center(child: Text("LOADING RESULTS...", style: TextStyle(color: Colors.white54, fontSize: 10))),
          error: (err, stack) => const SizedBox(),
        ),
      ),
    );
  }
}
