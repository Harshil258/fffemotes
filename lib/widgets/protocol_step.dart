import 'package:flutter/material.dart';
import '../app_theme.dart';

class ProtocolStep extends StatelessWidget {
  final String label;
  final String timing;
  final bool completed;
  final bool loading;

  const ProtocolStep({
    super.key,
    required this.label,
    required this.timing,
    this.completed = false,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.bgCard.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: completed
              ? AppColors.borderCyan
              : AppColors.textMuted.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: completed
                  ? AppColors.accentCyan.withValues(alpha: 0.2)
                  : AppColors.textMuted.withValues(alpha: 0.1),
            ),
            child: Center(
              child: loading
                  ? SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.textMuted,
                        ),
                      ),
                    )
                  : Icon(
                      completed ? Icons.check_rounded : Icons.hourglass_empty_rounded,
                      size: 16,
                      color: completed ? AppColors.accentCyan : AppColors.textMuted,
                    ),
            ),
          ),
          const SizedBox(width: 14),
          // Label
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: completed ? AppColors.textPrimary : AppColors.textMuted,
                letterSpacing: 1.5,
              ),
            ),
          ),
          // Timing
          Text(
            timing,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: completed ? AppColors.accentCyan : AppColors.textMuted,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
