import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import '../widgets/glass_card.dart';
import '../widgets/neon_button.dart';
import 'tool_complete_screen.dart';
import '../ad_manager.dart';

class ToolPreviewScreen extends StatefulWidget {
  final ToolItem tool;

  const ToolPreviewScreen({super.key, required this.tool});

  @override
  State<ToolPreviewScreen> createState() => _ToolPreviewScreenState();
}

class _ToolPreviewScreenState extends State<ToolPreviewScreen>
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

  // Gather related tools
  List<ToolItem> get _relatedTools {
    final isWeapon = widget.tool.id.startsWith('t_eg');
    final list = isWeapon
        ? AppData.toolCategories[0].tools
        : AppData.toolCategories[1].tools;
    return list.where((t) => t.id != widget.tool.id).take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tool = widget.tool;
    final accentColor = tool.rarity.color;

    return Scaffold(
      backgroundColor: AppColors.bgDarkest,
      body: SafeArea(
        child: Column(
          children: [
            // Back button
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
                      color: accentColor.withValues(alpha: 0.15),
                      border: Border.all(
                        color: accentColor.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: accentColor,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 8),

                    // Pulsing rings + tool image
                    SizedBox(
                      height: 180,
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
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: accentColor.withValues(alpha: 0.08),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                              // Ring 2
                              Transform.scale(
                                scale: _pulseAnim.value * 1.05,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: accentColor.withValues(alpha: 0.15),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                              // Ring 1 (innermost)
                              Transform.scale(
                                scale: _pulseAnim.value,
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: accentColor.withValues(alpha: 0.06),
                                    border: Border.all(
                                      color: accentColor.withValues(alpha: 0.25),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                              // Tool image
                              Image.asset(
                                tool.imagePath,
                                width: 70,
                                height: 70,
                                fit: BoxFit.contain,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Label
                    Text(
                      tool.rarity.label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: accentColor,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Tool Name
                    Text(
                      tool.name,
                      style: AppTextStyles.screenTitle.copyWith(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),

                    // Stats breakdown header
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 22,
                          decoration: BoxDecoration(
                            color: accentColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'SYNCHRONIZATION PROFILE',
                          style: AppTextStyles.sectionTitle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Render details inside a card
                    GlassCard(
                      borderColor: accentColor.withValues(alpha: 0.3),
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'UPGRADE COMPLETE STATUS',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: AppColors.accentCyan,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Successfully unlocked: ${tool.evoLevels.last}',
                            style: AppTextStyles.bodyText.copyWith(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Related items header
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
                          'RELATED TACTICAL SCHEMATICS',
                          style: AppTextStyles.sectionTitle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Related items horizontal list
                    SizedBox(
                      height: 110,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemCount: _relatedTools.length,
                        itemBuilder: (context, index) {
                          final related = _relatedTools[index];
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Image.asset(
                                        related.imagePath,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  child: Text(
                                    related.name,
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w800,
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
                        },
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Complete Button
                    NeonButton(
                      text: 'EXECUTE HANDSHAKE',
                      icon: Icons.check_circle_rounded,
                      gradientColors: [accentColor, AppColors.accentGreen],
                      onPressed: () {
                        AdManager.showAdWithCallback(context, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ToolCompleteScreen(tool: tool),
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
