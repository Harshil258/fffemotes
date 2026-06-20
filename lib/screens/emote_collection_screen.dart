import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import 'emote_preview_screen.dart';
import '../ad_manager.dart';

class EmoteCollectionScreen extends StatefulWidget {
  final LeagueItem league;
  final EmoteItem emote;

  const EmoteCollectionScreen({
    super.key,
    required this.league,
    required this.emote,
  });

  @override
  State<EmoteCollectionScreen> createState() => _EmoteCollectionScreenState();
}

class _EmoteCollectionScreenState extends State<EmoteCollectionScreen> {
  int _selectedChip = 0;

  static const _chipLabels = ['All', 'Unlocked', 'Locked', 'Favorites'];

  /// Flatten all emotes from every category.
  List<EmoteItem> get _allEmotes {
    return AppData.categories.expand((c) => c.emotes).toList();
  }

  bool _isLocked(int index) => index % 3 == 2;

  List<EmoteItem> get _filteredEmotes {
    final all = _allEmotes;
    switch (_selectedChip) {
      case 1: // Unlocked
        return [
          for (int i = 0; i < all.length; i++)
            if (!_isLocked(i)) all[i],
        ];
      case 2: // Locked
        return [
          for (int i = 0; i < all.length; i++)
            if (_isLocked(i)) all[i],
        ];
      case 3: // Favorites (simulate first 6)
        return all.take(6).toList();
      default:
        return all;
    }
  }

  @override
  Widget build(BuildContext context) {
    final emotes = _filteredEmotes;
    final totalCount = _allEmotes.length;

    return Scaffold(
      backgroundColor: AppColors.bgDarkest,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8),
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
        title: Text(
          '${widget.league.name} DIVISION',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: widget.league.color,
            letterSpacing: 3,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          // ── Section header ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                const Text('EMOTE ARSENAL', style: AppTextStyles.sectionTitle),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accentCyan.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$totalCount ITEMS',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accentCyan,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Filter chips ────────────────────────────────────────────
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemCount: _chipLabels.length,
              itemBuilder: (context, index) {
                final selected = _selectedChip == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedChip = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.accentCyan.withValues(alpha: 0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selected
                            ? AppColors.accentCyan.withValues(alpha: 0.6)
                            : AppColors.textMuted.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      _chipLabels[index],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: selected
                            ? AppColors.accentCyan
                            : AppColors.textMuted,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // ── Emote grid ──────────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.78,
                ),
                itemCount: emotes.length,
                itemBuilder: (context, index) {
                  final emoteItem = emotes[index];
                  // Determine original index for lock state
                  final originalIndex = _allEmotes.indexOf(emoteItem);
                  final locked = _isLocked(originalIndex);

                  return _CollectionTile(
                    emote: emoteItem,
                    isLocked: locked,
                    onTap: locked
                        ? null
                        : () {
                            AdManager.showAdWithCallback(context, () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      EmotePreviewScreen(emote: emoteItem),
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
    );
  }
}

// ── Small collection tile ───────────────────────────────────────────────────
class _CollectionTile extends StatelessWidget {
  final EmoteItem emote;
  final bool isLocked;
  final VoidCallback? onTap;

  const _CollectionTile({
    required this.emote,
    required this.isLocked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isLocked
                ? AppColors.textMuted.withValues(alpha: 0.2)
                : AppColors.borderCyan.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Character Image
              Positioned.fill(
                bottom: 36,
                child: Image.asset(
                  emote.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.bgMedium,
                    child: Icon(
                      emote.icon,
                      size: 18,
                      color: isLocked ? AppColors.textMuted : AppColors.accentCyan,
                    ),
                  ),
                ),
              ),
              // Gradient Overlay
              Positioned.fill(
                bottom: 36,
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
              // Locked Overlay
              if (isLocked)
                Positioned.fill(
                  bottom: 36,
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.6),
                    child: const Center(
                      child: Icon(
                        Icons.lock_rounded,
                        color: AppColors.textMuted,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              // Name & Status
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 36,
                child: Container(
                  color: AppColors.bgCard,
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        emote.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 7.5,
                          fontWeight: FontWeight.w800,
                          color: isLocked ? AppColors.textMuted : AppColors.textPrimary,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isLocked ? AppColors.textMuted : AppColors.accentCyan,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            isLocked ? 'LOCKED' : 'OPEN',
                            style: TextStyle(
                              fontSize: 6.5,
                              fontWeight: FontWeight.w700,
                              color: isLocked ? AppColors.textMuted : AppColors.accentCyan,
                              letterSpacing: 0.5,
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
