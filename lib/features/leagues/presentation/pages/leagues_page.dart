import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widgets/game_button.dart';
import '../../providers/league_provider.dart';
import 'league_detail_page.dart';

class LeaguesPage extends ConsumerWidget {
  const LeaguesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaguesAsync = ref.watch(leaguesProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Competitions', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
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
          leaguesAsync.when(
            data: (leagues) {
               if (leagues.isEmpty) {
                 return const Center(child: Text('No leagues found', style: TextStyle(color: Colors.white)));
               }
               return ListView.builder(
                 padding: const EdgeInsets.fromLTRB(16, 100, 16, 20),
                 itemCount: leagues.length,
                 itemBuilder: (context, index) {
                   final league = leagues[index];
                   return GestureDetector(
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => LeagueDetailPage(league: league),
                         ),
                       );
                     },
                     child: Container(
                       margin: const EdgeInsets.only(bottom: 12),
                       padding: const EdgeInsets.all(16),
                       decoration: BoxDecoration(
                         color: Colors.white.withOpacity(0.05),
                         borderRadius: BorderRadius.circular(16),
                         border: Border.all(color: Colors.white.withOpacity(0.1)),
                       ),
                       child: Row(
                         children: [
                           // League Icon / Color
                           Container(
                             width: 50,
                             height: 50,
                             decoration: BoxDecoration(
                               color: _getLeagueColor(league.countryId),
                               borderRadius: BorderRadius.circular(12),
                               boxShadow: [
                                 BoxShadow(
                                   color: _getLeagueColor(league.countryId).withOpacity(0.4),
                                   blurRadius: 10,
                                   offset: const Offset(0, 4),
                                 )
                               ]
                             ),
                             child: const Icon(Icons.emoji_events, color: Colors.white, size: 28),
                           ),
                           const SizedBox(width: 16),
                           // Name
                           Expanded(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                   league.name,
                                   style: const TextStyle(
                                     color: Colors.white,
                                     fontSize: 18,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                                 Text(
                                   'Reputation: ${league.reputation}',
                                   style: TextStyle(
                                     color: Colors.white.withOpacity(0.5),
                                     fontSize: 12,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           const Icon(Icons.chevron_right, color: Colors.white54),
                         ],
                       ),
                     ),
                   );
                 },
               );
            },
            loading: () => const Center(child: CircularProgressIndicator(color: Colors.teal)),
            error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.redAccent))),
          ),
        ],
      ),
    );
  }

  Color _getLeagueColor(int countryId) {
    // Determine color based on ID seed or map
    // Simple hashing for MVP
    final List<Color> colors = [
      Colors.redAccent,
      Colors.blueAccent,
      Colors.greenAccent,
      Colors.orangeAccent,
      Colors.purpleAccent,
      Colors.tealAccent,
      Colors.amberAccent,
    ];
    return colors[countryId % colors.length];
  }
}
