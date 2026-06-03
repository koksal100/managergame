import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/weekly_decision_provider.dart';

class WeeklyDecisionDialog extends ConsumerStatefulWidget {
  const WeeklyDecisionDialog({super.key, required this.decision});

  final WeeklyDecision decision;

  @override
  ConsumerState<WeeklyDecisionDialog> createState() =>
      _WeeklyDecisionDialogState();
}

class _WeeklyDecisionDialogState extends ConsumerState<WeeklyDecisionDialog> {
  bool _submitting = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF171717),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Colors.white12),
              ),
              child: Text(
                widget.decision.categoryLabel,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.decision.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.decision.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 18),
            for (final option in widget.decision.options) ...[
              _DecisionOptionCard(
                option: option,
                disabled: _submitting,
                onTap: () => _applyOption(option),
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _applyOption(WeeklyDecisionOption option) async {
    setState(() => _submitting = true);
    await ref.read(weeklyDecisionServiceProvider).applyDecisionOption(option);
    if (mounted) {
      Navigator.of(context).pop(true);
    }
  }
}

class _DecisionOptionCard extends StatelessWidget {
  const _DecisionOptionCard({
    required this.option,
    required this.onTap,
    required this.disabled,
  });

  final WeeklyDecisionOption option;
  final VoidCallback onTap;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(disabled ? 0.04 : 0.07),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              option.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              option.summary,
              style: const TextStyle(color: Colors.white60, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
