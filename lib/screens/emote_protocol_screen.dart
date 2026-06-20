import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import '../ad_manager.dart';
import '../widgets/glass_card.dart';
import '../widgets/neon_button.dart';
import '../widgets/protocol_step.dart';
import 'verification_screen.dart';

class EmoteProtocolScreen extends StatelessWidget {
  final EmoteItem emote;

  const EmoteProtocolScreen({super.key, required this.emote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'PROTOCOL TERMINAL',
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
                color: AppColors.accentGreen.withValues(alpha: 0.15),
                border: Border.all(
                  color: AppColors.accentGreen.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.accentGreen,
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
            // ── Top Section: scanline effect, status, radar ──────────
            GlassCard(
              borderColor: AppColors.accentGreen.withValues(alpha: 0.3),
              padding: EdgeInsets.zero,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.accentGreen.withValues(alpha: 0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Scanline overlay simulation
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _ScanlinePainter(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'UPLINK STABLE',
                                      style: TextStyle(
                                        color: AppColors.accentCyan,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      emote.name.toUpperCase(),
                                      style: AppTextStyles.cardTitle.copyWith(
                                        fontSize: 18,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: AppColors.accentGreen,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.accentGreen,
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            // Circular Radar Visualisation
                            SizedBox(
                              height: 180,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Concentric Circle 3 (outermost)
                                  Container(
                                    width: 170,
                                    height: 170,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.accentGreen.withValues(alpha: 0.15),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  // Concentric Circle 2
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.accentGreen.withValues(alpha: 0.25),
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                  // Concentric Circle 1 (innermost)
                                  Container(
                                    width: 76,
                                    height: 76,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.accentGreen.withValues(alpha: 0.45),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  // Radar Sweep line (visual design dot)
                                  Positioned(
                                    top: 38,
                                    left: 52,
                                    child: _RadarDot(color: AppColors.accentGreen),
                                  ),
                                  Positioned(
                                    bottom: 42,
                                    right: 38,
                                    child: _RadarDot(color: AppColors.accentGreen),
                                  ),
                                  Positioned(
                                    top: 85,
                                    right: 32,
                                    child: _RadarDot(color: AppColors.accentGreen),
                                  ),
                                  // Center Icon
                                  Container(
                                    width: 66,
                                    height: 66,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.bgMedium,
                                      border: Border.all(
                                        color: AppColors.accentGreen.withValues(alpha: 0.6),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Container(
                                        color: AppColors.accentGreen.withValues(alpha: 0.08),
                                        padding: const EdgeInsets.all(2),
                                        child: Image.asset(
                                          emote.imagePath,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => Icon(
                                            emote.icon,
                                            color: AppColors.accentGreen,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── Hardware Monitor ─────────────────────────────────────
            GlassCard(
              borderColor: AppColors.borderCyan.withValues(alpha: 0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'HARDWARE MONITOR',
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.accentCyan,
                          letterSpacing: 2,
                        ),
                      ),
                      const Text(
                        '94%',
                        style: TextStyle(
                          color: AppColors.accentCyan,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'DECRYPTING ARCHIVES',
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    child: LinearProgressIndicator(
                      value: 0.94,
                      minHeight: 6,
                      backgroundColor: AppColors.bgMedium,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentCyan),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Accessing high-frequency data shards and reassembling packet sequence...',
                    style: AppTextStyles.bodyText.copyWith(
                      fontSize: 11,
                      color: AppColors.textMuted,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── System Protocols Header ──────────────────────────────
            Row(
              children: [
                Container(
                  width: 3,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: AppColors.accentGreen,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'SYSTEM PROTOCOLS',
                  style: AppTextStyles.sectionTitle.copyWith(letterSpacing: 2),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Protocol Steps ───────────────────────────────────────
            const ProtocolStep(
              label: 'BYPASS FIREWALLS',
              timing: '124ms',
              completed: true,
            ),
            const ProtocolStep(
              label: 'INJECT PAYLOAD',
              timing: '89ms',
              completed: true,
            ),
            const ProtocolStep(
              label: 'ESTABLISH UPLINK',
              timing: '245ms',
              completed: true,
            ),
            const ProtocolStep(
              label: 'FINALIZING SYNC',
              timing: 'WAITING',
              loading: true,
            ),
            const SizedBox(height: 24),

            // ── Ready to Execute Card & Button ───────────────────────
            GlassCard(
              borderColor: AppColors.accentGreen.withValues(alpha: 0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.accentGreen.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.flash_on_rounded,
                          color: AppColors.accentGreen,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'READY TO EXECUTE',
                        style: AppTextStyles.cardTitle.copyWith(
                          fontSize: 15,
                          color: AppColors.accentGreen,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'All security protocols bypassed. High-priority uplink confirmed.',
                    style: AppTextStyles.bodyText.copyWith(
                      fontSize: 12,
                      color: AppColors.textMuted,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: NeonButton(
                text: 'START EXECUTION',
                icon: Icons.power_settings_new_rounded,
                gradientColors: const [AppColors.accentGreen, AppColors.accentCyan],
                onPressed: () {
                  AdManager.showAdWithCallback(context, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerificationScreen(emote: emote),
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

class _RadarDot extends StatelessWidget {
  final Color color;
  const _RadarDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 4,
            spreadRadius: 1,
          )
        ],
      ),
    );
  }
}

class _ScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accentGreen.withValues(alpha: 0.03)
      ..strokeWidth = 1;

    for (double y = 0; y < size.height; y += 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
