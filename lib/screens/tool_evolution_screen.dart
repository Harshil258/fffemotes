import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import '../widgets/glass_card.dart';
import '../widgets/neon_button.dart';
import 'tool_protocol_screen.dart';
import '../ad_manager.dart';

class ToolEvolutionScreen extends StatelessWidget {
  final ToolItem tool;

  const ToolEvolutionScreen({super.key, required this.tool});

  @override
  Widget build(BuildContext context) {
    final accentColor = tool.rarity.color;

    return Scaffold(
      backgroundColor: AppColors.bgDarkest,
      body: SafeArea(
        child: Column(
          children: [
            // ── Custom AppBar header ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: accentColor.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: accentColor,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EVO MODULES',
                          style: AppTextStyles.label.copyWith(
                            color: accentColor,
                            letterSpacing: 3,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          tool.name,
                          style: AppTextStyles.cardTitle.copyWith(
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Scrollable Evolution Levels ──
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mini preview banner
                    GlassCard(
                      borderColor: accentColor.withValues(alpha: 0.3),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Image.asset(
                            tool.imagePath,
                            width: 60,
                            height: 60,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'EVOLUTION STATUS: STABLE',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.accentCyan,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Syncing all 7 levels of visual modifications, special effects, and stats.',
                                  style: AppTextStyles.bodyText.copyWith(
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Section Title
                    Row(
                      children: [
                        Container(
                          width: 3,
                          height: 20,
                          decoration: BoxDecoration(
                            color: accentColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'UPGRADE MILESTONES',
                          style: AppTextStyles.sectionTitle,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // 7 levels list
                    ...List.generate(tool.evoLevels.length, (i) {
                      final isLast = i == tool.evoLevels.length - 1;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GlassCard(
                          borderColor: isLast
                              ? AppColors.accentGold.withValues(alpha: 0.4)
                              : accentColor.withValues(alpha: 0.2),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Level badge
                              Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (isLast ? AppColors.accentGold : accentColor).withValues(alpha: 0.15),
                                  border: Border.all(
                                    color: (isLast ? AppColors.accentGold : accentColor).withValues(alpha: 0.4),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${i + 1}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w900,
                                      color: isLast ? AppColors.accentGold : accentColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isLast ? 'MAX LEVEL TRANSFORMATION' : 'EVO LEVEL ${i + 1}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: isLast ? AppColors.accentGold : AppColors.textPrimary,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      tool.evoLevels[i],
                                      style: AppTextStyles.bodyText.copyWith(
                                        fontSize: 12,
                                        height: 1.4,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 20),

                    // CTA Button
                    SizedBox(
                      width: double.infinity,
                      child: NeonButton(
                        text: 'SYNC UPGRADE DATA',
                        icon: Icons.power_rounded,
                        gradientColors: const [AppColors.accentCyan, AppColors.accentGreen],
                        onPressed: () {
                          AdManager.showAdWithCallback(context, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ToolProtocolScreen(tool: tool),
                              ),
                            );
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
