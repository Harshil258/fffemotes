import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import '../widgets/glass_card.dart';
import '../widgets/neon_button.dart';
import 'tool_server_screen.dart';
import '../ad_manager.dart';

class ToolVerificationScreen extends StatelessWidget {
  final ToolItem tool;

  const ToolVerificationScreen({super.key, required this.tool});

  @override
  Widget build(BuildContext context) {
    final accentColor = tool.rarity.color;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'VAULT VERIFICATION',
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
                color: accentColor.withValues(alpha: 0.15),
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
                  // Glowing rounded-rect tool container
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: accentColor.withValues(alpha: 0.6),
                        width: 1.5,
                      ),
                      color: AppColors.bgMedium,
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withValues(alpha: 0.15),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: accentColor.withValues(alpha: 0.08),
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          tool.imagePath,
                          fit: BoxFit.contain,
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
                          'SKIN PACK READY',
                          style: AppTextStyles.label.copyWith(
                            color: accentColor,
                            letterSpacing: 3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          tool.name,
                          style: AppTextStyles.cardTitle.copyWith(fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Waiting for target UID injection',
                          style: AppTextStyles.bodyText.copyWith(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Status check
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
                  Icons.vpn_lock_rounded,
                  color: accentColor,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  'LINK PARAMETERS',
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
                          color: accentColor.withValues(alpha: 0.15),
                        ),
                        child: Icon(
                          Icons.radar_rounded,
                          color: accentColor,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CORE TERMINAL LINK',
                              style: AppTextStyles.cardTitle.copyWith(
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Account synchronizing protocol',
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
                        color: accentColor.withValues(alpha: 0.4),
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
                          color: accentColor.withValues(alpha: 0.5),
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
                          'Your gaming UID is required to locate your player profile data and map the custom weapon/companion textures.',
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
                text: 'LINK SERVER REGION',
                icon: Icons.public_rounded,
                onPressed: () {
                  AdManager.showAdWithCallback(context, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ToolServerScreen(tool: tool),
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
