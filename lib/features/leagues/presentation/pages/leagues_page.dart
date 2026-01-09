import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/presentation/widgets/game_button.dart';
import '../../providers/league_provider.dart';
import '../widgets/league_colors.dart';
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
        title: const Text('Competitions', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.center),
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
                             width: 60,
                             height: 60,
                             decoration: BoxDecoration(
                               gradient: LeagueColors.getGradient(league.name),
                               borderRadius: BorderRadius.circular(15),
                               boxShadow: [
                                 BoxShadow(
                                   color: Colors.black.withOpacity(0.3),
                                   blurRadius: 8,
                                   offset: const Offset(0, 4),
                                 )
                               ],
                               border: Border.all(color: Colors.white24, width: 1),
                             ),
                             child: const Icon(Icons.emoji_events, color: Color(
                                 0x80000000), size: 50),
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

  // Removed local _getLeagueGradient
}
