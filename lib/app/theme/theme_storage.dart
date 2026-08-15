import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart';

/// Handles persistent local storage of user theme preferences.
class ThemeStorage {
  static const String _themeKey = 'app_selected_theme';

  /// Loads the saved theme from SharedPreferences.
  /// Falls back to [AppTheme.matchaRosewater] if no preference is saved.
  static Future<AppTheme> loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedThemeName = prefs.getString(_themeKey);
      if (savedThemeName != null) {
        return AppTheme.values.firstWhere(
          (t) => t.name == savedThemeName,
          orElse: () => AppTheme.matchaRosewater,
        );
      }
    } catch (_) {
      // In case of platform storage issues, fallback safely
    }
    return AppTheme.matchaRosewater;
  }

  /// Saves the chosen [theme] to SharedPreferences.
  static Future<bool> saveTheme(AppTheme theme) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_themeKey, theme.name);
    } catch (_) {
      return false;
    }
  }
}
