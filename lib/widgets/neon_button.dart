import 'package:flutter/material.dart';
import '../app_theme.dart';

class NeonButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final List<Color> gradientColors;
  final double height;
  final double borderRadius;

  const NeonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.gradientColors = const [AppColors.accentCyan, AppColors.accentGreen],
    this.height = 52,
    this.borderRadius = 14,
  });

  /// Purple/blue gradient variant
  factory NeonButton.purple({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
  }) {
    return NeonButton(
      key: key,
      text: text,
      onPressed: onPressed,
      icon: icon,
      gradientColors: const [Color(0xFF7C4DFF), Color(0xFF448AFF)],
    );
  }

  @override
  State<NeonButton> createState() => _NeonButtonState();
}

class _NeonButtonState extends State<NeonButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnim.value,
          child: child,
        ),
        child: Container(
          height: widget.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.gradientColors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              BoxShadow(
                color: widget.gradientColors.first.withValues(alpha: 0.4),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, color: AppColors.bgDarkest, size: 20),
                  const SizedBox(width: 10),
                ],
                Text(
                  widget.text,
                  style: AppTextStyles.buttonText.copyWith(
                    color: AppColors.bgDarkest,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

