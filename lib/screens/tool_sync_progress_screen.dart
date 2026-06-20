import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import '../widgets/glass_card.dart';
import 'tool_collection_screen.dart';

class ToolSyncProgressScreen extends StatefulWidget {
  final ToolItem tool;
  final String serverName;

  const ToolSyncProgressScreen({
    super.key,
    required this.tool,
    required this.serverName,
  });

  @override
  State<ToolSyncProgressScreen> createState() => _ToolSyncProgressScreenState();
}

class _ToolSyncProgressScreenState extends State<ToolSyncProgressScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  String _currentLog = 'INITIATING HANDSHAKE PROTOCOL...';

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    _progressController.addListener(() {
      final value = _progressAnimation.value;
      setState(() {
        if (value < 0.25) {
          _currentLog = 'CONNECTING TO ${widget.serverName.toUpperCase()}...';
        } else if (value < 0.50) {
          _currentLog = 'BYPASSING SECURITY SHIELDS...';
        } else if (value < 0.75) {
          _currentLog = 'INJECTING LEVEL ${widget.tool.evoLevels.length} SHADER PAYLOAD...';
        } else if (value < 0.95) {
          _currentLog = 'RESOLVING DATABASE SYNC KEYS...';
        } else {
          _currentLog = 'SYNCHRONIZATION COMPLETED SUCCESSFULLY.';
        }
      });
    });

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Automatically proceed to the Tool Collection Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ToolCollectionScreen(tool: widget.tool),
          ),
        );
      }
    });

    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = widget.tool.rarity.color;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, _) {
            final percent = (_progressAnimation.value * 100).toInt();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  // Circular Progress Indicator with image in center
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 170,
                          height: 170,
                          child: CircularProgressIndicator(
                            value: _progressAnimation.value,
                            strokeWidth: 4,
                            backgroundColor: AppColors.bgDarkest,
                            valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accentColor.withValues(alpha: 0.05),
                            boxShadow: [
                              BoxShadow(
                                color: accentColor.withValues(alpha: 0.15),
                                blurRadius: 40,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              widget.tool.imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Percentage Text
                  Text(
                    '$percent%',
                    style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.w900,
                      color: accentColor,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Title
                  Text(
                    'TRANSMITTING ASSET CONFIGS',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.textPrimary,
                      letterSpacing: 2.5,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Dynamic log card
                  GlassCard(
                    borderColor: AppColors.borderCyan.withValues(alpha: 0.3),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 12,
                                height: 12,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentCyan),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'CONNECTION STATUS: ACTIVE',
                                style: AppTextStyles.label.copyWith(
                                  color: AppColors.accentCyan,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            _currentLog,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontFamily: 'monospace',
                              fontSize: 11,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Subtext
                  Text(
                    'DO NOT CLOSE THE APPLICATION OR DISCONNECT PROTOCOL.',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted.withValues(alpha: 0.5),
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
