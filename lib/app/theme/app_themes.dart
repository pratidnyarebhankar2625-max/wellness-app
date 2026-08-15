import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';
import 'theme_tokens.dart';

/// Centralized factory to construct ThemeData and AppColorTokens for every AppTheme.
class AppThemes {
  AppThemes._();

  /// Builds a complete ThemeData instance for the specified [theme].
  static ThemeData getThemeData(AppTheme theme) {
    switch (theme) {
      case AppTheme.matchaRosewater:
        return _buildMatchaRosewaterTheme();
      case AppTheme.pistachioGold:
        return _buildPistachioGoldTheme();
      case AppTheme.lavenderCottonCandy:
        return _buildLavenderCottonCandyTheme();
    }
  }

  /// Returns the color tokens for a given [theme] without needing a BuildContext.
  static AppColorTokens getTokens(AppTheme theme) {
    switch (theme) {
      case AppTheme.matchaRosewater:
        return _matchaTokens;
      case AppTheme.pistachioGold:
        return _pistachioTokens;
      case AppTheme.lavenderCottonCandy:
        return _lavenderTokens;
    }
  }

  // ===========================================================================
  // 1. MATCHA & ROSEWATER THEME DEFINITION
  // ===========================================================================
  static const AppColorTokens _matchaTokens = AppColorTokens(
    background: Color(0xFFFFF0F2), // Pale Rosewater Pink
    surface: Color(0xFFFFFFFF),
    surfaceCard: Color(0xFFFFF7F8),
    surfaceHighlight: Color(0xFFF3FAF0),
    surfaceGlass: Color(0xD9FFFFFF),
    primary: Color(0xFFA3B899), // Soft Matcha Green
    primaryDark: Color(0xFF7E9774),
    primaryLight: Color(0xFFD6E3CF),
    primaryContainer: Color(0xFFE8EFE5),
    accent: Color(0xFFDE9B9B), // Dusty Strawberry
    accentDark: Color(0xFFC77D7D),
    accentLight: Color(0xFFF9E4E4),
    accentContainer: Color(0xFFFCECEC),
    textPrimary: Color(0xFF2C3E35), // Deep Forest Ink
    textSecondary: Color(0xFF53685E),
    textMuted: Color(0xFF7F9589),
    border: Color(0xFFE8D5D8),
    borderLight: Color(0xFFF4EAEB),
    divider: Color(0x1F2C3E35),
    shadowColor: Color(0x1EA3B899),
    glowColor: Color(0x2AA3B899),
    success: Color(0xFF8FA885),
    warning: Color(0xFFE2A875),
    error: Color(0xFFDE9B9B),
    info: Color(0xFFA3B899),
    disabled: Color(0xFFC7CFCB),
    completed: Color(0xFFA3B899),
    chartPalette: [
      Color(0xFFA3B899),
      Color(0xFFDE9B9B),
      Color(0xFFC0D5B7),
      Color(0xFFEAB8B8),
      Color(0xFF6F8965),
    ],
    gradientBackground: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFFF0F2), Color(0xFFFDE6E9)],
    ),
    gradientPrimary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFA3B899), Color(0xFF8CA581)],
    ),
    gradientCard: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.white, Color(0xFFFFF7F8)],
    ),
  );

  static ThemeData _buildMatchaRosewaterTheme() {
    final tokens = _matchaTokens;
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: tokens.primary,
      onPrimary: Colors.white,
      primaryContainer: tokens.primaryContainer,
      onPrimaryContainer: tokens.textPrimary,
      secondary: tokens.accent,
      onSecondary: Colors.white,
      secondaryContainer: tokens.accentContainer,
      onSecondaryContainer: tokens.textPrimary,
      error: tokens.error,
      onError: Colors.white,
      surface: tokens.surface,
      onSurface: tokens.textPrimary,
      outline: tokens.border,
      outlineVariant: tokens.borderLight,
      shadow: tokens.shadowColor,
    );

    return _buildThemeDataFromTokens(tokens, colorScheme);
  }

  // ===========================================================================
  // 2. PISTACHIO & GOLD DUST THEME DEFINITION
  // ===========================================================================
  static const AppColorTokens _pistachioTokens = AppColorTokens(
    background: Color(0xFFFAF7F0), // Warm Vanilla Cream
    surface: Color(0xFFFFFFFF),
    surfaceCard: Color(0xFFFDFBF7),
    surfaceHighlight: Color(0xFFF0F7EF),
    surfaceGlass: Color(0xD9FFFFFF),
    primary: Color(0xFFCCE2CB), // Pastel Pistachio Green
    primaryDark: Color(0xFF8EBF8C),
    primaryLight: Color(0xFFE5F1E4),
    primaryContainer: Color(0xFFE9F3E8),
    accent: Color(0xFFFFD1B3), // Golden Hour Peach
    accentDark: Color(0xFFF2A478),
    accentLight: Color(0xFFFFEBDC),
    accentContainer: Color(0xFFFFF3EB),
    textPrimary: Color(0xFF3B443B), // Sage Charcoal
    textSecondary: Color(0xFF5A665A),
    textMuted: Color(0xFF859485),
    border: Color(0xFFEAE4D5),
    borderLight: Color(0xFFF2ECE0),
    divider: Color(0x1F3B443B),
    shadowColor: Color(0x1F8EB58C),
    glowColor: Color(0x2ACCE2CB),
    success: Color(0xFF8EBF8C),
    warning: Color(0xFFF2A478),
    error: Color(0xFFE58F8F),
    info: Color(0xFF98C7BA),
    disabled: Color(0xFFD2D8D2),
    completed: Color(0xFF8EBF8C),
    chartPalette: [
      Color(0xFF8DBF8B),
      Color(0xFFFFB787),
      Color(0xFFB5D7B3),
      Color(0xFFFFD1B3),
      Color(0xFF5E7A5E),
    ],
    gradientBackground: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFFAF7F0), Color(0xFFF3ECE0)],
    ),
    gradientPrimary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFCCE2CB), Color(0xFFB3D8B1)],
    ),
    gradientCard: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.white, Color(0xFFFDFBF7)],
    ),
  );

  static ThemeData _buildPistachioGoldTheme() {
    final tokens = _pistachioTokens;
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: tokens.primaryDark,
      onPrimary: Colors.white,
      primaryContainer: tokens.primaryContainer,
      onPrimaryContainer: tokens.textPrimary,
      secondary: tokens.accentDark,
      onSecondary: Colors.white,
      secondaryContainer: tokens.accentContainer,
      onSecondaryContainer: tokens.textPrimary,
      error: tokens.error,
      onError: Colors.white,
      surface: tokens.surface,
      onSurface: tokens.textPrimary,
      outline: tokens.border,
      outlineVariant: tokens.borderLight,
      shadow: tokens.shadowColor,
    );

    return _buildThemeDataFromTokens(tokens, colorScheme);
  }

  // ===========================================================================
  // 3. LAVENDER COTTON CANDY THEME DEFINITION
  // ===========================================================================
  static const AppColorTokens _lavenderTokens = AppColorTokens(
    background: Color(0xFFF3E8FF), // Soft Lilac Cloud
    surface: Color(0xFFFFFFFF),
    surfaceCard: Color(0xFFFAF5FF),
    surfaceHighlight: Color(0xFFF5EEFD),
    surfaceGlass: Color(0xD9FFFFFF),
    primary: Color(0xFFD8B4FE), // Sweet Lavender
    primaryDark: Color(0xFFA855F7),
    primaryLight: Color(0xFFF0E5FD),
    primaryContainer: Color(0xFFF3E8FF),
    accent: Color(0xFFFBCFE8), // Bubblegum Blush
    accentDark: Color(0xFFF472B6),
    accentLight: Color(0xFFFDE8F3),
    accentContainer: Color(0xFFFDF2F8),
    textPrimary: Color(0xFF3B224E), // Midnight Plum
    textSecondary: Color(0xFF65477E),
    textMuted: Color(0xFF967FA9),
    border: Color(0xFFE5D5F7),
    borderLight: Color(0xFFEFE4FB),
    divider: Color(0x1F3B224E),
    shadowColor: Color(0x22A855F7),
    glowColor: Color(0x33D8B4FE),
    success: Color(0xFFA855F7),
    warning: Color(0xFFF59E0B),
    error: Color(0xFFF43F5E),
    info: Color(0xFF818CF8),
    disabled: Color(0xFFD5CADF),
    completed: Color(0xFFA855F7),
    chartPalette: [
      Color(0xFFA855F7),
      Color(0xFFF472B6),
      Color(0xFFD8B4FE),
      Color(0xFFFBCFE8),
      Color(0xFF7C3AED),
    ],
    gradientBackground: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFF3E8FF), Color(0xFFE9D5FF)],
    ),
    gradientPrimary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFD8B4FE), Color(0xFFC084FC)],
    ),
    gradientCard: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.white, Color(0xFFFAF5FF)],
    ),
  );

  static ThemeData _buildLavenderCottonCandyTheme() {
    final tokens = _lavenderTokens;
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: tokens.primaryDark,
      onPrimary: Colors.white,
      primaryContainer: tokens.primaryContainer,
      onPrimaryContainer: tokens.textPrimary,
      secondary: tokens.accentDark,
      onSecondary: Colors.white,
      secondaryContainer: tokens.accentContainer,
      onSecondaryContainer: tokens.textPrimary,
      error: tokens.error,
      onError: Colors.white,
      surface: tokens.surface,
      onSurface: tokens.textPrimary,
      outline: tokens.border,
      outlineVariant: tokens.borderLight,
      shadow: tokens.shadowColor,
    );

    return _buildThemeDataFromTokens(tokens, colorScheme);
  }

  // ===========================================================================
  // COMMON THEMEDATA BUILDER
  // ===========================================================================
  static ThemeData _buildThemeDataFromTokens(
    AppColorTokens tokens,
    ColorScheme colorScheme,
  ) {
    // Elegant Typography with GoogleFonts (Outfit for headers, Inter for body)
    final textTheme = TextTheme(
      displayLarge: GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: tokens.textPrimary,
        letterSpacing: -0.5,
      ),
      displayMedium: GoogleFonts.outfit(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: tokens.textPrimary,
        letterSpacing: -0.5,
      ),
      displaySmall: GoogleFonts.outfit(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: tokens.textPrimary,
      ),
      headlineLarge: GoogleFonts.outfit(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: tokens.textPrimary,
      ),
      headlineMedium: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: tokens.textPrimary,
      ),
      headlineSmall: GoogleFonts.outfit(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: tokens.textPrimary,
      ),
      titleLarge: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: tokens.textPrimary,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: tokens.textPrimary,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: tokens.textSecondary,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: tokens.textPrimary,
        height: 1.45,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 13.5,
        fontWeight: FontWeight.w400,
        color: tokens.textSecondary,
        height: 1.4,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: tokens.textMuted,
        height: 1.35,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 13.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10.5,
        fontWeight: FontWeight.w500,
        color: tokens.textMuted,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: tokens.background,
      textTheme: textTheme,
      extensions: [tokens],

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: tokens.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: tokens.textPrimary,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: tokens.textPrimary),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: tokens.surfaceCard,
        elevation: 0,
        shadowColor: tokens.shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: tokens.border, width: 1),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: tokens.primary,
          foregroundColor: tokens.textPrimary == const Color(0xFF2C3E35)
              ? const Color(0xFF1E2923)
              : Colors.white,
          elevation: 0,
          shadowColor: tokens.shadowColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: tokens.textPrimary,
          side: BorderSide(color: tokens.border, width: 1.2),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: tokens.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: tokens.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: tokens.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: tokens.primary, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: tokens.error, width: 1),
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 13.5,
          color: tokens.textMuted,
        ),
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return tokens.disabled;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return tokens.primary;
          }
          return tokens.border;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return tokens.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        side: BorderSide(color: tokens.border, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),

      // Navigation Bar / Bottom Navigation Theme
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: tokens.surfaceGlass,
        elevation: 0,
        indicatorColor: tokens.primaryContainer,
        height: 72,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: tokens.textPrimary,
            );
          }
          return GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: tokens.textMuted,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              color: tokens.textPrimary,
              size: 22,
            );
          }
          return IconThemeData(
            color: tokens.textMuted,
            size: 22,
          );
        }),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: tokens.surface,
        elevation: 12,
        shadowColor: tokens.shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: tokens.border, width: 1),
        ),
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: tokens.textPrimary,
        ),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: tokens.surface,
        elevation: 16,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        modalBackgroundColor: tokens.surface,
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: tokens.borderLight,
        thickness: 1,
        space: 24,
      ),
    );
  }
}
