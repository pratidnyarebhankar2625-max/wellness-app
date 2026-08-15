import 'package:flutter/material.dart';
import '../theme/theme_tokens.dart';

enum AppButtonVariant { primary, secondary, accent, ghost, danger }

/// Theme-aware button supporting different variants, loading state, and icons.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final Widget? icon;
  final bool isLoading;
  final bool isFullWidth;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
    this.borderRadius = 9999,
  });

  const AppButton.primary({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
    this.borderRadius = 9999,
  }) : variant = AppButtonVariant.primary;

  const AppButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.borderRadius = 9999,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.accent({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
    this.borderRadius = 9999,
  }) : variant = AppButtonVariant.accent;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    Color bg;
    Color fg;
    BorderSide borderSide = BorderSide.none;
    List<BoxShadow> shadows = [];

    switch (variant) {
      case AppButtonVariant.primary:
        bg = colors.primary;
        fg = colors.textPrimary == const Color(0xFF2C3E35)
            ? const Color(0xFF1E2923)
            : (colors.textPrimary == const Color(0xFF3B224E) ? Colors.white : const Color(0xFF222B22));
        shadows = [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ];
        break;
      case AppButtonVariant.secondary:
        bg = colors.surface;
        fg = colors.textPrimary;
        borderSide = BorderSide(color: colors.border, width: 1.2);
        shadows = [
          BoxShadow(
            color: colors.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ];
        break;
      case AppButtonVariant.accent:
        bg = colors.accent;
        fg = colors.textPrimary;
        shadows = [
          BoxShadow(
            color: colors.accent.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ];
        break;
      case AppButtonVariant.ghost:
        bg = Colors.transparent;
        fg = colors.textSecondary;
        break;
      case AppButtonVariant.danger:
        bg = colors.error.withValues(alpha: 0.15);
        fg = colors.error;
        borderSide = BorderSide(color: colors.error.withValues(alpha: 0.3), width: 1);
        break;
    }

    if (onPressed == null) {
      bg = colors.disabled.withValues(alpha: 0.4);
      fg = colors.textMuted;
      shadows = [];
    }

    Widget content = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(fg),
            ),
          ),
          const SizedBox(width: 8),
        ] else if (icon != null) ...[
          icon!,
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: TextStyle(
            color: fg,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: shadows,
      ),
      child: Material(
        color: bg,
        shape: RoundedRectangleBorder(
          side: borderSide,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: content,
          ),
        ),
      ),
    );
  }
}
