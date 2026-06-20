import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../app_data.dart';
import '../widgets/glass_card.dart';
import 'tool_sync_progress_screen.dart';
import '../ad_manager.dart';

class ToolServerScreen extends StatelessWidget {
  final ToolItem tool;

  const ToolServerScreen({super.key, required this.tool});

  static const _servers = [
    {'name': 'NORTH AMERICA (US-EAST)', 'ping': '45ms', 'status': 'ONLINE'},
    {'name': 'INDIA & SOUTH ASIA', 'ping': '62ms', 'status': 'ONLINE'},
    {'name': 'EUROPE CENTRAL', 'ping': '85ms', 'status': 'STABLE'},
    {'name': 'LATIN AMERICA / BRAZIL', 'ping': '112ms', 'status': 'HIGH LOAD'},
    {'name': 'SOUTHEAST ASIA (SG-1)', 'ping': '50ms', 'status': 'ONLINE'},
  ];

  @override
  Widget build(BuildContext context) {
    final accentColor = tool.rarity.color;

    return Scaffold(
      backgroundColor: AppColors.bgDarkest,
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
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
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'SERVER GATEWAY',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                itemCount: _servers.length,
                itemBuilder: (context, index) {
                  final server = _servers[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () {
                        AdManager.showAdWithCallback(context, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ToolSyncProgressScreen(
                                tool: tool,
                                serverName: server['name']!,
                              ),
                            ),
                          );
                        });
                      },
                      child: GlassCard(
                        borderColor: AppColors.borderCyan.withValues(alpha: 0.25),
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.accentCyan.withValues(alpha: 0.1),
                                border: Border.all(
                                  color: AppColors.accentCyan.withValues(alpha: 0.3),
                                ),
                              ),
                              child: const Icon(
                                Icons.dns_rounded,
                                color: AppColors.accentCyan,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    server['name']!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textPrimary,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        'LATENCY: ',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textMuted.withValues(alpha: 0.7),
                                        ),
                                      ),
                                      Text(
                                        server['ping']!,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.accentGreen,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Status tag
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: server['status'] == 'ONLINE'
                                    ? AppColors.accentGreen.withValues(alpha: 0.15)
                                    : AppColors.accentGold.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                server['status']!,
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w900,
                                  color: server['status'] == 'ONLINE'
                                      ? AppColors.accentGreen
                                      : AppColors.accentGold,
                                  letterSpacing: 0.5,
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
          ],
        ),
      ),
    );
  }
}
