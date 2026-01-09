import 'package:flutter/material.dart';
import '../../../../core/presentation/widgets/game_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
          
          // Overlay Gradient for better visibility (optional but good for premium feel)
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
      ),
    );
  }
}
