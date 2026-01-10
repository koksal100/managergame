import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class NegotiationGameDialog extends StatefulWidget {
  final int playerReputation;
  final int managerReputation;
  final String playerName;

  const NegotiationGameDialog({
    super.key,
    required this.playerReputation,
    required this.managerReputation,
    required this.playerName,
  });

  @override
  State<NegotiationGameDialog> createState() => _NegotiationGameDialogState();
}

class _NegotiationGameDialogState extends State<NegotiationGameDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _targetStartAngle;
  late double _targetSweepAngle;
  double _currentAngle = 0;
  bool _isPlaying = true;
  bool? _success;
  String _difficultyText = "Normal";

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    // Difficulty Calculation
    // Diff: Player Rep - Manager Rep
    int diff = widget.playerReputation - widget.managerReputation;
    
    // User Tuning: 
    // Diff <= 60 -> Easy/Normal
    // Diff 100 -> Impossible

    int durationMs = 1500;
    
    if (diff <= 60) {
      // EASY / NORMAL ZONE
      // Even with 60 diff, we keep it relatively easy.
      // Maybe slight speed up but generally friendly.
      durationMs = 1500; // 1.5s per rotation
      _targetSweepAngle = pi / 4; // 45 degrees
      
      if (diff <= 0) {
        _difficultyText = "Very Easy";
        _targetSweepAngle = pi / 3; // 60 degrees for superior manager
        durationMs = 2000;
      } else {
        _difficultyText = "Easy";
      }
      
    } else {
      // HARD ZONE (60 to 100+)
      // Scale linearly between 60 (Normal) and 100 (Impossible)
      int excess = diff - 60; // 0 to 40+
      
      // Speed: 
      // At excess 0 (Diff 60) -> 1500ms
      // At excess 40 (Diff 100) -> 300ms (Super Fast)
      durationMs = (1500 - (excess * 30)).clamp(300, 1500);
      
      // Angle:
      // At excess 0 -> 45 deg
      // At excess 40 -> 5 deg (Tiny)
      double baseSweep = pi / 4;
      double reduction = excess * 0.02; // 40 * 0.02 = 0.8 rads (approx 45 deg)
      _targetSweepAngle = (baseSweep - reduction).clamp(pi / 36, baseSweep); // Min 5 degrees
      
      if (diff >= 100) _difficultyText = "IMPOSSIBLE";
      else if (diff >= 80) _difficultyText = "Very Hard";
      else _difficultyText = "Hard";
    }
    
    // Randomize Target Position
    _targetStartAngle = Random().nextDouble() * 2 * pi;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: durationMs),
    )..repeat();

    _controller.addListener(() {
      setState(() {
        _currentAngle = _controller.value * 2 * pi;
      });
    });
  }

  void _handleTap() {
    if (!_isPlaying) return;

    _controller.stop();
    setState(() {
      _isPlaying = false;
    });

    // Check Hit Logic
    // We normalize everything to 0 -> 2*pi range
    double pointer = _currentAngle % (2 * pi);
    double start = _targetStartAngle;
    double end = (_targetStartAngle + _targetSweepAngle) % (2 * pi);

    bool hit = false;
    
    // Handle wrap-around case (e.g. start at 350 deg, width 20 deg -> ends at 10 deg)
    if (start + _targetSweepAngle > 2 * pi) {
       // Target crosses the 0 boundary
       // Hit if pointer is > start OR pointer < (end normalized)
       double endNormalized = (start + _targetSweepAngle) - (2 * pi);
       hit = pointer >= start || pointer <= endNormalized;
    } else {
       // Standard case
       hit = pointer >= start && pointer <= (start + _targetSweepAngle);
       // Visual correction: sometimes painting and logical check might drift slightly due to stroke width?
       // But math is solid.
    }

    setState(() {
      _success = hit;
    });
    
    Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) Navigator.pop(context, hit);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.white;
    String statusText = "TAP TO NEGOTIATE";
    
    if (!_isPlaying) {
      if (_success == true) {
        statusColor = Colors.greenAccent;
        statusText = "AGREEMENT REACHED!";
      } else {
        statusColor = Colors.redAccent;
        statusText = "NEGOTIATION FAILED";
      }
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white24),
            ),
            child: Column(
              children: [
                Text(
                  "NEGOTIATION",
                  style: TextStyle(
                    color: Colors.tealAccent,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "With: ${widget.playerName}",
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 5),
                Container(
                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                   decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4)),
                   child: Text(
                     "Difficulty: $_difficultyText",
                     style: const TextStyle(color: Colors.amberAccent, fontSize: 10, fontWeight: FontWeight.bold),
                   ),
                )
              ],
            ),
          ),
          
          const SizedBox(height: 30),

          // GAME CIRCLE
          GestureDetector(
            onTap: _handleTap,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black54,
                border: Border.all(
                  color: _isPlaying ? Colors.white24 : statusColor,
                  width: 4
                ),
                boxShadow: [
                  BoxShadow(
                    color: (_isPlaying ? Colors.tealAccent : statusColor).withOpacity(0.2),
                    blurRadius: 30,
                    spreadRadius: 5
                  )
                ]
              ),
              child: CustomPaint(
                painter: _WheelPainter(
                  currentAngle: _currentAngle,
                  targetStartAngle: _targetStartAngle,
                  targetSweepAngle: _targetSweepAngle,
                  success: _success,
                ),
                child: Center(
                  child: _isPlaying 
                    ? const Icon(Icons.touch_app, color: Colors.white24, size: 40)
                    : Icon(
                        _success == true ? Icons.check_circle : Icons.cancel,
                        color: statusColor,
                        size: 60,
                      )
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Status Text
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              statusText,
              key: ValueKey(statusText),
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  final double currentAngle;
  final double targetStartAngle;
  final double targetSweepAngle;
  final bool? success;

  _WheelPainter({
    required this.currentAngle,
    required this.targetStartAngle,
    required this.targetSweepAngle,
    this.success,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    
    // 1. Draw Background Track
    final trackPaint = Paint()
      ..color = Colors.white10
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;
    
    canvas.drawCircle(center, radius, trackPaint);

    // 2. Draw Target Arc
    final targetPaint = Paint()
      ..color = (success == false) ? Colors.grey : Colors.greenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.butt;
      
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      targetStartAngle, // Radians
      targetSweepAngle, // Radians
      false,
      targetPaint,
    );
    
    // 3. Draw Indicator (Spinner)
    // Calculate point on circle
    final indicatorX = center.dx + radius * cos(currentAngle);
    final indicatorY = center.dy + radius * sin(currentAngle);
    
    final indicatorPaint = Paint()
      ..color = (success != null) 
          ? (success! ? Colors.green : Colors.red) 
          : Colors.amber
      ..style = PaintingStyle.fill;
      
    // Draw the pointer tip
    canvas.drawCircle(Offset(indicatorX, indicatorY), 8, indicatorPaint);
    
    // Draw line to center for visual clarity
    final linePaint = Paint()
      ..color = (success != null) 
          ? (success! ? Colors.green : Colors.red).withOpacity(0.5)
          : Colors.amber.withOpacity(0.5)
      ..strokeWidth = 2;
      
    canvas.drawLine(center, Offset(indicatorX, indicatorY), linePaint);

    // Center Hub
    canvas.drawCircle(center, 5, indicatorPaint);
  }

  @override
  bool shouldRepaint(covariant _WheelPainter oldDelegate) {
    return oldDelegate.currentAngle != currentAngle || oldDelegate.success != success;
  }
}
