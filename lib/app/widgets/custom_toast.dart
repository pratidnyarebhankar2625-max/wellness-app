import 'package:flutter/material.dart';
import '../theme/theme_tokens.dart';

/// Helper to show floating, elegant toast notifications adhering to active theme.
class CustomToast {
  static void show(
    BuildContext context, {
    required String message,
    String? emoji,
    Duration duration = const Duration(milliseconds: 2500),
  }) {
    final colors = context.colors;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: colors.surface.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(color: colors.border, width: 1),
            boxShadow: [
              BoxShadow(
                color: colors.shadowColor,
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: colors.glowColor,
                blurRadius: 12,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (emoji != null) ...[
                Text(emoji, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  message,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
