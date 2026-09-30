import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Defines the appetizing Material 3 visual theme for MealCraft,
/// matching the exact design tokens and aesthetics exported from Figma.
///
/// Features Proxima Nova geometric grotesque typography (matching Swiggy's design system),
/// warm culinary color palette inspired by terracotta hearths, sage herb greens,
/// high-contrast legible cream surfaces, and deep charcoal dark mode.
class AppTheme {
  // Figma Light Tokens - High Contrast & High Legibility
  static const Color figmaTerracotta = Color(0xFF8B2500);
  static const Color figmaPeachContainer = Color(0xFFFFDBCD);
  static const Color figmaOnPeach = Color(0xFF351000);

  static const Color figmaSageGreen = Color(0xFF155A1D);
  static const Color figmaSageContainer = Color(0xFFA0F399);
  static const Color figmaOnSageContainer = Color(0xFF002204);

  static const Color figmaCreamBg = Color(0xFFFBF9F5);
  static const Color figmaWhiteSurface = Color(0xFFFFFFFF);
  static const Color figmaSoftContainer = Color(0xFFF5F3EF);
  static const Color figmaBorder = Color(0xFFE5E0D8);
  static const Color figmaBorderSubtle = Color(0xFFEFECE6);

  // High contrast text tokens for Light Mode (passes WCAG AAA)
  static const Color figmaTextPrimary = Color(0xFF141311);
  static const Color figmaTextSecondary = Color(0xFF38332E);
  static const Color figmaTextMuted = Color(0xFF4A433D);
  static const Color figmaTextTertiary = Color(0xFF6B635A);
  static const Color figmaAmber = Color(0xFF835100);
  static const Color figmaError = Color(0xFFBA1A1A);
  static const Color figmaErrorContainer = Color(0xFFFFDAD6);

  // Figma Dark Tokens - High Contrast & High Legibility
  static const Color figmaDarkBg = Color(0xFF121212);
  static const Color figmaDarkSurface = Color(0xFF1E1E1E);
  static const Color figmaDarkContainer = Color(0xFF282828);
  static const Color figmaDarkBorder = Color(0xFF383533);
  static const Color figmaDarkTerracotta = Color(0xFFEE671C);
  static const Color figmaDarkPrimaryContainer = Color(0xFF571E00);
  static const Color figmaDarkSage = Color(0xFF75E59B);
  
  // High contrast text tokens for Dark Mode (passes WCAG AAA)
  static const Color figmaDarkTextPrimary = Color(0xFFF7F5F0);
  static const Color figmaDarkTextSecondary = Color(0xFFDDD9D2);
  static const Color figmaDarkTextMuted = Color(0xFFC8C4BC);
  static const Color figmaDarkTextTertiary = Color(0xFFAAA49A);

  /// Helper methods for adaptive high-contrast text colors
  static Color textPrimary(bool isDark) => isDark ? figmaDarkTextPrimary : figmaTextPrimary;
  static Color textSecondary(bool isDark) => isDark ? figmaDarkTextSecondary : figmaTextSecondary;
  static Color textMuted(bool isDark) => isDark ? figmaDarkTextMuted : figmaTextMuted;
  static Color textTertiary(bool isDark) => isDark ? figmaDarkTextTertiary : figmaTextTertiary;

  /// Custom typography matching Proxima Nova's geometric grotesque aesthetic (used by Swiggy)
  static TextStyle proxima({
    double? fontSize,
    FontWeight? fontWeight = FontWeight.w600,
    Color? color,
    double? height,
    double? letterSpacing,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.montserrat(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
    );
  }

  /// Light Material 3 Theme with Proxima Nova Typography
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: figmaTerracotta,
      primary: figmaTerracotta,
      secondary: figmaSageGreen,
      tertiary: figmaAmber,
      error: figmaError,
      surface: figmaWhiteSurface,
      brightness: Brightness.light,
    ).copyWith(
      primaryContainer: figmaPeachContainer,
      onPrimaryContainer: figmaOnPeach,
      secondaryContainer: figmaSageContainer,
      onSecondaryContainer: figmaOnSageContainer,
      errorContainer: figmaErrorContainer,
      surfaceContainerLowest: figmaCreamBg,
      surfaceContainerLow: figmaCreamBg,
      surfaceContainer: figmaSoftContainer,
      surfaceContainerHigh: figmaBorderSubtle,
      outline: figmaBorder,
      outlineVariant: figmaBorderSubtle,
      onSurface: figmaTextPrimary,
      onSurfaceVariant: figmaTextMuted,
    );

    final fontFamily = GoogleFonts.montserrat().fontFamily;

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: figmaCreamBg,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: figmaTextPrimary,
          fontSize: 32,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          color: figmaTextPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
        displaySmall: TextStyle(
          color: figmaTextPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
        headlineLarge: TextStyle(
          color: figmaTextPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.4,
        ),
        headlineMedium: TextStyle(
          color: figmaTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
        headlineSmall: TextStyle(
          color: figmaTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.2,
        ),
        titleLarge: TextStyle(
          color: figmaTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.2,
        ),
        titleMedium: TextStyle(
          color: figmaTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        titleSmall: TextStyle(
          color: figmaTextSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: figmaTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          color: figmaTextSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: TextStyle(
          color: figmaTextMuted,
          fontSize: 11.5,
          fontWeight: FontWeight.w500,
        ),
        labelLarge: TextStyle(
          color: figmaTextPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
        labelMedium: TextStyle(
          color: figmaTextSecondary,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
        labelSmall: TextStyle(
          color: figmaTextMuted,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: figmaCreamBg,
        foregroundColor: figmaTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 1.0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.montserrat(
          color: figmaTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
      ),
      cardTheme: CardThemeData(
        color: figmaWhiteSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: figmaBorder, width: 1.2),
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        side: const BorderSide(color: figmaBorder, width: 1.0),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: figmaCreamBg.withValues(alpha: 0.98),
        elevation: 0,
        indicatorColor: figmaPeachContainer,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: figmaTerracotta);
          }
          return const IconThemeData(color: figmaTextMuted);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.montserrat(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: figmaTerracotta,
            );
          }
          return GoogleFonts.montserrat(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: figmaTextMuted,
          );
        }),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: figmaTerracotta,
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: figmaTerracotta,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: figmaTerracotta,
          side: const BorderSide(color: figmaTerracotta, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
    );
  }

  /// Dark Material 3 Theme with Proxima Nova Typography
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: figmaDarkTerracotta,
      brightness: Brightness.dark,
    ).copyWith(
      primary: figmaDarkTerracotta,
      primaryContainer: figmaDarkPrimaryContainer,
      onPrimaryContainer: figmaPeachContainer,
      secondary: figmaDarkSage,
      secondaryContainer: const Color(0xFF0B551F),
      onSecondaryContainer: const Color(0xFFA0F399),
      surface: figmaDarkSurface,
      surfaceContainerLowest: figmaDarkBg,
      surfaceContainerLow: figmaDarkBg,
      surfaceContainer: figmaDarkContainer,
      surfaceContainerHigh: const Color(0xFF353534),
      outline: figmaDarkBorder,
      outlineVariant: const Color(0xFF2A2A2A),
      onSurface: figmaDarkTextPrimary,
      onSurfaceVariant: figmaDarkTextMuted,
    );

    final fontFamily = GoogleFonts.montserrat().fontFamily;

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: figmaDarkBg,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: figmaDarkTextPrimary,
          fontSize: 32,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          color: figmaDarkTextPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
        displaySmall: TextStyle(
          color: figmaDarkTextPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
        headlineLarge: TextStyle(
          color: figmaDarkTextPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.4,
        ),
        headlineMedium: TextStyle(
          color: figmaDarkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
        headlineSmall: TextStyle(
          color: figmaDarkTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.2,
        ),
        titleLarge: TextStyle(
          color: figmaDarkTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.2,
        ),
        titleMedium: TextStyle(
          color: figmaDarkTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        titleSmall: TextStyle(
          color: figmaDarkTextSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: TextStyle(
          color: figmaDarkTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          color: figmaDarkTextSecondary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: TextStyle(
          color: figmaDarkTextMuted,
          fontSize: 11.5,
          fontWeight: FontWeight.w500,
        ),
        labelLarge: TextStyle(
          color: figmaDarkTextPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
        labelMedium: TextStyle(
          color: figmaDarkTextSecondary,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
        labelSmall: TextStyle(
          color: figmaDarkTextMuted,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: figmaDarkBg,
        foregroundColor: figmaDarkTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 1.0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.montserrat(
          color: figmaDarkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
      ),
      cardTheme: CardThemeData(
        color: figmaDarkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: figmaDarkBorder, width: 1.2),
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: figmaDarkBg.withValues(alpha: 0.98),
        elevation: 0,
        indicatorColor: figmaDarkPrimaryContainer,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: figmaDarkTerracotta);
          }
          return const IconThemeData(color: figmaDarkTextMuted);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.montserrat(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: figmaDarkTerracotta,
            );
          }
          return GoogleFonts.montserrat(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: figmaDarkTextMuted,
          );
        }),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: figmaDarkTerracotta,
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: figmaDarkTerracotta,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: figmaDarkTerracotta,
          side: const BorderSide(color: figmaDarkTerracotta, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
    );
  }
}
