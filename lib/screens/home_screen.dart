import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import '../ad_manager.dart';
import '../widgets/status_badge.dart';
import '../widgets/category_card.dart';
import '../widgets/glass_card.dart';
import 'emote_category_screen.dart';
import 'tool_category_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeVaultIndex = 0; // 0 for Emotes, 1 for Tools

  @override
  Widget build(BuildContext context) {
    final isEmotes = _activeVaultIndex == 0;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 68,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: (isEmotes ? AppColors.borderCyan : AppColors.borderPink).withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(4),
            child: Image.asset(
              'assets/images/ff_asset_1.webp',
              fit: BoxFit.contain,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                AdManager.showAdWithCallback(context, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SettingsScreen(),
                    ),
                  );
                });
              },
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.bgCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.borderCyan,
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.settings_rounded,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // ── Status Badge ──
            StatusBadge(text: isEmotes ? 'SYSTEM ONLINE' : 'ARSENAL LINK SECURED'),

            const SizedBox(height: 24),

            // ── Hero Title ──
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: isEmotes ? 'EMOTE\n' : 'TACTICAL\n',
                    style: AppTextStyles.heroTitle.copyWith(
                      fontSize: 42,
                      color: isEmotes ? AppColors.accentCyan : AppColors.accentPink,
                    ),
                  ),
                  TextSpan(
                    text: isEmotes ? 'VAULT' : 'TOOLS',
                    style: AppTextStyles.heroTitle.copyWith(
                      fontSize: 42,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Subtitle ──
            Text(
              isEmotes
                  ? 'Access premium emote collections & rare dance moves.'
                  : 'Sync official weapons, evo skins, and tactical companions.',
              style: AppTextStyles.bodyText.copyWith(
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 24),

            // ── Vault Selector (Neon Segmented Control) ──
            Container(
              height: 52,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.bgDarkest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.textMuted.withValues(alpha: 0.15),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _activeVaultIndex = 0;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: isEmotes
                              ? LinearGradient(
                                  colors: [
                                    AppColors.accentCyan.withValues(alpha: 0.25),
                                    AppColors.accentGreen.withValues(alpha: 0.1),
                                  ],
                                )
                              : null,
                          border: isEmotes
                              ? Border.all(
                                  color: AppColors.accentCyan.withValues(alpha: 0.5),
                                  width: 1,
                                )
                              : null,
                          boxShadow: isEmotes
                              ? [
                                  BoxShadow(
                                    color: AppColors.accentCyan.withValues(alpha: 0.12),
                                    blurRadius: 10,
                                  ),
                                ]
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'EMOTE VAULT',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                            color: isEmotes ? AppColors.accentCyan : AppColors.textMuted,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _activeVaultIndex = 1;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: !isEmotes
                              ? LinearGradient(
                                  colors: [
                                    AppColors.accentPink.withValues(alpha: 0.25),
                                    AppColors.accentPurple.withValues(alpha: 0.1),
                                  ],
                                )
                              : null,
                          border: !isEmotes
                              ? Border.all(
                                  color: AppColors.accentPink.withValues(alpha: 0.5),
                                  width: 1,
                                )
                              : null,
                          boxShadow: !isEmotes
                              ? [
                                  BoxShadow(
                                    color: AppColors.accentPink.withValues(alpha: 0.12),
                                    blurRadius: 10,
                                  ),
                                ]
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'TACTICAL TOOLS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                            color: !isEmotes ? AppColors.accentPink : AppColors.textMuted,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Live Event Banner ──
            GlassCard(
              borderColor: (isEmotes ? AppColors.borderCyan : AppColors.borderPink).withValues(alpha: 0.3),
              padding: EdgeInsets.zero,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          'assets/images/ff_asset_3.webp',
                          width: double.infinity,
                          height: 125,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.accentPink.withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'LIVE EVENT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isEmotes ? 'BOOYAH SHARDS INBOUND' : 'EVO INJECTORS ARMED',
                            style: TextStyle(
                              color: isEmotes ? AppColors.accentCyan : AppColors.accentPink,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            isEmotes
                                ? 'Special limited-time event payload detected. Stabilize neural link and sync elite emotes now.'
                                : 'High-priority weapon payload link detected. Initialize bypassing to sync premium skins directly.',
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
            ),

            const SizedBox(height: 32),

            // ── Section Header ──
            Row(
              children: [
                Container(
                  width: 3,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isEmotes ? AppColors.accentCyan : AppColors.accentPink,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: (isEmotes ? AppColors.accentCyan : AppColors.accentPink).withValues(alpha: 0.4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  isEmotes ? 'TRENDING CATEGORIES' : 'TACTICAL ARSENAL',
                  style: AppTextStyles.sectionTitle,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── Category Cards ──
            if (isEmotes)
              ...List.generate(AppData.categories.length, (i) {
                final category = AppData.categories[i];
                return CategoryCard(
                  title: category.name,
                  subtitle: category.subtitle,
                  icon: category.icon,
                  colorTheme: CardColorTheme.forIndex(i),
                  onTap: () {
                    AdManager.showAdWithCallback(context, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EmoteCategoryScreen(category: category),
                        ),
                      );
                    });
                  },
                );
              })
            else
              ...List.generate(AppData.toolCategories.length, (i) {
                final category = AppData.toolCategories[i];
                // Alternate pink/purple for tools theme
                final cardTheme = i == 0
                    ? CardColorTheme(
                        bgStart: const Color(0xFF2E0C20),
                        bgEnd: const Color(0xFF190615),
                        border: AppColors.borderPink.withValues(alpha: 0.5),
                        accent: AppColors.accentPink,
                      )
                    : CardColorTheme(
                        bgStart: const Color(0xFF1E0C2E),
                        bgEnd: const Color(0xFF0F0619),
                        border: AppColors.borderPurple.withValues(alpha: 0.5),
                        accent: AppColors.accentPurple,
                      );
                return CategoryCard(
                  title: category.name,
                  subtitle: category.subtitle,
                  icon: category.icon,
                  colorTheme: cardTheme,
                  onTap: () {
                    AdManager.showAdWithCallback(context, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ToolCategoryScreen(category: category),
                        ),
                      );
                    });
                  },
                );
              }),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
