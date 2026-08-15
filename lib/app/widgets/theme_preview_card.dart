import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/app_themes.dart';
import '../theme/theme_tokens.dart';

/// Large visual preview card for selecting a theme in Settings -> Appearance.
class ThemePreviewCard extends StatelessWidget {
  final AppTheme theme;
  final bool isSelected;
  final VoidCallback onSelect;

  const ThemePreviewCard({
    super.key,
    required this.theme,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final metadata = AppThemeMetadata.of(theme);
    final targetTokens = AppThemes.getTokens(theme);
    final currentColors = context.colors;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: targetTokens.surfaceCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected ? targetTokens.primaryDark : targetTokens.border,
          width: isSelected ? 2.5 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? targetTokens.primary.withValues(alpha: 0.35)
                : currentColors.shadowColor,
            blurRadius: isSelected ? 22 : 12,
            offset: const Offset(0, 6),
            spreadRadius: isSelected ? 2 : 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onSelect,
          borderRadius: BorderRadius.circular(24),
          splashColor: targetTokens.primary.withValues(alpha: 0.15),
          highlightColor: targetTokens.primary.withValues(alpha: 0.08),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: Name, emoji badge, and Selected Checkmark
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                metadata.emojis.first,
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  metadata.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: targetTokens.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '"${metadata.personality}"',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              color: targetTokens.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Selected Indicator Pill
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? targetTokens.primary
                            : targetTokens.borderLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSelected ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                            size: 16,
                            color: isSelected
                                ? (targetTokens.textPrimary == const Color(0xFF2C3E35)
                                    ? const Color(0xFF1E2923)
                                    : Colors.white)
                                : targetTokens.textMuted,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isSelected ? 'Active' : 'Select',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? (targetTokens.textPrimary == const Color(0xFF2C3E35)
                                      ? const Color(0xFF1E2923)
                                      : Colors.white)
                                  : targetTokens.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Color Swatches Row
                Row(
                  children: [
                    _buildSwatch(targetTokens.background, 'Background'),
                    const SizedBox(width: 8),
                    _buildSwatch(targetTokens.primary, 'Primary'),
                    const SizedBox(width: 8),
                    _buildSwatch(targetTokens.textPrimary, 'Text'),
                    const SizedBox(width: 8),
                    _buildSwatch(targetTokens.accent, 'Accent'),
                  ],
                ),

                const SizedBox(height: 16),

                // Mini Dashboard Preview
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: targetTokens.background,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: targetTokens.borderLight, width: 1),
                  ),
                  child: Column(
                    children: [
                      // Mini App Bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: targetTokens.primary,
                                child: Text(
                                  '✨',
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 50,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: targetTokens.textPrimary,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: targetTokens.accent.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Day 14',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: targetTokens.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Mini cards row
                      Row(
                        children: [
                          // Mini circular ring
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: targetTokens.surface,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: targetTokens.border, width: 0.8),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: targetTokens.primary, width: 3.5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '88',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: targetTokens.textPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Score',
                                    style: TextStyle(
                                      fontSize: 8.5,
                                      fontWeight: FontWeight.w600,
                                      color: targetTokens.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          // Mini routines & button
                          Expanded(
                            flex: 6,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: targetTokens.surface,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.check_circle, size: 12, color: targetTokens.primary),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Container(
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: targetTokens.textSecondary,
                                            borderRadius: BorderRadius.circular(2),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    color: targetTokens.primary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Complete Intentions',
                                      style: TextStyle(
                                        fontSize: 8.5,
                                        fontWeight: FontWeight.w600,
                                        color: targetTokens.textPrimary == const Color(0xFF2C3E35)
                                            ? const Color(0xFF1E2923)
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwatch(Color color, String label) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 26,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black.withValues(alpha: 0.08), width: 1),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
