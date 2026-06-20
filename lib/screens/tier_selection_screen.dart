import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import 'progression_screen.dart';
import '../ad_manager.dart';

class TierSelectionScreen extends StatelessWidget {
  final EmoteItem emote;

  const TierSelectionScreen({super.key, required this.emote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Top Gradient Area ──────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF3B2A0A),
                    AppColors.accentGold.withValues(alpha: 0.08),
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
                                color: AppColors.accentGold.withValues(alpha: 0.2),
                                border: Border.all(
                                  color: AppColors.accentGold.withValues(alpha: 0.4),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                color: AppColors.accentGold,
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
                        color: AppColors.accentGold.withValues(alpha: 0.25),
                      ),
                      const SizedBox(height: 16),
                      // Title
                      Text(
                        'TIER SELECTION',
                        style: AppTextStyles.screenTitle.copyWith(
                          color: AppColors.accentGold,
                          letterSpacing: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Competitive Bracket Section ─────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.accentGold,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentGold.withValues(alpha: 0.4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'COMPETITIVE BRACKET',
                    style: AppTextStyles.sectionTitle.copyWith(
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Tier Cards ──────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final tier = AppData.tiers[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _TierCard(
                      tier: tier,
                      onTap: () {
                        AdManager.showAdWithCallback(context, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProgressionScreen(emote: emote),
                            ),
                          );
                        });
                      },
                    ),
                  );
                },
                childCount: AppData.tiers.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TierCard extends StatelessWidget {
  final TierItem tier;
  final VoidCallback onTap;

  const _TierCard({required this.tier, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              tier.bgColor,
              tier.bgColor.withValues(alpha: 0.6),
            ],
          ),
          border: Border.all(
            color: tier.color.withValues(alpha: 0.25),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: tier.color.withValues(alpha: 0.08),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Medal icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tier.color.withValues(alpha: 0.15),
                border: Border.all(
                  color: tier.color.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.military_tech_rounded,
                color: tier.color,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            // Tier info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        tier.name,
                        style: AppTextStyles.cardTitle.copyWith(
                          fontSize: 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: tier.color.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: tier.color.withValues(alpha: 0.4),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          tier.badge,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: tier.color,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tier.description,
                    style: AppTextStyles.bodyText.copyWith(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            // Chevron
            Icon(
              Icons.chevron_right_rounded,
              color: tier.color.withValues(alpha: 0.6),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
