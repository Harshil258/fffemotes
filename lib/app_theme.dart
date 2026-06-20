import 'package:flutter/material.dart';

// ── Color Palette ──────────────────────────────────────────────────────────
class AppColors {
  AppColors._();

  // Backgrounds
  static const Color bgDarkest = Color(0xFF060A0F);
  static const Color bgDark = Color(0xFF0A0E14);
  static const Color bgMedium = Color(0xFF111820);
  static const Color bgCard = Color(0xFF141C26);
  static const Color bgCardLight = Color(0xFF1A2332);

  // Primary Accent – Neon Cyan/Green
  static const Color accentCyan = Color(0xFF00FFA3);
  static const Color accentTeal = Color(0xFF00D68F);
  static const Color accentGreen = Color(0xFF00E676);

  // Secondary Accents
  static const Color accentPink = Color(0xFFFF4081);
  static const Color accentPurple = Color(0xFF7C4DFF);
  static const Color accentGold = Color(0xFFFFD740);
  static const Color accentOrange = Color(0xFFFF9100);
  static const Color accentBlue = Color(0xFF448AFF);
  static const Color accentRed = Color(0xFFFF5252);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0BEC5);
  static const Color textMuted = Color(0xFF607D8B);

  // Borders / Glow
  static const Color borderCyan = Color(0x5500FFA3);
  static const Color borderPink = Color(0x55FF4081);
  static const Color borderGold = Color(0x55FFD740);
  static const Color borderPurple = Color(0x557C4DFF);

  // Card gradient backgrounds
  static const Color cardTealStart = Color(0xFF0D3B30);
  static const Color cardTealEnd = Color(0xFF0A2620);
  static const Color cardPinkStart = Color(0xFF3B0D20);
  static const Color cardPinkEnd = Color(0xFF260A18);
  static const Color cardGoldStart = Color(0xFF3B350D);
  static const Color cardGoldEnd = Color(0xFF26220A);
  static const Color cardBlueStart = Color(0xFF0D1F3B);
  static const Color cardBlueEnd = Color(0xFF0A1526);
  static const Color cardPurpleStart = Color(0xFF1F0D3B);
  static const Color cardPurpleEnd = Color(0xFF150A26);
}

// ── Card Color Themes (rotating for variety) ──────────────────────────────
class CardColorTheme {
  final Color bgStart;
  final Color bgEnd;
  final Color border;
  final Color accent;

  const CardColorTheme({
    required this.bgStart,
    required this.bgEnd,
    required this.border,
    required this.accent,
  });

  static const teal = CardColorTheme(
    bgStart: AppColors.cardTealStart,
    bgEnd: AppColors.cardTealEnd,
    border: AppColors.borderCyan,
    accent: AppColors.accentCyan,
  );

  static const pink = CardColorTheme(
    bgStart: AppColors.cardPinkStart,
    bgEnd: AppColors.cardPinkEnd,
    border: AppColors.borderPink,
    accent: AppColors.accentPink,
  );

  static const gold = CardColorTheme(
    bgStart: AppColors.cardGoldStart,
    bgEnd: AppColors.cardGoldEnd,
    border: AppColors.borderGold,
    accent: AppColors.accentGold,
  );

  static const blue = CardColorTheme(
    bgStart: AppColors.cardBlueStart,
    bgEnd: AppColors.cardBlueEnd,
    border: AppColors.borderPurple,
    accent: AppColors.accentBlue,
  );

  static const purple = CardColorTheme(
    bgStart: AppColors.cardPurpleStart,
    bgEnd: AppColors.cardPurpleEnd,
    border: AppColors.borderPurple,
    accent: AppColors.accentPurple,
  );

  static const List<CardColorTheme> all = [teal, pink, gold, blue, purple];

  static CardColorTheme forIndex(int index) => all[index % all.length];
}

// ── Text Styles ────────────────────────────────────────────────────────────
class AppTextStyles {
  AppTextStyles._();

  static const TextStyle heroTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    color: AppColors.accentCyan,
    letterSpacing: 4,
    height: 1.1,
  );

  static const TextStyle screenTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: 3,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 2.5,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: 1,
  );

  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.accentCyan,
    letterSpacing: 2,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static const TextStyle label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.textMuted,
    letterSpacing: 2,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    letterSpacing: 2,
  );

  static const TextStyle statValue = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static const TextStyle statLabel = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.textMuted,
    letterSpacing: 1.5,
  );
}

// ── Glassmorphism Decoration ───────────────────────────────────────────────
class GlassDecoration {
  GlassDecoration._();

  static BoxDecoration card({
    Color borderColor = AppColors.borderCyan,
    double borderRadius = 16,
    Color bgColor = const Color(0xCC111820),
  }) {
    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: borderColor, width: 1),
    );
  }

  static BoxDecoration gradientCard({
    required Color startColor,
    required Color endColor,
    Color borderColor = AppColors.borderCyan,
    double borderRadius = 16,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [startColor, endColor],
      ),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: borderColor, width: 1),
    );
  }
}

// ── App Theme ──────────────────────────────────────────────────────────────
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bgDark,
      primaryColor: AppColors.accentCyan,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentCyan,
        secondary: AppColors.accentPurple,
        surface: AppColors.bgMedium,
        error: AppColors.accentRed,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: 3,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.accentCyan),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: AppColors.textPrimary),
        bodyLarge: TextStyle(color: AppColors.textSecondary),
        bodyMedium: TextStyle(color: AppColors.textSecondary),
      ),
    );
  }
}
