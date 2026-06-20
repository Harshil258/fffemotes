import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import '../widgets/glass_card.dart';
import '../widgets/neon_button.dart';
import 'home_screen.dart';
import '../ad_manager.dart';

class HandshakeCompleteScreen extends StatefulWidget {
  final EmoteItem emote;

  const HandshakeCompleteScreen({super.key, required this.emote});

  @override
  State<HandshakeCompleteScreen> createState() =>
      _HandshakeCompleteScreenState();
}

class _HandshakeCompleteScreenState extends State<HandshakeCompleteScreen>
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
    final emote = widget.emote;

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
                    AppColors.accentPurple.withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 120,
            right: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accentGold.withValues(alpha: 0.04),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // ── Content ─────────────────────────────────────────────────
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
                          color: AppColors.accentCyan.withValues(alpha: 0.15),
                          border: Border.all(
                            color: AppColors.accentCyan.withValues(alpha: 0.4),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.accentCyan,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 1),

                // ── Faded silhouette ──────────────────────────────────
                Opacity(
                  opacity: 0.15,
                  child: Image.asset(
                    emote.imagePath,
                    width: 110,
                    height: 110,
                    fit: BoxFit.cover,
                    color: AppColors.accentCyan,
                    colorBlendMode: BlendMode.srcIn,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.person_rounded,
                      size: 110,
                      color: AppColors.accentCyan.withValues(alpha: 0.15),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // ── Title ─────────────────────────────────────────────
                const Text(
                  'HANDSHAKE\nCOMPLETE',
                  style: AppTextStyles.heroTitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),

                // ── Main GlassCard ────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: GlassCard(
                    borderColor: AppColors.accentCyan.withValues(alpha: 0.3),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 32),
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
                                    color: AppColors.accentCyan,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.accentCyan
                                          .withValues(alpha: 0.2),
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
                                      color: AppColors.accentCyan
                                          .withValues(alpha: 0.12),
                                    ),
                                    child: const Icon(
                                      Icons.check_rounded,
                                      size: 40,
                                      color: AppColors.accentCyan,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),

                        // Algorithm optimized text
                        const Text(
                          'ALGORITHM OPTIMIZED',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accentCyan,
                            letterSpacing: 4,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Emote name
                        Text(
                          emote.name,
                          style: AppTextStyles.screenTitle.copyWith(
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 14),

                        // Description
                        const Text(
                          'Emote protocol successfully executed.\nYour emote vault has been synchronized.',
                          style: AppTextStyles.bodyText,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                // ── Return button ─────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: NeonButton(
                    text: 'RETURN TO VAULT',
                    icon: Icons.home_rounded,
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
