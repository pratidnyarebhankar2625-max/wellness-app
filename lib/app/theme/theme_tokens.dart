import 'package:flutter/material.dart';

/// Semantic color tokens provided via ThemeData extension.
/// These tokens ensure all screens, widgets, charts, and states derive
/// styling from the active theme without any hardcoded values.
@immutable
class AppColorTokens extends ThemeExtension<AppColorTokens> {
  // Surfaces & Backgrounds
  final Color background;
  final Color surface;
  final Color surfaceCard;
  final Color surfaceHighlight;
  final Color surfaceGlass;

  // Primary palette
  final Color primary;
  final Color primaryDark;
  final Color primaryLight;
  final Color primaryContainer;

  // Accent & Alert palette
  final Color accent;
  final Color accentDark;
  final Color accentLight;
  final Color accentContainer;

  // Typography colors
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;

  // Borders, dividers & shadows
  final Color border;
  final Color borderLight;
  final Color divider;
  final Color shadowColor;
  final Color glowColor;

  // Semantic component states
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color disabled;
  final Color completed;

  // Charting & Analytics palette
  final List<Color> chartPalette;

  // Gradients
  final Gradient gradientBackground;
  final Gradient gradientPrimary;
  final Gradient gradientCard;

  const AppColorTokens({
    required this.background,
    required this.surface,
    required this.surfaceCard,
    required this.surfaceHighlight,
    required this.surfaceGlass,
    required this.primary,
    required this.primaryDark,
    required this.primaryLight,
    required this.primaryContainer,
    required this.accent,
    required this.accentDark,
    required this.accentLight,
    required this.accentContainer,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.border,
    required this.borderLight,
    required this.divider,
    required this.shadowColor,
    required this.glowColor,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.disabled,
    required this.completed,
    required this.chartPalette,
    required this.gradientBackground,
    required this.gradientPrimary,
    required this.gradientCard,
  });

  @override
  AppColorTokens copyWith({
    Color? background,
    Color? surface,
    Color? surfaceCard,
    Color? surfaceHighlight,
    Color? surfaceGlass,
    Color? primary,
    Color? primaryDark,
    Color? primaryLight,
    Color? primaryContainer,
    Color? accent,
    Color? accentDark,
    Color? accentLight,
    Color? accentContainer,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? border,
    Color? borderLight,
    Color? divider,
    Color? shadowColor,
    Color? glowColor,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? disabled,
    Color? completed,
    List<Color>? chartPalette,
    Gradient? gradientBackground,
    Gradient? gradientPrimary,
    Gradient? gradientCard,
  }) {
    return AppColorTokens(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceCard: surfaceCard ?? this.surfaceCard,
      surfaceHighlight: surfaceHighlight ?? this.surfaceHighlight,
      surfaceGlass: surfaceGlass ?? this.surfaceGlass,
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      primaryLight: primaryLight ?? this.primaryLight,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      accent: accent ?? this.accent,
      accentDark: accentDark ?? this.accentDark,
      accentLight: accentLight ?? this.accentLight,
      accentContainer: accentContainer ?? this.accentContainer,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      border: border ?? this.border,
      borderLight: borderLight ?? this.borderLight,
      divider: divider ?? this.divider,
      shadowColor: shadowColor ?? this.shadowColor,
      glowColor: glowColor ?? this.glowColor,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      disabled: disabled ?? this.disabled,
      completed: completed ?? this.completed,
      chartPalette: chartPalette ?? this.chartPalette,
      gradientBackground: gradientBackground ?? this.gradientBackground,
      gradientPrimary: gradientPrimary ?? this.gradientPrimary,
      gradientCard: gradientCard ?? this.gradientCard,
    );
  }

  @override
  AppColorTokens lerp(ThemeExtension<AppColorTokens>? other, double t) {
    if (other is! AppColorTokens) return this;
    return AppColorTokens(
      background: Color.lerp(background, other.background, t) ?? background,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      surfaceCard: Color.lerp(surfaceCard, other.surfaceCard, t) ?? surfaceCard,
      surfaceHighlight: Color.lerp(surfaceHighlight, other.surfaceHighlight, t) ?? surfaceHighlight,
      surfaceGlass: Color.lerp(surfaceGlass, other.surfaceGlass, t) ?? surfaceGlass,
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t) ?? primaryDark,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t) ?? primaryLight,
      primaryContainer: Color.lerp(primaryContainer, other.primaryContainer, t) ?? primaryContainer,
      accent: Color.lerp(accent, other.accent, t) ?? accent,
      accentDark: Color.lerp(accentDark, other.accentDark, t) ?? accentDark,
      accentLight: Color.lerp(accentLight, other.accentLight, t) ?? accentLight,
      accentContainer: Color.lerp(accentContainer, other.accentContainer, t) ?? accentContainer,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
      textMuted: Color.lerp(textMuted, other.textMuted, t) ?? textMuted,
      border: Color.lerp(border, other.border, t) ?? border,
      borderLight: Color.lerp(borderLight, other.borderLight, t) ?? borderLight,
      divider: Color.lerp(divider, other.divider, t) ?? divider,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t) ?? shadowColor,
      glowColor: Color.lerp(glowColor, other.glowColor, t) ?? glowColor,
      success: Color.lerp(success, other.success, t) ?? success,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      error: Color.lerp(error, other.error, t) ?? error,
      info: Color.lerp(info, other.info, t) ?? info,
      disabled: Color.lerp(disabled, other.disabled, t) ?? disabled,
      completed: Color.lerp(completed, other.completed, t) ?? completed,
      chartPalette: [
        for (int i = 0; i < chartPalette.length; i++)
          Color.lerp(chartPalette[i], other.chartPalette[i % other.chartPalette.length], t) ?? chartPalette[i],
      ],
      gradientBackground: Gradient.lerp(gradientBackground, other.gradientBackground, t) ?? gradientBackground,
      gradientPrimary: Gradient.lerp(gradientPrimary, other.gradientPrimary, t) ?? gradientPrimary,
      gradientCard: Gradient.lerp(gradientCard, other.gradientCard, t) ?? gradientCard,
    );
  }
}

/// Convenience extension on BuildContext for quick access to theme tokens and text.
extension BuildContextThemeExtension on BuildContext {
  AppColorTokens get colors =>
      Theme.of(this).extension<AppColorTokens>() ??
      const AppColorTokens(
        background: Color(0xFFFFF0F2),
        surface: Colors.white,
        surfaceCard: Color(0xFFFFF7F8),
        surfaceHighlight: Color(0xFFF3FAF0),
        surfaceGlass: Color(0xD9FFFFFF),
        primary: Color(0xFFA3B899),
        primaryDark: Color(0xFF7E9774),
        primaryLight: Color(0xFFD6E3CF),
        primaryContainer: Color(0xFFE8EFE5),
        accent: Color(0xFFDE9B9B),
        accentDark: Color(0xFFC77D7D),
        accentLight: Color(0xFFF9E4E4),
        accentContainer: Color(0xFFFCECEC),
        textPrimary: Color(0xFF2C3E35),
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
          colors: [Color(0xFFFFF0F2), Color(0xFFFBE4E7)],
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

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
}
