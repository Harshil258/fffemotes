import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import '../widgets/glass_card.dart';
import '../widgets/neon_button.dart';
import 'handshake_complete_screen.dart';
import '../ad_manager.dart';

class EmotePreviewScreen extends StatefulWidget {
  final EmoteItem emote;

  const EmotePreviewScreen({super.key, required this.emote});

  @override
  State<EmotePreviewScreen> createState() => _EmotePreviewScreenState();
}

class _EmotePreviewScreenState extends State<EmotePreviewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  /// Gather related emotes (different from current one).
  List<EmoteItem> get _relatedEmotes {
    final all = AppData.categories.expand((c) => c.emotes).toList();
    return all.where((e) => e.id != widget.emote.id).take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    final emote = widget.emote;

    return Scaffold(
      backgroundColor: AppColors.bgDarkest,
      body: SafeArea(
        child: Column(
          children: [
            // ── Back button ───────────────────────────────────────────
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
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
            ),

            // ── Scrollable content ────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 8),

                    // ── Pulsing rings + icon ──────────────────────────
                    SizedBox(
                      height: 220,
                      child: AnimatedBuilder(
                        animation: _pulseAnim,
                        builder: (context, _) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              // Ring 3 (outermost)
                              Transform.scale(
                                scale: _pulseAnim.value * 1.15,
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.accentCyan
                                          .withValues(alpha: 0.08),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                              // Ring 2
                              Transform.scale(
                                scale: _pulseAnim.value * 1.05,
                                child: Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.accentCyan
                                          .withValues(alpha: 0.15),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                              // Ring 1 (innermost)
                              Transform.scale(
                                scale: _pulseAnim.value,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.accentCyan
                                        .withValues(alpha: 0.06),
                                    border: Border.all(
                                      color: AppColors.accentCyan
                                          .withValues(alpha: 0.25),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                              // Emote character image
                              ClipOval(
                                child: Image.asset(
                                  emote.imagePath,
                                  width: 110,
                                  height: 110,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Icon(
                                    emote.icon,
                                    size: 64,
                                    color: AppColors.accentCyan,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Move type label ───────────────────────────────
                    Text(
                      emote.moveType.label,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accentCyan,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // ── Emote name ────────────────────────────────────
                    Text(
                      emote.name,
                      style: AppTextStyles.screenTitle.copyWith(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),

                    // ── Move Breakdown header ─────────────────────────
                    Row(
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
                          'MOVE BREAKDOWN',
                          style: AppTextStyles.sectionTitle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // ── Choreography steps ────────────────────────────
                    ...List.generate(emote.choreography.length, (i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GlassCard(
                          borderColor:
                              AppColors.accentCyan.withValues(alpha: 0.2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.accentCyan
                                      .withValues(alpha: 0.15),
                                  border: Border.all(
                                    color: AppColors.accentCyan
                                        .withValues(alpha: 0.4),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${i + 1}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.accentCyan,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  emote.choreography[i],
                                  style: AppTextStyles.bodyText.copyWith(
                                    color: AppColors.textPrimary,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 24),

                    // ── Related Emotes header ─────────────────────────
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 22,
                          decoration: BoxDecoration(
                            color: AppColors.accentPurple,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'RELATED EMOTES',
                          style: AppTextStyles.sectionTitle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // ── Related emotes horizontal list ────────────────
                    SizedBox(
                      height: 110,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemCount: _relatedEmotes.length,
                        itemBuilder: (context, index) {
                          final related = _relatedEmotes[index];
                          return _RelatedEmoteCard(emote: related);
                        },
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ── Complete button ───────────────────────────────
                    NeonButton(
                      text: 'COMPLETE HANDSHAKE',
                      icon: Icons.check_circle_rounded,
                      onPressed: () {
                        AdManager.showAdWithCallback(context, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  HandshakeCompleteScreen(emote: emote),
                            ),
                          );
                        });
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Related emote small card ────────────────────────────────────────────────
class _RelatedEmoteCard extends StatelessWidget {
  final EmoteItem emote;

  const _RelatedEmoteCard({required this.emote});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.borderPurple,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.accentPurple.withValues(alpha: 0.1),
              border: Border.all(
                color: AppColors.borderPurple.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.asset(
                emote.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  emote.icon,
                  size: 24,
                  color: AppColors.accentPurple,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              emote.name,
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
