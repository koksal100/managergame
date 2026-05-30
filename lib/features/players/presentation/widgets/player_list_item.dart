import 'package:flutter/material.dart';
import '../../domain/entities/player.dart';

class PlayerListItem extends StatelessWidget {
  final Player player;
  final VoidCallback? onTap;

  const PlayerListItem({super.key, required this.player, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getPositionColor(player.position),
          child: Text(
            player.position,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        title: Text(
          player.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "Age: ${player.age} • OVR: ${player.ca}",
          style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
        ),
        trailing: Text(
          _formatCurrency(player.marketValue),
          style: const TextStyle(
            color: Colors.amberAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Color _getPositionColor(String position) {
    if (['GK'].contains(position)) {
      return Colors.orange;
    }
    if (['DL', 'DC', 'DR'].contains(position)) {
      return Colors.green;
    }
    if (['DMC', 'MC', 'AMC', 'ML', 'MR'].contains(position)) {
      return Colors.amber.shade700;
    }
    if (['AML', 'AMR', 'ST', 'FWD'].contains(position)) {
      return Colors.redAccent;
    }
    return Colors.blueGrey;
  }

  String _formatCurrency(int value) {
    if (value >= 1000000) {
      return '€${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '€${(value / 1000).toStringAsFixed(0)}K';
    }
    return '€$value';
  }
}
