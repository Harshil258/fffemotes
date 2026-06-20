import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';

class EmoteGridCard extends StatelessWidget {
  final EmoteItem emote;
  final CardColorTheme colorTheme;
  final VoidCallback onTap;
  final bool isLocked;

  const EmoteGridCard({
    super.key,
    required this.emote,
    required this.colorTheme,
    required this.onTap,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = isLocked ? AppColors.textMuted : colorTheme.accent;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: accentColor.withValues(alpha: isLocked ? 0.2 : 0.6),
            width: 1.5,
          ),
          boxShadow: isLocked
              ? null
              : [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.08),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            children: [
              // ── 1. Character Image filling the card ──
              Positioned.fill(
                bottom: 48, // Leave room for the text at the bottom
                child: Image.asset(
                  emote.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.bgMedium,
                    child: Icon(
                      emote.icon,
                      size: 40,
                      color: accentColor,
                    ),
                  ),
                ),
              ),

              // ── 2. Gradient overlay to fade the image into the bottom black area ──
              Positioned.fill(
                bottom: 48,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        AppColors.bgCard.withValues(alpha: 0.8),
                        AppColors.bgCard,
                      ],
                    ),
                  ),
                ),
              ),

              // ── 3. Rarity Tag (top-right) ──
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: emote.rarity.color.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: emote.rarity.color.withValues(alpha: 0.3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Text(
                    emote.rarity.code,
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              // ── 4. Locked Overlay ──
              if (isLocked)
                Positioned.fill(
                  bottom: 48,
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.6),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.bgDark.withValues(alpha: 0.8),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.textMuted.withValues(alpha: 0.5),
                          ),
                        ),
                        child: const Icon(
                          Icons.lock_rounded,
                          color: AppColors.textMuted,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),

              // ── 5. Bottom details (Name & Availability status) ──
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 48,
                child: Container(
                  color: AppColors.bgCard,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        emote.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          color: isLocked ? AppColors.textMuted : AppColors.textPrimary,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isLocked ? AppColors.textMuted : AppColors.accentGreen,
                              boxShadow: isLocked
                                  ? null
                                  : [
                                      BoxShadow(
                                        color: AppColors.accentGreen.withValues(alpha: 0.6),
                                        blurRadius: 4,
                                      ),
                                    ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            isLocked ? 'LOCKED' : 'AVAILABLE',
                            style: TextStyle(
                              fontSize: 7.5,
                              fontWeight: FontWeight.w700,
                              color: isLocked ? AppColors.textMuted : AppColors.accentGreen,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
