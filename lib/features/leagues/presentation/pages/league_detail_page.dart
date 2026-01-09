import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../clubs/domain/entities/club.dart';
import '../../../clubs/providers/club_provider.dart';
import '../../../clubs/presentation/pages/club_squad_page.dart';
import '../../domain/entities/league.dart';
import '../widgets/league_colors.dart';

class LeagueDetailPage extends ConsumerWidget {
  final League league;

  const LeagueDetailPage({super.key, required this.league});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubsAsync = ref.watch(clubsByLeagueProvider(league.id));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(league.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
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
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),

          // Content
          clubsAsync.when(
            data: (clubs) {
              if (clubs.isEmpty) {
                return const Center(child: Text('No clubs found', style: TextStyle(color: Colors.white)));
              }
              return SingleChildScrollView(
                padding: const EdgeInsets.only(top: 100, bottom: 0, left: 16, right: 16),
                child: Column(
                  children: [
                    // Table Header
                    _buildTableHeader(),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: clubs.length,
                      itemBuilder: (context, index) {
                        final club = clubs[index];
                        return _buildTableRow(context, index + 1, club);
                      },
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator(color: Colors.teal)),
            error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.redAccent))),
          ),
        ],
      ),
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
        gradient: LeagueColors.getGradient(league.name),
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

  Widget _buildTableRow(BuildContext context, int pos, Club club) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClubSquadPage(clubId: club.id, clubName: club.name),
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
            Expanded(child: Text(club.name, style: const TextStyle(color: Colors.white, fontSize: 13))),
            _buildCell('0', width: 25),
            _buildCell('0', width: 25),
            _buildCell('0', width: 25),
            _buildCell('0', width: 25),
            _buildCell('0', width: 25),
            _buildCell('0', width: 25),
            _buildCell('0', width: 25),
            _buildCell('0', width: 30, bold: true, color: Colors.yellowAccent),
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
