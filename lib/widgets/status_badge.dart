import 'package:flutter/material.dart';
import '../app_theme.dart';

class StatusBadge extends StatelessWidget {
  final String text;
  final Color color;
  final bool showDot;
  final double fontSize;

  const StatusBadge({
    super.key,
    required this.text,
    this.color = AppColors.accentCyan,
    this.showDot = true,
    this.fontSize = 12,
  });

  factory StatusBadge.rarity(String rarity, Color color) {
    return StatusBadge(
      text: '$rarity GRADE',
      color: color,
      showDot: false,
      fontSize: 11,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.6),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
