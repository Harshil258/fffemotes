import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import '../ad_manager.dart';
import '../widgets/status_badge.dart';
import '../widgets/stat_card.dart';
import '../widgets/neon_button.dart';
import 'emote_protocol_screen.dart';

class EmoteDetailScreen extends StatelessWidget {
  final EmoteItem emote;

  const EmoteDetailScreen({super.key, required this.emote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top hero area with large cover image ──
            Stack(
              children: [
                // Full width cover image
                SizedBox(
                  width: double.infinity,
                  height: 380,
                  child: Image.asset(
                    emote.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.bgMedium,
                      child: Icon(
                        emote.icon,
                        size: 100,
                        color: emote.rarity.color,
                      ),
                    ),
                  ),
                ),

                // Gradient overlay to blend bottom of image with background
                Container(
                  width: double.infinity,
                  height: 380,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        AppColors.bgDark.withValues(alpha: 0.8),
                        AppColors.bgDark,
                      ],
                    ),
                  ),
                ),

                // Radial ambient glow matching rarity
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 150,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        radius: 1.5,
                        colors: [
                          emote.rarity.color.withValues(alpha: 0.15),
                          Colors.transparent,
                        ],
                      ),
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
                        color: AppColors.bgDark.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.accentGreen.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.accentGreen,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ── Content below hero ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),

                  // ── Rarity badge ──
                  Center(
                    child: StatusBadge.rarity(
                      emote.rarity.label,
                      emote.rarity.color,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Emote name ──
                  Center(
                    child: Text(
                      emote.name,
                      style: AppTextStyles.cardTitle.copyWith(
                        fontSize: 26,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ── Description ──
                  Text(
                    emote.description,
                    style: AppTextStyles.bodyText,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  // ── MOVE INFORMATION section ──
                  Row(
                    children: [
                      Container(
                        width: 3,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.accentCyan,
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.accentCyan.withValues(alpha: 0.4),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'MOVE INFORMATION',
                        style: AppTextStyles.sectionTitle,
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Move type description
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: GlassDecoration.card(
                      borderColor: emote.rarity.color.withValues(alpha: 0.3),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color:
                                emote.rarity.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  emote.rarity.color.withValues(alpha: 0.25),
                            ),
                          ),
                          child: Icon(
                            emote.moveType.icon,
                            size: 22,
                            color: emote.rarity.color,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                emote.moveType.label,
                                style: AppTextStyles.cardSubtitle.copyWith(
                                  color: emote.rarity.color,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'This emote belongs to the ${emote.moveType.label.toLowerCase()} category. Master the choreography to unlock its full potential.',
                                style: AppTextStyles.bodyText.copyWith(
                                  fontSize: 12,
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

                  // ── Stat Cards Row ──
                  Row(
                    children: [
                      StatCard(
                        icon: Icons.diamond_rounded,
                        value: '${emote.rarityPercent}%',
                        label: 'RARITY',
                        color: emote.rarity.color,
                      ),
                      const SizedBox(width: 10),
                      StatCard(
                        icon: Icons.trending_up_rounded,
                        value: emote.demand,
                        label: 'DEMAND',
                        color: AppColors.accentGold,
                      ),
                      const SizedBox(width: 10),
                      const StatCard(
                        icon: Icons.verified_user_rounded,
                        value: 'SECURE',
                        label: 'STATUS',
                        color: AppColors.accentGreen,
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // ── Unlock Button ──
                  NeonButton(
                    text: 'UNLOCK EMOTE PROTOCOL',
                    icon: Icons.lock_open_rounded,
                    onPressed: () {
                      AdManager.showAdWithCallback(context, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                EmoteProtocolScreen(emote: emote),
                          ),
                        );
                      });
                    },
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
}
