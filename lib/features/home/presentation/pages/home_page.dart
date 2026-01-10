import 'dart:ui'; // Blur efekti için gerekli
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../agents/providers/user_agent_provider.dart';
import '../../../players/presentation/pages/players_page.dart';
import '../../../scouting/presentation/pages/scouting_page.dart';
import '../../../contracts/presentation/pages/contracts_page.dart';
import '../../../leagues/presentation/pages/leagues_page.dart';
import '../../../../core/providers/seeder_provider.dart';
import '../../../../core/providers/game_date_provider.dart';
import '../../../simulation/presentation/providers/simulation_provider.dart';
import '../../../leagues/presentation/providers/standings_provider.dart';
import '../../../leagues/presentation/providers/standings_provider.dart';
import '../../../../core/presentation/widgets/glass_container.dart';
import '../../../agents/presentation/pages/agents_page.dart';

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
    const AgentsPage(), // Index 4: World/Agents
  ];

  @override
  Widget build(BuildContext context) {
    final initialization = ref.watch(initializationProvider);

    return initialization.when(
      data: (_) => Scaffold(
        extendBody: true, // Arka planın navigasyon barın altına uzanmasını sağlar
        body: Stack(
          children: [
            // 1. Sayfa İçeriği
            _pages[_currentIndex],

            // 2. Alt Navigasyon ve Ticker (Buzlu Cam Tasarım)
            Positioned(
              left: 20,
              right: 20,
              bottom: 30, // Alttan biraz yukarıda, süzülüyor (Floating)
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Stats and Ticker only visible on Home Tab
                  if (_currentIndex == 0) ...[
                    // Stats Footer (Above Ticker)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: _ManagerStatsFooter(),
                    ),

                    // Ticker Widget
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: GlassContainer(
                        height: 30,
                        child: _TickerWidget(),
                      ),
                    ),
                  ],

                  // Ana Navigasyon Dock'u
                  _buildFloatingNavBar(context),
                ],
              ),
            ),
          ],
        ),
      ),
      loading: () => _buildLoadingScreen(),
      error: (err, stack) => Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: Center(
          child: Text('Error initializing game: $err', style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }

  Widget _buildFloatingNavBar(BuildContext context) {
    return GlassContainer(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Sol Buton (Kupa/Lig)
          _SimpIconButton(
            icon: Icons.emoji_events_outlined,
            color: Colors.amberAccent,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LeaguesPage()),
            ),
          ),

          // Orta Navigasyon İkonları
          // Orta Navigasyon İkonları
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _NavBarItem(
                    icon: Icons.home_rounded,
                    label: "Home",
                    isSelected: _currentIndex == 0,
                    onTap: () => setState(() => _currentIndex = 0),
                  ),
                  _NavBarItem(
                    icon: Icons.people_rounded,
                    label: "Club",
                    isSelected: _currentIndex == 1,
                    onTap: () => setState(() => _currentIndex = 1),
                  ),
                  _NavBarItem(
                    icon: Icons.travel_explore_rounded,
                    label: "Scout",
                    isSelected: _currentIndex == 2,
                    onTap: () => setState(() => _currentIndex = 2),
                  ),
                  _NavBarItem(
                    icon: Icons.description_rounded,
                    label: "Office",
                    isSelected: _currentIndex == 3,
                    onTap: () => setState(() => _currentIndex = 3),
                  ),
                  _NavBarItem(
                    icon: Icons.public,
                    label: "World",
                    isSelected: _currentIndex == 4,
                    onTap: () => setState(() => _currentIndex = 4),
                  ),
                ],
              ),
            ),
          ),

          // Sağ Buton (Ayarlar)
          _SimpIconButton(
            icon: Icons.settings_outlined,
            color: Colors.white70,
            onTap: () {
              // TODO: Settings
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.black.withOpacity(0.6)),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                SizedBox(height: 20),
                Text(
                  'INITIALIZING WORLD',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      letterSpacing: 4,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- HOME CONTENT (Yenilenmiş Header ile) ---
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

        // Gradient Overlay (Daha yumuşak geçiş)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.8), // Alt kısım nav bar için daha koyu
              ],
            ),
          ),
        ),

        // Şık Üst Panel (Header)
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                // Top Header Row
                    Row(
                      children: [
                        // Manager Profile
                        const Expanded(child: _ManagerProfileHeader()),

                        // World / Agents Button
                        /* REMOVED: World Icon - Moved to Bottom Nav
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AgentsPage())),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.purple.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.purpleAccent.withOpacity(0.5)),
                            ),
                            child: const Icon(Icons.public, color: Colors.white, size: 20),
                          ),
                        ),
                        const SizedBox(width: 15),
                        */

                        // Next Week Button
                        GestureDetector(
                          onTap: () async {
                            _handleSimulation(context, ref, currentWeek);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.2)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.1),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  "NEXT WEEK",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 14),
                                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 14),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSimulation(BuildContext context, WidgetRef ref, int currentWeek) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1),
      ),
    );

    try {
      final simulationService = ref.read(simulationServiceProvider);
      await simulationService.simulateWeek(1, currentWeek);
      await ref.read(gameDateProvider.notifier).advanceWeek();

      ref.invalidate(standingsProvider);
      ref.invalidate(tickerMatchesProvider);
      // Diğer invalidate işlemleri...

    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (context.mounted) Navigator.pop(context);
    }
  }
}

// --- YARDIMCI WIDGETLAR (Stil için) ---

class _ManagerProfileHeader extends ConsumerWidget {
  const _ManagerProfileHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAgentAsync = ref.watch(userAgentProvider);
    final userAgentNotifier = ref.read(userAgentProvider.notifier);
    final currentWeek = ref.watch(gameDateProvider);

    return userAgentAsync.when(
      data: (agent) {
         if (agent == null) return const SizedBox.shrink();
         
         final capacity = userAgentNotifier.capacity;
         
         return Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             // 1. Name & Level
             Row(
               children: [
                 Container(
                   padding: const EdgeInsets.all(8),
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     border: Border.all(color: Colors.amberAccent, width: 2),
                     color: Colors.black26,
                   ),
                   child: Text(
                     "${agent.level}",
                     style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                   ),
                 ),
                 const SizedBox(width: 12),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                      mainAxisSize: MainAxisSize.min,
                       children: [
                         Text(
                           agent.name.toUpperCase(),
                           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1),
                         ),
                         const SizedBox(width: 4),
                         GestureDetector(
                           onTap: () {
                             _showRenameDialog(context, userAgentNotifier, agent.name);
                           },
                           child: Icon(Icons.edit, color: Colors.white.withOpacity(0.5), size: 14),
                         ),
                       ],
                     ),
                     const SizedBox(height: 2),
                     Text(
                       "WEEK $currentWeek",
                        style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12, fontWeight: FontWeight.w500),
                     ),
                   ],
                 )
               ],
             ),
             
             const SizedBox(height: 12),

            ],
          );
       },
       loading: () => const Text("Loading...", style: TextStyle(color: Colors.white54)),
       error: (e, s) => const Text("Error", style: TextStyle(color: Colors.redAccent)),
     );
   }

  }

  void _showRenameDialog(BuildContext context, UserAgentNotifier notifier, String currentName) {
    final controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Rename Manager", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              TextField(
                controller: controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Enter Name",
                  hintStyle: TextStyle(color: Colors.white30),
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        notifier.updateName(controller.text);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    child: const Text("Variable", style: TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }



class _ManagerStatsFooter extends ConsumerWidget {
  const _ManagerStatsFooter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAgentAsync = ref.watch(userAgentProvider);
    final userAgentNotifier = ref.read(userAgentProvider.notifier);

    return userAgentAsync.when(
      data: (agent) {
        if (agent == null) return const SizedBox.shrink();
        final capacity = userAgentNotifier.capacity;

        return Container(
               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
               decoration: BoxDecoration(
                 color: Colors.black.withOpacity(0.4), // Darker background for contrast
                 borderRadius: BorderRadius.circular(20),
                 border: Border.all(color: Colors.white10),
               ),
               child: Row(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   _buildStatItem(Icons.attach_money, "\$${_formatMoney(agent.balance)}", Colors.greenAccent),
                   const SizedBox(width: 15),
                   Container(width: 1, height: 12, color: Colors.white24),
                   const SizedBox(width: 15),
                   _buildStatItem(Icons.star, "${agent.reputation}", Colors.amberAccent),
                   const SizedBox(width: 15),
                   Container(width: 1, height: 12, color: Colors.white24),
                    const SizedBox(width: 15),
                   _buildStatItem(Icons.group, "Cap: $capacity", Colors.blueAccent), 
                 ],
               ),
             );
      },
      loading: () => const SizedBox(),
      error: (_, __) => const SizedBox(),
    );
  }

  Widget _buildStatItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
      ],
    );
  }

   String _formatMoney(double amount) {
    if (amount >= 1000000) {
      return "${(amount / 1000000).toStringAsFixed(1)}M";
    } else if (amount >= 1000) {
      return "${(amount / 1000).toStringAsFixed(1)}K";
    }
    return amount.toStringAsFixed(0);
  }
}

// Navigasyon Elemanı
class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4), // Reduced from 10 to 4
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.black : Colors.white54,
                size: 22,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
              )
            ]
          ],
        ),
      ),
    );
  }
}

// Basit İkon Buton (Ligler ve Ayarlar için)
class _SimpIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SimpIconButton({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}

// --- TICKER WIDGET ---
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
      duration: const Duration(seconds: 60), // Biraz hızlandırdım
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

    return tickerAsync.when(
      data: (matches) {
        String displayText = matches.isEmpty
            ? "PRE-SEASON • PREPARE YOUR TEAM • TRANSFER WINDOW OPEN • "
            : matches.join("   •   ") + "   •   ";

        if (_text != displayText) _text = displayText;

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = constraints.maxWidth;
                final textWidth = _text.length * 8.0;
                final totalDistance = screenWidth + textWidth;
                final offset = screenWidth - (totalDistance * _controller.value);

                return Stack(
                  children: [
                    Positioned(
                      left: offset,
                      top: 7, // Dikey ortalama
                      child: Text(
                        _text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          letterSpacing: 1.2,
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
      loading: () => const Center(child: SizedBox(width: 10, height: 10, child: CircularProgressIndicator(strokeWidth: 1, color: Colors.white54))),
      error: (err, stack) => const SizedBox(),
    );
  }
}