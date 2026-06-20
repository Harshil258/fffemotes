import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import '../ad_manager.dart';
import '../widgets/emote_grid_card.dart';
import 'emote_detail_screen.dart';

class EmoteCategoryScreen extends StatelessWidget {
  final EmoteCategory category;

  const EmoteCategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Center(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
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
        centerTitle: true,
        title: Text(
          category.name,
          style: AppTextStyles.sectionTitle.copyWith(
            fontSize: 14,
            letterSpacing: 2.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // ── Section header with item count ──
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
                        color: AppColors.accentCyan.withValues(alpha: 0.4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'ASSET LIBRARY',
                  style: AppTextStyles.sectionTitle,
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.accentCyan.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.accentCyan.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    '${category.emotes.length} ITEMS',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.accentCyan,
                      fontSize: 10,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── 2-column Grid ──
            Expanded(
              child: GridView.builder(
                itemCount: category.emotes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.82,
                ),
                itemBuilder: (context, i) {
                  final emote = category.emotes[i];
                  return EmoteGridCard(
                    emote: emote,
                    colorTheme: CardColorTheme.forIndex(i),
                    onTap: () {
                      AdManager.showAdWithCallback(context, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EmoteDetailScreen(emote: emote),
                          ),
                        );
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
