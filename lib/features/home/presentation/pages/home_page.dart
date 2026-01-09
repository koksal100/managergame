import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/game_button.dart';
import '../../../players/presentation/pages/players_page.dart';
import '../../../scouting/presentation/pages/scouting_page.dart';
import '../../../contracts/presentation/pages/contracts_page.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/seeder_provider.dart';

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
        bottomNavigationBar: Container(
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

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
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
                  // TODO: Implement Next Week Logic
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
