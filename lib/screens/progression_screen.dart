import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import 'league_selection_screen.dart';
import '../ad_manager.dart';

class ProgressionScreen extends StatelessWidget {
  final EmoteItem emote;

  const ProgressionScreen({super.key, required this.emote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Top Gradient Area (Teal Theme) ─────────────────────────
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF0A2A2A),
                    AppColors.accentTeal.withValues(alpha: 0.06),
                    AppColors.bgDark,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  child: Column(
                    children: [
                      // Back button row
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.accentTeal.withValues(alpha: 0.2),
                                border: Border.all(
                                  color: AppColors.accentTeal.withValues(alpha: 0.4),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                color: AppColors.accentTeal,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Character silhouette
                      Icon(
                        Icons.person_rounded,
                        size: 90,
                        color: AppColors.accentTeal.withValues(alpha: 0.2),
                      ),
                      const SizedBox(height: 16),
                      // Title
                      Text(
                        'PROGRESSION LEVEL',
                        style: AppTextStyles.screenTitle.copyWith(
                          color: AppColors.accentTeal,
                          letterSpacing: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Account Maturity Section ────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.accentTeal,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentTeal.withValues(alpha: 0.4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'ACCOUNT MATURITY',
                    style: AppTextStyles.sectionTitle.copyWith(
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Level Range Cards ───────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final level = AppData.levelRanges[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _LevelRangeCard(
                      level: level,
                      onTap: () {
                        AdManager.showAdWithCallback(context, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  LeagueSelectionScreen(emote: emote),
                            ),
                          );
                        });
                      },
                    ),
                  );
                },
                childCount: AppData.levelRanges.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelRangeCard extends StatelessWidget {
  final LevelRange level;
  final VoidCallback onTap;

  const _LevelRangeCard({required this.level, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.bgCard.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: level.color.withValues(alpha: 0.25),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: level.color.withValues(alpha: 0.06),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Grid icon in colored circle
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: level.iconBg,
                border: Border.all(
                  color: level.color.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.grid_view_rounded,
                color: level.color,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            // Level info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    level.label,
                    style: AppTextStyles.cardTitle.copyWith(
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    level.description,
                    style: AppTextStyles.bodyText.copyWith(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            // Double chevron arrow
            Column(
              children: [
                Icon(
                  Icons.keyboard_double_arrow_right_rounded,
                  color: level.color.withValues(alpha: 0.6),
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
