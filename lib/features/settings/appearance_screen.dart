import 'package:flutter/material.dart';
import '../../app/theme/app_theme.dart';
import '../../app/theme/theme_tokens.dart';
import '../../app/widgets/custom_toast.dart';
import '../../app/widgets/theme_preview_card.dart';
import '../../app/widgets/theme_scope.dart';

/// Settings -> Appearance screen allowing users to choose between the 3 visual themes.
class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeScope.of(context);
    final currentTheme = themeController.currentTheme;
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appearance & Themes',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: colors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: colors.textPrimary, size: 20),
          tooltip: 'Back',
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Screen Header description
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: colors.primary.withValues(alpha: 0.25), width: 1),
              ),
              child: Row(
                children: [
                  Text(
                    '🎨',
                    style: const TextStyle(fontSize: 26),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personalize Your Wellness Space',
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Select a theme to instantly transform the entire application atmosphere.',
                          style: textTheme.bodySmall?.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Text(
              'Select Global Theme',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 14),

            // 1. Matcha & Rosewater Card
            ThemePreviewCard(
              theme: AppTheme.matchaRosewater,
              isSelected: currentTheme == AppTheme.matchaRosewater,
              onSelect: () {
                themeController.setTheme(AppTheme.matchaRosewater);
                CustomToast.show(
                  context,
                  message: 'Matcha & Rosewater applied ✨',
                  emoji: '🌸',
                );
              },
            ),

            // 2. Pistachio & Gold Dust Card
            ThemePreviewCard(
              theme: AppTheme.pistachioGold,
              isSelected: currentTheme == AppTheme.pistachioGold,
              onSelect: () {
                themeController.setTheme(AppTheme.pistachioGold);
                CustomToast.show(
                  context,
                  message: 'Pistachio & Gold Dust applied ✨',
                  emoji: '🌿',
                );
              },
            ),

            // 3. Lavender Cotton Candy Card
            ThemePreviewCard(
              theme: AppTheme.lavenderCottonCandy,
              isSelected: currentTheme == AppTheme.lavenderCottonCandy,
              onSelect: () {
                themeController.setTheme(AppTheme.lavenderCottonCandy);
                CustomToast.show(
                  context,
                  message: 'Lavender Cotton Candy applied ✨',
                  emoji: '💜',
                );
              },
            ),

            const SizedBox(height: 10),

            // Theme Info & Future Extensibility Note
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surfaceCard,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: colors.borderLight, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.auto_awesome_rounded, size: 18, color: colors.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Continuous Synchronized Architecture',
                        style: textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Themes control backgrounds, charts, navigation, checklists, calendar highlights, rep matrix, timers, and alerts seamlessly without restarting the app.',
                    style: textTheme.bodySmall?.copyWith(
                      color: colors.textMuted,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
