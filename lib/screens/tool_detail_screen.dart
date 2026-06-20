import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import '../ad_manager.dart';
import '../widgets/status_badge.dart';
import '../widgets/stat_card.dart';
import '../widgets/neon_button.dart';
import 'tool_evolution_screen.dart';

class ToolDetailScreen extends StatelessWidget {
  final ToolItem tool;

  const ToolDetailScreen({super.key, required this.tool});

  @override
  Widget build(BuildContext context) {
    final accentColor = tool.rarity.color;
    final isWeapon = tool.id.startsWith('t_eg');

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top hero area with gradient + image ──
            Stack(
              children: [
                // Gradient background
                Container(
                  width: double.infinity,
                  height: 340,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        accentColor.withValues(alpha: 0.18),
                        AppColors.bgDark,
                      ],
                    ),
                  ),
                ),

                // Centered tool image with glow
                Positioned.fill(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accentColor.withValues(alpha: 0.05),
                            boxShadow: [
                              BoxShadow(
                                color: accentColor.withValues(alpha: 0.2),
                                blurRadius: 60,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Image.asset(
                              tool.imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Back button
                Positioned(
                  top: MediaQuery.of(context).padding.top + 12,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.accentPink.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.accentPink.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.accentPink,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ── Content ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rarity grade badge
                  Center(
                    child: StatusBadge.rarity(
                      '${tool.rarity.label} GRADE',
                      accentColor,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tool name
                  Center(
                    child: Text(
                      tool.name,
                      style: AppTextStyles.cardTitle.copyWith(
                        fontSize: 24,
                        letterSpacing: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Description
                  Text(
                    tool.description,
                    style: AppTextStyles.bodyText,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  // ── STATS Section ──
                  Row(
                    children: [
                      Container(
                        width: 3,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.accentPink,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        isWeapon ? 'WEAPON SPECIFICATIONS' : 'COMPANION ATTRIBUTES',
                        style: AppTextStyles.sectionTitle,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Render attributes
                  if (isWeapon) ...[
                    _buildStatBar('DAMAGE', tool.damage, AppColors.accentPink),
                    _buildStatBar('RATE OF FIRE', tool.rateOfFire, AppColors.accentCyan),
                    _buildStatBar('RANGE', tool.range, AppColors.accentGold),
                    _buildStatBar('ACCURACY', tool.accuracy, AppColors.accentGreen),
                  ] else ...[
                    _buildStatBar('COMPATIBILITY', 88, AppColors.accentPurple),
                    _buildStatBar('ENERGY OUTPUT', 92, AppColors.accentCyan),
                    _buildStatBar('TACTICAL RANGE', 75, AppColors.accentGold),
                    _buildStatBar('SKILL LEVEL', 99, AppColors.accentGreen),
                  ],

                  const SizedBox(height: 28),

                  // ── Quick Info cards ──
                  Row(
                    children: [
                      StatCard(
                        icon: Icons.flash_on_rounded,
                        value: 'ULTRA',
                        label: 'SPEED',
                        color: accentColor,
                      ),
                      const SizedBox(width: 10),
                      const StatCard(
                        icon: Icons.trending_up_rounded,
                        value: 'MAX',
                        label: 'STABILITY',
                        color: AppColors.accentGold,
                      ),
                      const SizedBox(width: 10),
                      const StatCard(
                        icon: Icons.security_rounded,
                        value: 'SECURED',
                        label: 'PROTOCOL',
                        color: AppColors.accentGreen,
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // ── Action Button ──
                  SizedBox(
                    width: double.infinity,
                    child: NeonButton(
                      text: 'UPGRADE EVO MODULE',
                      icon: Icons.rocket_launch_rounded,
                      gradientColors: const [AppColors.accentPink, AppColors.accentPurple],
                      onPressed: () {
                        AdManager.showAdWithCallback(context, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ToolEvolutionScreen(tool: tool),
                            ),
                          );
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBar(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                  letterSpacing: 1,
                ),
              ),
              Text(
                '$value/100',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: color,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value / 100,
              minHeight: 5,
              backgroundColor: AppColors.bgMedium,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
