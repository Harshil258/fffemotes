import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import '../widgets/glass_card.dart';
import '../widgets/neon_button.dart';
import 'home_screen.dart';
import '../ad_manager.dart';

class ToolCompleteScreen extends StatefulWidget {
  final ToolItem tool;

  const ToolCompleteScreen({super.key, required this.tool});

  @override
  State<ToolCompleteScreen> createState() => _ToolCompleteScreenState();
}

class _ToolCompleteScreenState extends State<ToolCompleteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _checkController;
  late Animation<double> _checkScale;

  @override
  void initState() {
    super.initState();
    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _checkScale = Tween<double>(begin: 0.92, end: 1.08).animate(
      CurvedAnimation(parent: _checkController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tool = widget.tool;
    final accentColor = tool.rarity.color;

    return Scaffold(
      backgroundColor: AppColors.bgDarkest,
      body: Stack(
        children: [
          // ── Gradient circle decorations ─────────────────────────────
          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accentCyan.withValues(alpha: 0.06),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    accentColor.withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // ── Content ──
          SafeArea(
            child: Column(
              children: [
                // Back button
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: accentColor.withValues(alpha: 0.15),
                          border: Border.all(
                            color: accentColor.withValues(alpha: 0.4),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: accentColor,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 1),

                // ── Faded weapon/companion silhouette ──
                Opacity(
                  opacity: 0.12,
                  child: Image.asset(
                    tool.imagePath,
                    width: 140,
                    height: 140,
                    fit: BoxFit.contain,
                    color: accentColor,
                    colorBlendMode: BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: 8),

                // ── Title ──
                const Text(
                  'SYNCHRONIZATION\nCOMPLETE',
                  style: AppTextStyles.heroTitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),

                // ── Main GlassCard ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: GlassCard(
                    borderColor: accentColor.withValues(alpha: 0.3),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Column(
                      children: [
                        // Animated checkmark
                        AnimatedBuilder(
                          animation: _checkScale,
                          builder: (context, _) {
                            return Transform.scale(
                              scale: _checkScale.value,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: accentColor,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: accentColor.withValues(alpha: 0.2),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: accentColor.withValues(alpha: 0.12),
                                    ),
                                    child: Icon(
                                      Icons.check_rounded,
                                      size: 40,
                                      color: accentColor,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),

                        // Algorithm optimized text
                        Text(
                          'INJECTION COMPLETED',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: accentColor,
                            letterSpacing: 4,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Tool name
                        Text(
                          tool.name,
                          style: AppTextStyles.screenTitle.copyWith(
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 14),

                        // Description
                        Text(
                          'The asset skin protocol was successfully executed.\nYour inventory has been updated with level ${tool.evoLevels.length} modifications.',
                          style: AppTextStyles.bodyText.copyWith(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                // ── Return button ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: NeonButton(
                    text: 'RETURN TO VAULT',
                    icon: Icons.home_rounded,
                    gradientColors: [accentColor, AppColors.accentPurple],
                    onPressed: () {
                      AdManager.showAdWithCallback(context, () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomeScreen(),
                          ),
                          (route) => false,
                        );
                      });
                    },
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
