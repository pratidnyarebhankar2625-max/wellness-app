import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellness_app/app/theme/app_theme.dart';
import 'package:wellness_app/app/theme/theme_controller.dart';
import 'package:wellness_app/app/theme/theme_tokens.dart';
import 'package:wellness_app/app/widgets/theme_scope.dart';
import 'package:wellness_app/features/settings/appearance_screen.dart';
import 'package:wellness_app/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Wellness App launches and displays main dashboard',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    final controller = ThemeController();
    await controller.initialize();

    await tester.pumpWidget(
      ThemeScope(
        controller: controller,
        child: const WellnessApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify main screen header and components loaded
    expect(find.text('Dashboard'), findsWidgets);
    expect(find.text('Welcome back, gorgeous ✨'), findsOneWidget);
    expect(find.text('Daily Vitality & Rhythm'), findsOneWidget);
    expect(find.text('Balance'), findsOneWidget);
  });

  testWidgets('Appearance screen displays 3 preview cards and switches themes on tap',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    final controller = ThemeController();
    await controller.initialize();

    await tester.pumpWidget(
      ThemeScope(
        controller: controller,
        child: MaterialApp(
          theme: controller.currentThemeData,
          home: const AppearanceScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify all 3 theme cards are present
    expect(find.text('Matcha & Rosewater'), findsOneWidget);
    expect(find.text('Pistachio & Gold Dust'), findsOneWidget);
    expect(find.text('Lavender Cotton Candy'), findsOneWidget);

    // Tap on Pistachio & Gold Dust
    await tester.ensureVisible(find.text('Pistachio & Gold Dust'));
    await tester.tap(find.text('Pistachio & Gold Dust'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(controller.currentTheme, AppTheme.pistachioGold);

    // Tap on Lavender Cotton Candy
    await tester.ensureVisible(find.text('Lavender Cotton Candy'));
    await tester.tap(find.text('Lavender Cotton Candy'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(controller.currentTheme, AppTheme.lavenderCottonCandy);
  });

  testWidgets('Complete Navigation Flow & Theme Persistence Verification',
      (WidgetTester tester) async {
    // 1. Initial Launch
    SharedPreferences.setMockInitialValues({});

    final controller = ThemeController();
    await controller.initialize();

    await tester.pumpWidget(
      ThemeScope(
        controller: controller,
        child: const WellnessApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify Dashboard visible
    expect(find.text('Welcome back, gorgeous ✨'), findsOneWidget);

    // 2. Open drawer and navigate to Daily Routines
    await tester.tap(find.byTooltip('Open Menu'));
    await tester.pumpAndSettle();
    expect(find.text('Wellness Space'), findsOneWidget);

    await tester.tap(find.text('Daily Routines'));
    await tester.pumpAndSettle();
    expect(find.text("Let's protect that sacred energy today. ✨"), findsOneWidget);

    // 3. Navigate via bottom bar to Nutrition
    await tester.tap(find.text('Nutrition'));
    await tester.pumpAndSettle();
    expect(find.text('💧 Mindful Hydration'), findsOneWidget);

    // 4. Navigate via bottom bar to Workout
    await tester.tap(find.text('Workout'));
    await tester.pumpAndSettle();
    expect(find.text('Pilates Core Flow'), findsOneWidget);
    expect(find.text('🔢 Rep Counter Matrix'), findsOneWidget);

    // 5. Open drawer and navigate to Cycle History
    await tester.tap(find.byTooltip('Open Menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cycle History'));
    await tester.pumpAndSettle();
    expect(find.text('Peak Estrogen & Magnetic Energy ✨'), findsOneWidget);

    // Press back arrow in App Bar to return to Dashboard
    await tester.tap(find.byTooltip('Back to Dashboard'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back, gorgeous ✨'), findsOneWidget);

    // 6. Open drawer and navigate to Pantry & Recipes
    await tester.tap(find.byTooltip('Open Menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pantry & Recipes'));
    await tester.pumpAndSettle();
    expect(find.text('Matcha Chia Seed Pudding'), findsOneWidget);

    await tester.tap(find.byTooltip('Back to Dashboard'));
    await tester.pumpAndSettle();

    // 7. Open drawer and navigate to Journal & Mood
    await tester.tap(find.byTooltip('Open Menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Journal & Mood'));
    await tester.pumpAndSettle();
    expect(find.text('Today’s Mood & Pulse'), findsOneWidget);

    await tester.tap(find.byTooltip('Back to Dashboard'));
    await tester.pumpAndSettle();

    // 8. Open drawer and navigate to Analytics
    await tester.tap(find.byTooltip('Open Menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Analytics'));
    await tester.pumpAndSettle();
    expect(find.text('7-Day Wellness Score Flow'), findsOneWidget);

    await tester.tap(find.byTooltip('Back to Dashboard'));
    await tester.pumpAndSettle();

    // 9. Open Settings via App Bar Settings button
    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Maya Thorne'), findsOneWidget);
    expect(find.text('Appearance & Visual Theme'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);

    // 10. Open Appearance from Settings
    await tester.tap(find.text('Themes & Aesthetics'));
    await tester.pumpAndSettle();
    expect(find.text('Personalize Your Wellness Space'), findsOneWidget);

    // 11. Select Pistachio & Gold Dust
    await tester.ensureVisible(find.text('Pistachio & Gold Dust'));
    await tester.tap(find.text('Pistachio & Gold Dust'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    expect(controller.currentTheme, AppTheme.pistachioGold);

    // 12. Pop back: Appearance -> Settings
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Maya Thorne'), findsOneWidget);

    // 13. Pop back: Settings -> Dashboard
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back, gorgeous ✨'), findsOneWidget);

    // Verify theme colors in Dashboard context
    final BuildContext dashContext = tester.element(find.text('Welcome back, gorgeous ✨'));
    expect(dashContext.colors.primary, const Color(0xFFCCE2CB));
    expect(dashContext.colors.background, const Color(0xFFFAF7F0));

    // 14. Navigate to Workout and verify theme colors
    await tester.tap(find.text('Workout'));
    await tester.pumpAndSettle();
    final BuildContext workoutContext = tester.element(find.text('Pilates Core Flow'));
    expect(workoutContext.colors.primary, const Color(0xFFCCE2CB));

    // 15. Navigate back to Settings -> Appearance and verify Pistachio is selected
    await tester.tap(find.byTooltip('Appearance & Themes'));
    await tester.pumpAndSettle();
    expect(controller.currentTheme, AppTheme.pistachioGold);

    // 16. Verify Persistence across app restarts
    final restartedController = ThemeController();
    await restartedController.initialize();
    expect(restartedController.currentTheme, AppTheme.pistachioGold);
  });
}
