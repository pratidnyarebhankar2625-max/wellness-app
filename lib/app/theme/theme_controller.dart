import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'app_themes.dart';
import 'theme_storage.dart';
import 'theme_tokens.dart';

/// Centralized state controller for managing the application theme.
/// Notifies all listeners when the theme changes, ensuring immediate
/// app-wide updates without restarting or reloading.
class ThemeController extends ChangeNotifier {
  AppTheme _currentTheme = AppTheme.matchaRosewater;
  bool _isInitialized = false;

  AppTheme get currentTheme => _currentTheme;
  bool get isInitialized => _isInitialized;

  ThemeData get currentThemeData => AppThemes.getThemeData(_currentTheme);
  AppColorTokens get currentTokens => AppThemes.getTokens(_currentTheme);
  AppThemeMetadata get currentMetadata => AppThemeMetadata.of(_currentTheme);

  /// Initializes the controller by loading the persisted theme preference.
  Future<void> initialize() async {
    _currentTheme = await ThemeStorage.loadTheme();
    _isInitialized = true;
    notifyListeners();
  }

  /// Changes the active theme, saves to local storage, and immediately
  /// triggers a rebuild of the entire application.
  Future<void> setTheme(AppTheme newTheme) async {
    if (_currentTheme == newTheme) return;
    _currentTheme = newTheme;
    notifyListeners();
    await ThemeStorage.saveTheme(newTheme);
  }
}
