import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import '../widgets/glass_card.dart';
import '../widgets/neon_button.dart';
import '../widgets/protocol_step.dart';
import 'tool_verification_screen.dart';
import '../ad_manager.dart';

class ToolProtocolScreen extends StatelessWidget {
  final ToolItem tool;

  const ToolProtocolScreen({super.key, required this.tool});

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
          'INJECTION PORT',
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
            // ── Top Section: scanline effect, status, radar ──────────
            GlassCard(
              borderColor: accentColor.withValues(alpha: 0.3),
              padding: EdgeInsets.zero,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        accentColor.withValues(alpha: 0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Scanline overlay simulation
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _ScanlinePainter(color: accentColor),
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
                                      'DATA PACKET GENERATED',
                                      style: TextStyle(
                                        color: AppColors.accentCyan,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      tool.name,
                                      style: AppTextStyles.cardTitle.copyWith(
                                        fontSize: 16,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: accentColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: accentColor,
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
                                        color: accentColor.withValues(alpha: 0.15),
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
                                        color: accentColor.withValues(alpha: 0.25),
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
                                        color: accentColor.withValues(alpha: 0.45),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  // Radar Sweep design dots
                                  Positioned(
                                    top: 38,
                                    left: 52,
                                    child: _RadarDot(color: accentColor),
                                  ),
                                  Positioned(
                                    bottom: 42,
                                    right: 38,
                                    child: _RadarDot(color: accentColor),
                                  ),
                                  // Center Image of Weapon
                                  Container(
                                    width: 66,
                                    height: 66,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.bgMedium,
                                      border: Border.all(
                                        color: accentColor.withValues(alpha: 0.6),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: ClipOval(
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
                        '96%',
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
                    'COMPILING DATA INJECTORS',
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    child: LinearProgressIndicator(
                      value: 0.96,
                      minHeight: 6,
                      backgroundColor: AppColors.bgMedium,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentCyan),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Bypassing server security protocols, mapping weapon skins structures, generating virtual encryption code.',
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
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'LINK PROTOCOLS',
                  style: AppTextStyles.sectionTitle.copyWith(letterSpacing: 2),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Protocol Steps ───────────────────────────────────────
            const ProtocolStep(
              label: 'DECRYPT MODEL SHELL',
              timing: '96ms',
              completed: true,
            ),
            const ProtocolStep(
              label: 'INJECT SHADER PACKS',
              timing: '150ms',
              completed: true,
            ),
            const ProtocolStep(
              label: 'BYPASS GAME SHIELD',
              timing: '320ms',
              completed: true,
            ),
            const ProtocolStep(
              label: 'FINAL CODES GENERATION',
              timing: 'WAITING',
              loading: true,
            ),
            const SizedBox(height: 24),

            // ── Ready to Execute Card & Button ───────────────────────
            GlassCard(
              borderColor: accentColor.withValues(alpha: 0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.flash_on_rounded,
                          color: accentColor,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'UPLINK CONFIGURATION SET',
                        style: AppTextStyles.cardTitle.copyWith(
                          fontSize: 13,
                          color: accentColor,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Weapon database connected. Access keys resolved. Ready to initiate synchronization code.',
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
                text: 'INITIALIZE INJECTION',
                icon: Icons.vpn_key_rounded,
                gradientColors: [accentColor, AppColors.accentPurple],
                onPressed: () {
                  AdManager.showAdWithCallback(context, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ToolVerificationScreen(tool: tool),
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
  final Color color;
  _ScanlinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.03)
      ..strokeWidth = 1;

    for (double y = 0; y < size.height; y += 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
