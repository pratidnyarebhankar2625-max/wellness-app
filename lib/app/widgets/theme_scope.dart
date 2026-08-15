import 'package:flutter/material.dart';
import '../theme/theme_controller.dart';

/// Provides the global [ThemeController] down the widget tree using InheritedNotifier.
class ThemeScope extends InheritedNotifier<ThemeController> {
  const ThemeScope({
    super.key,
    required ThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  /// Accesses the nearest [ThemeController] in the widget tree.
  static ThemeController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeScope>();
    assert(scope != null, 'No ThemeScope found in context');
    return scope!.notifier!;
  }
}
