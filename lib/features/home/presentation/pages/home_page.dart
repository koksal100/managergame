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

        // Trophy / Leagues Button
        Positioned(
          top: 60,
          right: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const LeaguesPage()),
              );
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3), // Matching Calendar BG
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
              child: const Icon(
                Icons.emoji_events, 
                color: Colors.amberAccent, 
                size: 40,
                shadows: [
                  Shadow(
                    color: Colors.orangeAccent,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  )
                ],
              ),
            ),
          ),
        ),

        // Main Content
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              // Next Week Button
              GameButton(
                text: 'NEXT WEEK',
                onPressed: () {
                   ref.read(gameDateProvider.notifier).advanceWeek();
                },
              ),

              const SizedBox(height: 20),

              // Settings Button
              GameButton(
                text: 'SETTINGS',
                onPressed: () {
                  // TODO: Navigate to Settings
                },
              ),

              const Spacer(),
              
              // Version or Branding
              const Text(
                'Manager Game v1.0',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}


class _TickerWidget extends StatefulWidget {
  const _TickerWidget();

  @override
  State<_TickerWidget> createState() => _TickerWidgetState();
}

class _TickerWidgetState extends State<_TickerWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // Added more dummy Super Lig matches
  final String _text = "GALATASARAY 3-0 FENERBAHÇE   •   BEŞİKTAŞ 2-1 TRABZONSPOR   •   BAŞAKŞEHİR 1-0 KASIMPAŞA   •   ADANA DEMİR 2-2 SİVASSPOR   •   GÖZTEPE 3-2 RİZESPOR   •   ANTALYASPOR 0-1 ALANYASPOR";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20), // Slower duration for longer text
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 26, // Increased slightly for border
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.white, width: 1.0),
        ),
      ),
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = constraints.maxWidth;
                // Calculate estimated text width (Char count * approx width per char)
                // Courier 14px is approx 9-10px wide per char.
                final textWidth = _text.length * 10.0; 
                
                // Scroll from [Screen Right] to [Pass Full Text]
                final offset = screenWidth - (screenWidth + textWidth) * _controller.value;
                
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
                          fontSize: 14,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
