import 'package:flutter/material.dart';

/// Available visual themes in the application.
enum AppTheme {
  matchaRosewater,
  pistachioGold,
  lavenderCottonCandy,
}

/// Rich metadata for each theme used in Settings -> Appearance and UI headers.
class AppThemeMetadata {
  final AppTheme theme;
  final String name;
  final String personality;
  final String description;
  final List<String> emojis;
  final List<Color> swatchColors;
  final Color primaryColor;
  final Color backgroundColor;
  final Color textColor;
  final Color accentColor;

  const AppThemeMetadata({
    required this.theme,
    required this.name,
    required this.personality,
    required this.description,
    required this.emojis,
    required this.swatchColors,
    required this.primaryColor,
    required this.backgroundColor,
    required this.textColor,
    required this.accentColor,
  });

  static const Map<AppTheme, AppThemeMetadata> allThemes = {
    AppTheme.matchaRosewater: AppThemeMetadata(
      theme: AppTheme.matchaRosewater,
      name: 'Matcha & Rosewater',
      personality: 'Soft, botanical & calming',
      description: 'A dreamy, soft, botanical feminine space with calming matcha tones and pale rosewater warmth.',
      emojis: ['🌸', '🟢', '🌲', '🍓'],
      swatchColors: [
        Color(0xFFFFF0F2), // Pale Rosewater Pink
        Color(0xFFA3B899), // Soft Matcha Green
        Color(0xFF2C3E35), // Deep Forest Ink
        Color(0xFFDE9B9B), // Dusty Strawberry
      ],
      backgroundColor: Color(0xFFFFF0F2),
      primaryColor: Color(0xFFA3B899),
      textColor: Color(0xFF2C3E35),
      accentColor: Color(0xFFDE9B9B),
    ),
    AppTheme.pistachioGold: AppThemeMetadata(
      theme: AppTheme.pistachioGold,
      name: 'Pistachio & Gold Dust',
      personality: 'Bright, fresh & energetic',
      description: 'A cheerful, motivating, clean wellness theme ideal for morning routines and mindful workouts.',
      emojis: ['🌿', '🟢', '🌲', '🍑'],
      swatchColors: [
        Color(0xFFFAF7F0), // Warm Vanilla Cream
        Color(0xFFCCE2CB), // Pastel Pistachio Green
        Color(0xFF3B443B), // Sage Charcoal
        Color(0xFFFFD1B3), // Golden Hour Peach
      ],
      backgroundColor: Color(0xFFFAF7F0),
      primaryColor: Color(0xFFCCE2CB),
      textColor: Color(0xFF3B443B),
      accentColor: Color(0xFFFFD1B3),
    ),
    AppTheme.lavenderCottonCandy: AppThemeMetadata(
      theme: AppTheme.lavenderCottonCandy,
      name: 'Lavender Cotton Candy',
      personality: 'Dreamy, sweet & peaceful',
      description: 'A dreamy pastel escape with sweet lavender, midnight plum, and bubblegum blush accents.',
      emojis: ['💜', '🪻', '🌌', '🌸'],
      swatchColors: [
        Color(0xFFF3E8FF), // Soft Lilac Cloud
        Color(0xFFD8B4FE), // Sweet Lavender
        Color(0xFF3B224E), // Midnight Plum
        Color(0xFFFBCFE8), // Bubblegum Blush
      ],
      backgroundColor: Color(0xFFF3E8FF),
      primaryColor: Color(0xFFD8B4FE),
      textColor: Color(0xFF3B224E),
      accentColor: Color(0xFFFBCFE8),
    ),
  };

  static AppThemeMetadata of(AppTheme theme) {
    return allThemes[theme] ?? allThemes[AppTheme.matchaRosewater]!;
  }
}
