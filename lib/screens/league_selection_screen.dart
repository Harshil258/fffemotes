import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import 'emote_collection_screen.dart';
import '../ad_manager.dart';

class LeagueSelectionScreen extends StatelessWidget {
  final EmoteItem emote;

  const LeagueSelectionScreen({super.key, required this.emote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDarkest,
      body: Stack(
        children: [
          // ── Gradient background ──────────────────────────────────────
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.accentCyan.withValues(alpha: 0.06),
                    AppColors.bgDarkest,
                    AppColors.bgDarkest,
                  ],
                ),
              ),
            ),
          ),

          // ── Large faded silhouette ──────────────────────────────────
          Positioned(
            top: -40,
            right: -40,
            child: Icon(
              Icons.person_rounded,
              size: 260,
              color: AppColors.textPrimary.withValues(alpha: 0.03),
            ),
          ),

          // ── Content ─────────────────────────────────────────────────
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 44,
                      height: 44,
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
                        size: 22,
                      ),
                    ),
                  ),
                ),

                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'LEAGUE\nSELECTION',
                    style: AppTextStyles.heroTitle.copyWith(
                      fontSize: 28,
                      height: 1.15,
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // ── Target Division header ────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppColors.accentCyan,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'TARGET DIVISION',
                        style: AppTextStyles.sectionTitle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // ── League Grid ───────────────────────────────────────
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: AppData.leagues.length,
                      itemBuilder: (context, index) {
                        final league = AppData.leagues[index];
                        return _LeagueBadgeTile(
                          league: league,
                          onTap: () {
                            AdManager.showAdWithCallback(context, () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EmoteCollectionScreen(
                                    league: league,
                                    emote: emote,
                                  ),
                                ),
                              );
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Single league badge tile ────────────────────────────────────────────────
class _LeagueBadgeTile extends StatelessWidget {
  final LeagueItem league;
  final VoidCallback onTap;

  const _LeagueBadgeTile({required this.league, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [league.bgStart, league.bgEnd],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: league.color.withValues(alpha: 0.25),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),

            // League icon
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: league.color.withValues(alpha: 0.08),
              ),
              child: Icon(
                league.icon,
                size: 48,
                color: league.color,
              ),
            ),
            const SizedBox(height: 10),

            // League name
            Text(
              league.name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: league.color,
                letterSpacing: 2,
              ),
            ),

            const Spacer(),

            // SELECT button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: league.color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: league.color.withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    'SELECT',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: league.color,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}
