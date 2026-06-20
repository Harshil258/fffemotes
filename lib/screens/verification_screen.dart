import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import '../widgets/glass_card.dart';
import '../widgets/neon_button.dart';
import '../ad_manager.dart';
import 'tier_selection_screen.dart';

class VerificationScreen extends StatelessWidget {
  final EmoteItem emote;

  const VerificationScreen({super.key, required this.emote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'USER VERIFICATION',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: 3,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentCyan.withValues(alpha: 0.2),
                border: Border.all(
                  color: AppColors.accentCyan.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.accentCyan,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Payload Identified Card ────────────────────────────────
            GlassCard(
              child: Row(
                children: [
                  // Glowing rounded-rect emote container
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.accentCyan.withValues(alpha: 0.6),
                        width: 1.5,
                      ),
                      color: AppColors.bgMedium,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentCyan.withValues(alpha: 0.15),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        emote.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          emote.icon,
                          color: AppColors.accentCyan,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PAYLOAD IDENTIFIED',
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.accentCyan,
                            letterSpacing: 3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          emote.name,
                          style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Ready for synchronization',
                          style: AppTextStyles.bodyText.copyWith(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Checkmark icon
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accentGreen.withValues(alpha: 0.15),
                      border: Border.all(
                        color: AppColors.accentGreen.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: AppColors.accentGreen,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // ── Identity Protocol Section Header ──────────────────────
            Row(
              children: [
                Icon(
                  Icons.fingerprint_rounded,
                  color: AppColors.accentCyan,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  'IDENTITY PROTOCOL',
                  style: AppTextStyles.sectionTitle.copyWith(letterSpacing: 3),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // ── Neural Link Card ──────────────────────────────────────
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accentCyan.withValues(alpha: 0.15),
                        ),
                        child: const Icon(
                          Icons.wifi_rounded,
                          color: AppColors.accentCyan,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'NEURAL LINK',
                              style: AppTextStyles.cardTitle.copyWith(
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Account synchronization required',
                              style: AppTextStyles.bodyText.copyWith(
                                fontSize: 12,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // UID Text Field
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bgDarkest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.borderCyan.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                      decoration: InputDecoration(
                        hintText: '# ENTER GAMING UID',
                        hintStyle: TextStyle(
                          color: AppColors.textMuted.withValues(alpha: 0.6),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.tag_rounded,
                          color: AppColors.accentCyan.withValues(alpha: 0.5),
                          size: 20,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Info text
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: AppColors.textMuted.withValues(alpha: 0.5),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'UID is required to sync emote assets directly into your game vault.',
                          style: AppTextStyles.bodyText.copyWith(
                            fontSize: 11,
                            color: AppColors.textMuted,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // ── Synchronize Button ────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: NeonButton.purple(
                text: 'SYNCHRONIZE UPLINK',
                icon: Icons.sync_rounded,
                onPressed: () {
                  AdManager.showAdWithCallback(context, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TierSelectionScreen(emote: emote),
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
