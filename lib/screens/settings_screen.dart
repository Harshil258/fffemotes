import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as custom_tabs;
import '../app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/neon_button.dart';
import '../ad_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _hardwareSync = true;
  bool _hapticFeedback = true;
  bool _anonymousLogging = false;
  String _selectedNode = 'NA-WEST // 01';

  final List<String> _nodes = [
    'NA-WEST // 01',
    'EU-CENTRAL // 04',
    'AS-EAST // 12',
    'LATAM-SOUTH // 08',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'SYSTEM CONTROL',
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
                color: AppColors.accentCyan.withValues(alpha: 0.15),
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
            // ── Section: TELEMETRY SYNC ──────────────────────────────────
            Row(
              children: [
                Container(
                  width: 3,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: AppColors.accentCyan,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'VAULT TELEMETRY',
                  style: AppTextStyles.sectionTitle.copyWith(letterSpacing: 2),
                ),
              ],
            ),
            const SizedBox(height: 12),

            GlassCard(
              borderColor: AppColors.borderCyan.withValues(alpha: 0.3),
              child: Column(
                children: [
                  _buildSwitchTile(
                    title: 'NEURAL LINK AUTO-SYNC',
                    subtitle: 'Automatically sync newly unlocked emotes to UID.',
                    value: _hardwareSync,
                    onChanged: (val) => setState(() => _hardwareSync = val),
                    icon: Icons.sync_rounded,
                  ),
                  const Divider(color: AppColors.bgMedium, height: 24),
                  _buildSwitchTile(
                    title: 'HAPTIC FEEDBACK',
                    subtitle: 'Vibrate on successful decryption steps.',
                    value: _hapticFeedback,
                    onChanged: (val) => setState(() => _hapticFeedback = val),
                    icon: Icons.vibration_rounded,
                  ),
                  const Divider(color: AppColors.bgMedium, height: 24),
                  _buildSwitchTile(
                    title: 'ANONYMOUS TELEMETRY',
                    subtitle: 'Send decrypted packet metadata to core.',
                    value: _anonymousLogging,
                    onChanged: (val) => setState(() => _anonymousLogging = val),
                    icon: Icons.security_rounded,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Section: NETWORK NODE ─────────────────────────────────────
            Row(
              children: [
                Container(
                  width: 3,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: AppColors.accentPurple,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'DATALINK NODE',
                  style: AppTextStyles.sectionTitle.copyWith(letterSpacing: 2),
                ),
              ],
            ),
            const SizedBox(height: 12),

            GlassCard(
              borderColor: AppColors.borderPurple.withValues(alpha: 0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ACTIVE DECRYPTION NODE',
                    style: AppTextStyles.cardTitle.copyWith(
                      fontSize: 13,
                      color: AppColors.accentPurple,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: AppColors.bgDarkest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.borderPurple.withValues(alpha: 0.4),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedNode,
                        dropdownColor: AppColors.bgDark,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.accentPurple,
                        ),
                        isExpanded: true,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                        items: _nodes.map((node) {
                          return DropdownMenuItem(
                            value: node,
                            child: Text(node),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedNode = val);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Section: HARDWARE STATS ──────────────────────────────────
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
                  'CORE DIAGNOSTICS',
                  style: AppTextStyles.sectionTitle.copyWith(letterSpacing: 2),
                ),
              ],
            ),
            const SizedBox(height: 12),

            GlassCard(
              borderColor: AppColors.accentGreen.withValues(alpha: 0.3),
              child: Column(
                children: [
                  _buildStatRow('CYBER DECRYPTOR', 'v5.0.12-PRO'),
                  const Divider(color: AppColors.bgMedium, height: 20),
                  _buildStatRow('NODE PING', '42ms'),
                  const Divider(color: AppColors.bgMedium, height: 20),
                  _buildStatRow('SSL CERTIFICATE', 'VALID'),
                  const Divider(color: AppColors.bgMedium, height: 20),
                  _buildStatRow('INTEGRITY STATUS', 'SECURE'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Section: LEGAL & SECURITY ──────────────────────────────────
            Row(
              children: [
                Container(
                  width: 3,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: AppColors.accentCyan,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'LEGAL & SECURITY',
                  style: AppTextStyles.sectionTitle.copyWith(letterSpacing: 2),
                ),
              ],
            ),
            const SizedBox(height: 12),

            GlassCard(
              borderColor: AppColors.borderCyan.withValues(alpha: 0.3),
              child: _buildActionTile(
                title: 'PRIVACY POLICY',
                subtitle: 'Review privacy policy and data collection rules.',
                icon: Icons.privacy_tip_rounded,
                onTap: () => _launchPrivacyPolicy(context),
              ),
            ),
            const SizedBox(height: 32),

            // ── Action: RESET SYSTEM ──────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: NeonButton(
                text: 'REFRESH UPLINK CONTEXT',
                icon: Icons.refresh_rounded,
                gradientColors: const [AppColors.accentPurple, AppColors.accentCyan],
                onPressed: () {
                  AdManager.showAdWithCallback(context, () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.bgCard,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(
                            color: AppColors.accentCyan,
                            width: 1,
                          ),
                        ),
                        content: const Text(
                          'CONTEXT FLUSHED // CONNECTION ESTABLISHED',
                          style: TextStyle(
                            color: AppColors.accentCyan,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 12,
                          ),
                        ),
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

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.bgDarkest,
            border: Border.all(
              color: AppColors.borderCyan.withValues(alpha: 0.3),
            ),
          ),
          child: Icon(icon, color: AppColors.accentCyan, size: 18),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textMuted,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: AppColors.accentCyan,
          activeTrackColor: AppColors.accentCyan.withValues(alpha: 0.3),
          inactiveThumbColor: AppColors.textMuted,
          inactiveTrackColor: AppColors.bgDarkest,
        ),
      ],
    );
  }

  Widget _buildStatRow(String label, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: AppColors.textSecondary,
            letterSpacing: 1.5,
          ),
        ),
        Text(
          val,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: AppColors.accentGreen,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  void _launchPrivacyPolicy(BuildContext context) async {
    final url = AdManager.privacyPolicyUrl;
    try {
      await custom_tabs.launchUrl(
        Uri.parse(url),
        customTabsOptions: custom_tabs.CustomTabsOptions(
          colorSchemes: custom_tabs.CustomTabsColorSchemes.defaults(
            toolbarColor: AppColors.bgDark,
          ),
          shareState: custom_tabs.CustomTabsShareState.on,
          urlBarHidingEnabled: true,
          showTitle: true,
          closeButton: custom_tabs.CustomTabsCloseButton(
            icon: custom_tabs.CustomTabsCloseButtonIcons.back,
          ),
        ),
        safariVCOptions: custom_tabs.SafariViewControllerOptions(
          preferredBarTintColor: AppColors.bgDark,
          preferredControlTintColor: AppColors.accentCyan,
          barCollapsingEnabled: true,
          dismissButtonStyle: custom_tabs.SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      debugPrint("Could not launch Privacy Policy: $e");
    }
  }

  Widget _buildActionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.bgDarkest,
              border: Border.all(
                color: AppColors.borderCyan.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(icon, color: AppColors.accentCyan, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.accentCyan,
            size: 20,
          ),
        ],
      ),
    );
  }
}
