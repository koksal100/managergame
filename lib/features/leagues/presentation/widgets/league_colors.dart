import 'package:flutter/material.dart';

class LeagueColors {
  static LinearGradient getGradient(String leagueName) {
    switch (leagueName) {
      case 'Super Lig':
        return const LinearGradient(
          colors: [Color(0xFFE30A17), Colors.white], // Turkey (Red/White)
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'La Liga':
        return const LinearGradient(
          colors: [Color(0xFFAA151B), Color(0xFFF1BF00), Color(0xFFAA151B)], // Spain
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.2, 0.5, 0.8],
        );
      case 'Premier League':
        return const LinearGradient(
          colors: [Colors.white, Color(0xFFCE1124)], // England
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'Bundesliga':
        return const LinearGradient(
          colors: [Colors.black87, Color(0xFFDD0000), Color(0xFFFFCC00)], // Germany
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'Serie A':
        return const LinearGradient(
          colors: [Color(0xFF009246), Colors.white, Color(0xFFCE2B37)], // Italy
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'Ligue 1':
        return const LinearGradient(
          colors: [Color(0xFF0055A4), Colors.white, Color(0xFFEF4135)], // France
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'Brasileirao':
        return const LinearGradient(
          colors: [Color(0xFF009C3B), Color(0xFFFFDF00), Color(0xFF002776)], // Brazil
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'Liga Profesional':
        return const LinearGradient(
          colors: [Color(0xFF74ACDF), Colors.white, Color(0xFF74ACDF)], // Argentina
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'Liga Portugal':
        return const LinearGradient(
          colors: [Color(0xFF046A38), Color(0xFFDA291C)], // Portugal
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'Eredivisie':
        return const LinearGradient(
          colors: [Color(0xFF21468B), Colors.white, Color(0xFFAE1C28)], // Netherlands
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return LinearGradient(
          colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  // Returns a solid color approximating the league identity (e.g. for texts on dark gradients)
  static Color getPrimaryColor(String leagueName) {
    // For now simple return white or specific if needed.
    return Colors.white;
  }
}
