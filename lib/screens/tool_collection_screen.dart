import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import '../ad_manager.dart';
import 'tool_preview_screen.dart';

class ToolCollectionScreen extends StatefulWidget {
  final ToolItem tool; // The tool we just synchronized

  const ToolCollectionScreen({super.key, required this.tool});

  @override
  State<ToolCollectionScreen> createState() => _ToolCollectionScreenState();
}

class _ToolCollectionScreenState extends State<ToolCollectionScreen> {
  int _activeTab = 0; // 0: All, 1: Weapons, 2: Companions

  // Gather weapons and pets lists
  List<ToolItem> get _weapons => AppData.toolCategories[0].tools;
  List<ToolItem> get _pets => AppData.toolCategories[1].tools;

  List<ToolItem> get _allItems => [..._weapons, ..._pets];

  // Lock status helper: lock index 2, 5, 8
  bool _isLocked(ToolItem item) {
    // If it's the one we just synced, it's definitely unlocked
    if (item.id == widget.tool.id) return false;
    final index = _allItems.indexWhere((x) => x.id == item.id);
    return index % 3 == 2;
  }

  List<ToolItem> get _filteredItems {
    switch (_activeTab) {
      case 1:
        return _weapons;
      case 2:
        return _pets;
      default:
        return _allItems;
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredItems;

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
                color: AppColors.accentPink.withValues(alpha: 0.15),
                border: Border.all(
                  color: AppColors.accentPink.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.accentPink,
                size: 20,
              ),
            ),
          ),
        ),
        title: const Text(
          'ARMORY ARCHIVE',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: 3,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          // ── Section header ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.accentPink,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('TACTICAL Blueprints', style: AppTextStyles.sectionTitle),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accentPink.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${_allItems.length} ITEMS',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accentPink,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Filter tabs ──
          Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildTabButton('ALL', 0),
                const SizedBox(width: 10),
                _buildTabButton('WEAPONS', 1),
                const SizedBox(width: 10),
                _buildTabButton('COMPANIONS', 2),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Grid list ──
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.76,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final locked = _isLocked(item);

                  return GestureDetector(
                    onTap: locked
                        ? null
                        : () {
                            AdManager.showAdWithCallback(context, () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ToolPreviewScreen(tool: item),
                                ),
                              );
                            });
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.bgCard,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: locked
                              ? AppColors.textMuted.withValues(alpha: 0.2)
                              : AppColors.borderPink.withValues(alpha: 0.6),
                          width: 1.2,
                        ),
                        boxShadow: locked
                            ? null
                            : [
                                BoxShadow(
                                  color: AppColors.accentPink.withValues(alpha: 0.08),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            // 1. Image container with radial/linear gradient background
                            Positioned.fill(
                              bottom: 40,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.accentPink.withValues(alpha: locked ? 0.02 : 0.1),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                  child: Image.asset(
                                    item.imagePath,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) => Icon(
                                      Icons.construction_rounded,
                                      size: 24,
                                      color: locked ? AppColors.textMuted : AppColors.accentPink,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // 2. Lock overlay
                            if (locked)
                              Positioned.fill(
                                bottom: 40,
                                child: Container(
                                  color: Colors.black.withValues(alpha: 0.55),
                                  child: const Center(
                                    child: Icon(
                                      Icons.lock_rounded,
                                      color: AppColors.textMuted,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            // 3. Name and Status footer
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              height: 40,
                              child: Container(
                                color: AppColors.bgCard,
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      item.name.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w800,
                                        color: locked ? AppColors.textMuted : AppColors.textPrimary,
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
                                            color: locked ? AppColors.textMuted : AppColors.accentPink,
                                          ),
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          locked ? 'LOCKED' : 'SYNCED',
                                          style: TextStyle(
                                            fontSize: 7,
                                            fontWeight: FontWeight.w700,
                                            color: locked ? AppColors.textMuted : AppColors.accentPink,
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
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final selected = _activeTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentPink.withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? AppColors.accentPink.withValues(alpha: 0.6)
                : AppColors.textMuted.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: selected ? AppColors.accentPink : AppColors.textMuted,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
