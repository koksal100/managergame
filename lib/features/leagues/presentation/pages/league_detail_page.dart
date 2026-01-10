import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../clubs/domain/entities/club.dart';
// import '../../../clubs/providers/club_provider.dart'; // Unused now
import '../../../clubs/presentation/pages/club_squad_page.dart';
import '../../domain/entities/league.dart';
import '../widgets/league_colors.dart';
import '../providers/standings_provider.dart';
import '../providers/fixture_provider.dart';
import '../../domain/services/standings_service.dart';
import '../../../performances/domain/entities/player_stat.dart';
import '../../../../core/providers/game_date_provider.dart';

class LeagueDetailPage extends ConsumerStatefulWidget {
  final League league;

  const LeagueDetailPage({super.key, required this.league});

  @override
  ConsumerState<LeagueDetailPage> createState() => _LeagueDetailPageState();
}

class _LeagueDetailPageState extends ConsumerState<LeagueDetailPage> {
  late int _selectedWeek;

  @override
  void initState() {
    super.initState();
    // Initialize with current week, but handle if week 0 (not started?)
    final currentWeek = ref.read(gameDateProvider);
    _selectedWeek = currentWeek > 0 ? currentWeek : 1; 
  }

  void _changeWeek(int delta) {
    setState(() {
      _selectedWeek = (_selectedWeek + delta).clamp(1, 38); // Assuming 38 weeks max for now
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(widget.league.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(text: 'Table'),
              Tab(text: 'Matches'),
              Tab(text: 'Goals'),
              Tab(text: 'Assists'),
              Tab(text: 'Rating'),
            ],
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
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight + 100), // Adjust for AppBar + TabBar
              child: TabBarView(
                children: [
                   _buildStandingsTab(ref),
                   _buildFixtureTab(ref),
                   _buildStatsTab(ref, topScorersProvider(widget.league.id), 'Goals'),
                   _buildStatsTab(ref, topAssistersProvider(widget.league.id), 'Assists'),
                   _buildStatsTab(ref, topRatedProvider(widget.league.id), 'Rating', isRating: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFixtureTab(WidgetRef ref) {
    // Watch matches for selected week
    final fixtureAsync = ref.watch(fixtureProvider(FixtureParams(leagueId: widget.league.id, week: _selectedWeek)));

    return Column(
      children: [
        // Week Navigation Header
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
           decoration: BoxDecoration(
             color: Colors.white.withOpacity(0.1),
             borderRadius: BorderRadius.circular(20),
             border: Border.all(color: Colors.white12),
           ),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               IconButton(
                 onPressed: _selectedWeek > 1 ? () => _changeWeek(-1) : null,
                 icon: Icon(Icons.arrow_back_ios, size: 16, color: _selectedWeek > 1 ? Colors.white : Colors.white24),
               ),
               Text(
                 'Week $_selectedWeek',
                 style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
               ),
               IconButton(
                 onPressed: _selectedWeek < 38 ? () => _changeWeek(1) : null,
                 icon: Icon(Icons.arrow_forward_ios, size: 16, color: _selectedWeek < 38 ? Colors.white : Colors.white24),
               ),
             ],
           ),
        ),

        // Matches List
        Expanded(
          child: fixtureAsync.when(
            data: (fixtures) {
              if (fixtures.isEmpty) {
                 return const Center(child: Text('No matches scheduled', style: TextStyle(color: Colors.white54)));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: fixtures.length,
                itemBuilder: (context, index) {
                  final item = fixtures[index];
                  final match = item.match;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Home
                        Expanded(child: Text(item.homeClubName, textAlign: TextAlign.end, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                        
                        // Score or VS
                        Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: match.isPlayed 
                            ? Text('${match.homeScore} - ${match.awayScore}', style: const TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold, fontSize: 16))
                            : const Text('vs', style: TextStyle(color: Colors.white38, fontSize: 12)),
                        ),

                        // Away
                        Expanded(child: Text(item.awayClubName, textAlign: TextAlign.start, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                      ],
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator(color: Colors.teal)),
            error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
          ),
        ),
      ],
    );
  }

  Widget _buildStandingsTab(WidgetRef ref) {
    final standingsAsync = ref.watch(standingsProvider(widget.league.id));

    return standingsAsync.when(
      data: (standings) {
        if (standings.isEmpty) {
          return const Center(child: Text('No clubs found', style: TextStyle(color: Colors.white)));
        }
        return  SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              _buildTableHeader(),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: standings.length,
                itemBuilder: (context, index) {
                  final standing = standings[index];
                  return _buildTableRow(context, index + 1, standing);
                },
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator(color: Colors.teal)),
      error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.redAccent))),
    );
  }

  Widget _buildStatsTab(WidgetRef ref, ProviderListenable<AsyncValue<List<PlayerStat>>> provider, String metricLabel, {bool isRating = false}) {
     final statsAsync = ref.watch(provider);

     return statsAsync.when(
       data: (stats) {
         if (stats.isEmpty) {
           return const Center(child: Text('No stats available', style: TextStyle(color: Colors.white)));
         }
         return SingleChildScrollView(
           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
           child: Column(
             children: [
               // Header
               Container(
                 padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                 decoration: BoxDecoration(
                   gradient: LeagueColors.getGradient(widget.league.name),
                   borderRadius: BorderRadius.circular(8),
                   boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 4, offset: const Offset(0, 2))
                   ]
                 ),
                 child: Row(
                   children: [
                     SizedBox(width: 30, child: Text('#', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                     Expanded(child: Text('Player', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                     Expanded(child: Text('Club', style: const TextStyle(color: Colors.white70))),
                     SizedBox(width: 60, child: Text(metricLabel, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                   ],
                 ),
               ),
               // List
               ListView.builder(
                 padding: EdgeInsets.zero,
                 shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(),
                 itemCount: stats.length,
                 itemBuilder: (context, index) {
                   final stat = stats[index];
                   return Container(
                     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                     decoration: BoxDecoration(
                       border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
                       color: index % 2 == 0 ? Colors.white.withOpacity(0.02) : Colors.transparent,
                     ),
                     child: Row(
                       children: [
                          SizedBox(width: 30, child: Text('${index + 1}', style: const TextStyle(color: Colors.white54))),
                          Expanded(child: Text(stat.playerName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                          Expanded(child: Text(stat.clubName, style: const TextStyle(color: Colors.white60, fontSize: 13))),
                          SizedBox(
                            width: 60, 
                            child: Text(
                              isRating ? stat.averageRating.toStringAsFixed(2) : (metricLabel == 'Goals' ? stat.goals.toString() : stat.assists.toString()), 
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold),
                            ),
                          ),
                       ],
                     ),
                   );
                 },
               ),
             ],
           ),
         );
       },
       loading: () => const Center(child: CircularProgressIndicator(color: Colors.teal)),
       error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.redAccent))),
     );
  }

  Widget _buildTableHeader() {
    const shadow = [
      Shadow(offset: Offset(-1, -1), color: Colors.black),
      Shadow(offset: Offset(1, -1), color: Colors.black),
      Shadow(offset: Offset(1, 1), color: Colors.black),
      Shadow(offset: Offset(-1, 1), color: Colors.black),
      Shadow(blurRadius: 2, color: Colors.black, offset: Offset(0, 1))
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        gradient: LeagueColors.getGradient(widget.league.name),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 3)
          )
        ]
      ),
      child: Row(
        children: [
          _buildCell('Pos', width: 30, bold: true, hasShadow: true),
          Expanded(child: Text('Team', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, shadows: shadow))),
          _buildCell('P', width: 25, bold: true, hasShadow: true),
          _buildCell('W', width: 25, bold: true, hasShadow: true),
          _buildCell('D', width: 25, bold: true, hasShadow: true),
          _buildCell('L', width: 25, bold: true, hasShadow: true),
          _buildCell('GF', width: 25, bold: true, hasShadow: true),
          _buildCell('GA', width: 25, bold: true, hasShadow: true),
          _buildCell('GD', width: 25, bold: true, hasShadow: true),
          _buildCell('Pts', width: 30, bold: true, hasShadow: true),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, int pos, LeagueStanding standing) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClubSquadPage(clubId: standing.club.id, clubName: standing.club.name),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
          color: pos % 2 == 0 ? Colors.white.withOpacity(0.02) : Colors.transparent, // Zebra striping
        ),
        child: Row(
          children: [
            _buildCell('$pos', width: 30),
            Expanded(child: Text(standing.club.name, style: const TextStyle(color: Colors.white, fontSize: 13))),
            _buildCell('${standing.played}', width: 25),
            _buildCell('${standing.won}', width: 25),
            _buildCell('${standing.drawn}', width: 25),
            _buildCell('${standing.lost}', width: 25),
            _buildCell('${standing.goalsFor}', width: 25),
            _buildCell('${standing.goalsAgainst}', width: 25),
            _buildCell('${standing.goalDifference}', width: 25),
            _buildCell('${standing.points}', width: 30, bold: true, color: Colors.yellowAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String text, {double? width, bool bold = false, Color? color, bool hasShadow = false}) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color ?? (bold ? Colors.white : Colors.white54), // Header text usually white if shadow present
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
          shadows: hasShadow ? [
            const Shadow(offset: Offset(-1, -1), color: Colors.black),
            const Shadow(offset: Offset(1, -1), color: Colors.black),
            const Shadow(offset: Offset(1, 1), color: Colors.black),
            const Shadow(offset: Offset(-1, 1), color: Colors.black),
            const Shadow(blurRadius: 2, color: Colors.black, offset: Offset(0, 1))
          ] : null,
        ),
      ),
    );
  }
}
