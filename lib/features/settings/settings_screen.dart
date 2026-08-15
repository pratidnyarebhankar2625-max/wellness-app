import 'package:flutter/material.dart';
import '../../app/theme/theme_tokens.dart';
import '../../app/widgets/app_card.dart';
import '../../app/widgets/custom_toast.dart';
import '../../app/widgets/theme_scope.dart';
import 'appearance_screen.dart';

/// Settings screen providing direct access to Appearance, Reminders, and About.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _waterReminders = true;
  bool _screenLockAlert = true;
  bool _hapticFeedback = true;

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeScope.of(context);
    final metadata = themeController.currentMetadata;
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Card
            AppCard(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: colors.primary.withValues(alpha: 0.25),
                    child: Text(
                      '🌸',
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Maya Thorne',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Ovulatory Phase • Day 14',
                          style: textTheme.bodySmall?.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Pro Member',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 1. APPEARANCE & THEMES (FULLY FUNCTIONAL)
            Text(
              'Appearance & Visual Theme',
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),

            AppCard(
              padding: const EdgeInsets.all(16),
              hasGlow: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AppearanceScreen()),
                );
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Text('🎨', style: TextStyle(fontSize: 22)),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Themes & Aesthetics',
                              style: textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: colors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Active: ${metadata.name}',
                              style: textTheme.bodySmall?.copyWith(
                                color: colors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, size: 16, color: colors.textMuted),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Divider(color: colors.borderLight, height: 1),
                  const SizedBox(height: 10),

                  // Swatch dots preview inside settings card
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Palette: "${metadata.personality}"',
                        style: textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: colors.textMuted,
                          fontSize: 11,
                        ),
                      ),
                      Row(
                        children: metadata.swatchColors.map((c) {
                          return Container(
                            width: 14,
                            height: 14,
                            margin: const EdgeInsets.only(left: 4),
                            decoration: BoxDecoration(
                              color: c,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black12, width: 0.8),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // 2. NOTIFICATIONS & MINDFUL REMINDERS (FUTURE / PROTOTYPE)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mindful Reminders',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: colors.borderLight,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Local Prefs',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: colors.textMuted),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            AppCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    value: _waterReminders,
                    onChanged: (val) {
                      setState(() => _waterReminders = val);
                      CustomToast.show(
                        context,
                        message: val ? 'Hydration alerts active 💧' : 'Hydration alerts muted',
                      );
                    },
                    title: Text(
                      'Hydration Prompts',
                      style: textTheme.titleSmall?.copyWith(color: colors.textPrimary),
                    ),
                    subtitle: Text(
                      'Gentle nudges every 2 hours',
                      style: textTheme.bodySmall?.copyWith(color: colors.textMuted),
                    ),
                  ),
                  Divider(color: colors.borderLight, height: 1),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    value: _screenLockAlert,
                    onChanged: (val) {
                      setState(() => _screenLockAlert = val);
                      CustomToast.show(
                        context,
                        message: val ? 'Night wind-down active 🌙' : 'Night wind-down disabled',
                      );
                    },
                    title: Text(
                      'Bedtime Screen Lock',
                      style: textTheme.titleSmall?.copyWith(color: colors.textPrimary),
                    ),
                    subtitle: Text(
                      '30 mins before sleep audit',
                      style: textTheme.bodySmall?.copyWith(color: colors.textMuted),
                    ),
                  ),
                  Divider(color: colors.borderLight, height: 1),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    value: _hapticFeedback,
                    onChanged: (val) {
                      setState(() => _hapticFeedback = val);
                    },
                    title: Text(
                      'Gentle Tap Feedback',
                      style: textTheme.titleSmall?.copyWith(color: colors.textPrimary),
                    ),
                    subtitle: Text(
                      'Micro-interactions on buttons',
                      style: textTheme.bodySmall?.copyWith(color: colors.textMuted),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // 3. ABOUT SECTION
            Text(
              'About',
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),

            AppCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(metadata.emojis.first, style: const TextStyle(fontSize: 18)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Wellness Mobile App',
                              style: textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: colors.textPrimary,
                              ),
                            ),
                            Text(
                              'Version 1.0.0 • Pure Flutter Engine',
                              style: textTheme.bodySmall?.copyWith(color: colors.textMuted),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Designed with a feminine, calming, botanical aesthetic. Built using Flutter Material 3, dynamic ThemeExtensions, and reactive state management.',
                    style: textTheme.bodySmall?.copyWith(
                      color: colors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
