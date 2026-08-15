import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/theme/theme_controller.dart';
import 'app/widgets/theme_scope.dart';
import 'features/navigation/main_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations and system UI overlay
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final themeController = ThemeController();
  await themeController.initialize();

  runApp(
    ThemeScope(
      controller: themeController,
      child: const WellnessApp(),
    ),
  );
}

/// Root Application Widget configured with reactive ThemeController.
class WellnessApp extends StatelessWidget {
  const WellnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeScope.of(context);

    return ListenableBuilder(
      listenable: themeController,
      builder: (context, _) {
        final currentThemeData = themeController.currentThemeData;

        return MaterialApp(
          title: 'Wellness App',
          debugShowCheckedModeBanner: false,
          theme: currentThemeData,
          home: AnimatedTheme(
            data: currentThemeData,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: const MainShell(),
          ),
        );
      },
    );
  }
}
