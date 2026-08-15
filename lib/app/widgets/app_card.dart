import 'package:flutter/material.dart';
import '../theme/theme_tokens.dart';

/// Standard rounded card component adhering to the active global theme.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Color? borderColor;
  final double borderRadius;
  final bool hasGlow;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.margin = const EdgeInsets.only(bottom: 14),
    this.onTap,
    this.backgroundColor,
    this.gradient,
    this.borderColor,
    this.borderRadius = 20,
    this.hasGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final decoration = BoxDecoration(
      color: backgroundColor ?? (gradient == null ? colors.surfaceCard : null),
      gradient: gradient,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? colors.border,
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: colors.shadowColor,
          blurRadius: 16,
          offset: const Offset(0, 6),
          spreadRadius: -2,
        ),
        if (hasGlow)
          BoxShadow(
            color: colors.glowColor,
            blurRadius: 20,
            spreadRadius: 2,
          ),
      ],
    );

    Widget content = Container(
      padding: padding,
      decoration: decoration,
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: colors.primary.withValues(alpha: 0.1),
          highlightColor: colors.primary.withValues(alpha: 0.05),
          child: content,
        ),
      );
    }

    return Padding(
      padding: margin,
      child: content,
    );
  }
}
