import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellness_app/app/theme/app_theme.dart';
import 'package:wellness_app/app/theme/app_themes.dart';
import 'package:wellness_app/app/theme/theme_controller.dart';
import 'package:wellness_app/app/theme/theme_storage.dart';
import 'package:wellness_app/app/theme/theme_tokens.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Global Theme System Unit Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('Default theme should be Matcha & Rosewater with exact color tokens', () {
      final tokens = AppThemes.getTokens(AppTheme.matchaRosewater);
      expect(tokens.background, const Color(0xFFFFF0F2));
      expect(tokens.primary, const Color(0xFFA3B899));
      expect(tokens.textPrimary, const Color(0xFF2C3E35));
      expect(tokens.accent, const Color(0xFFDE9B9B));
    });

    test('Pistachio & Gold Dust theme should have exact color tokens', () {
      final tokens = AppThemes.getTokens(AppTheme.pistachioGold);
      expect(tokens.background, const Color(0xFFFAF7F0));
      expect(tokens.primary, const Color(0xFFCCE2CB));
      expect(tokens.textPrimary, const Color(0xFF3B443B));
      expect(tokens.accent, const Color(0xFFFFD1B3));
    });

    test('Lavender Cotton Candy theme should have exact color tokens', () {
      final tokens = AppThemes.getTokens(AppTheme.lavenderCottonCandy);
      expect(tokens.background, const Color(0xFFF3E8FF));
      expect(tokens.primary, const Color(0xFFD8B4FE));
      expect(tokens.textPrimary, const Color(0xFF3B224E));
      expect(tokens.accent, const Color(0xFFFBCFE8));
    });

    test('ThemeController initial state and reactive switching', () async {
      final controller = ThemeController();
      await controller.initialize();

      expect(controller.currentTheme, AppTheme.matchaRosewater);
      expect(controller.currentTokens.background, const Color(0xFFFFF0F2));

      int notificationCount = 0;
      controller.addListener(() {
        notificationCount++;
      });

      // Switch to Pistachio & Gold Dust
      await controller.setTheme(AppTheme.pistachioGold);
      expect(controller.currentTheme, AppTheme.pistachioGold);
      expect(controller.currentTokens.background, const Color(0xFFFAF7F0));
      expect(notificationCount, 1);

      // Verify persistence in SharedPreferences
      final savedTheme = await ThemeStorage.loadTheme();
      expect(savedTheme, AppTheme.pistachioGold);

      // Switch to Lavender Cotton Candy
      await controller.setTheme(AppTheme.lavenderCottonCandy);
      expect(controller.currentTheme, AppTheme.lavenderCottonCandy);
      expect(controller.currentTokens.background, const Color(0xFFF3E8FF));
      expect(notificationCount, 2);

      final savedTheme2 = await ThemeStorage.loadTheme();
      expect(savedTheme2, AppTheme.lavenderCottonCandy);
    });

    test('ThemeData includes AppColorTokens extension and proper ColorScheme', () {
      final themeData = AppThemes.getThemeData(AppTheme.matchaRosewater);
      final extension = themeData.extension<AppColorTokens>();

      expect(extension, isNotNull);
      expect(extension?.primary, const Color(0xFFA3B899));
      expect(themeData.scaffoldBackgroundColor, const Color(0xFFFFF0F2));
    });
  });
}
