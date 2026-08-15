import 'package:flutter/material.dart';
import '../../app/theme/theme_tokens.dart';
import '../../app/widgets/custom_toast.dart';
import '../../app/widgets/theme_scope.dart';
import '../analytics/analytics_screen.dart';
import '../cycle/cycle_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../journal/journal_screen.dart';
import '../nutrition/nutrition_screen.dart';
import '../pantry/pantry_screen.dart';
import '../routines/routines_screen.dart';
import '../settings/appearance_screen.dart';
import '../settings/settings_screen.dart';
import '../workout/workout_screen.dart';

/// Main navigation shell housing the Top App Bar, Bottom Navigation, Drawer, and Active Screens.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  void _onSelectTab(int index) {
    setState(() => _currentIndex = index);
  }

  String _getScreenTitle(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Daily Routines';
      case 2:
        return 'Nutrition & Habits';
      case 3:
        return 'Workout';
      case 4:
        return 'Cycle History';
      case 5:
        return 'Pantry & Recipes';
      case 6:
        return 'Journal & Mood';
      case 7:
        return 'Analytics';
      default:
        return 'Wellness';
    }
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return DashboardScreen(onNavigateTab: _onSelectTab);
      case 1:
        return const RoutinesScreen();
      case 2:
        return const NutritionScreen();
      case 3:
        return const WorkoutScreen();
      case 4:
        return const CycleScreen();
      case 5:
        return const PantryScreen();
      case 6:
        return const JournalScreen();
      case 7:
        return const AnalyticsScreen();
      default:
        return DashboardScreen(onNavigateTab: _onSelectTab);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeScope.of(context);
    final metadata = themeController.currentMetadata;
    final colors = context.colors;
    final textTheme = context.textTheme;

    final isSecondaryScreen = _currentIndex > 3;

    return PopScope(
      canPop: _currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_currentIndex != 0) {
          setState(() => _currentIndex = 0);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: isSecondaryScreen
              ? IconButton(
                  icon: Icon(Icons.arrow_back_rounded, color: colors.textPrimary),
                  tooltip: 'Back to Dashboard',
                  onPressed: () => setState(() => _currentIndex = 0),
                )
              : Builder(
                  builder: (ctx) => IconButton(
                    icon: Icon(Icons.menu_rounded, color: colors.textPrimary),
                    tooltip: 'Open Menu',
                    onPressed: () => Scaffold.of(ctx).openDrawer(),
                  ),
                ),
          title: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    metadata.emojis.first,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  _getScreenTitle(_currentIndex),
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          actions: [
            // Quick Appearance / Theme Selector
            IconButton(
              icon: Icon(Icons.palette_outlined, color: colors.textPrimary, size: 22),
              tooltip: 'Appearance & Themes',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AppearanceScreen()),
                );
              },
            ),

            // Settings Shortcut
            IconButton(
              icon: Icon(Icons.settings_outlined, color: colors.textPrimary, size: 22),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),

            // Notifications
            IconButton(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(Icons.notifications_outlined, color: colors.textPrimary, size: 22),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: colors.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              tooltip: 'Notifications',
              onPressed: () {
                CustomToast.show(context, message: 'All mindful rituals up to date ✨');
              },
            ),
            const SizedBox(width: 4),
          ],
        ),

        // Primary Drawer Navigation
        drawer: Drawer(
          backgroundColor: colors.surface,
          child: Column(
            children: [
              // Drawer Header
              DrawerHeader(
                decoration: BoxDecoration(
                  color: colors.surfaceHighlight,
                  border: Border(bottom: BorderSide(color: colors.border, width: 1)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: colors.primary.withValues(alpha: 0.25),
                      child: Text(
                        metadata.emojis.first,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wellness Space',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Theme: ${metadata.name}',
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

              // Drawer Navigation Items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    _buildDrawerItem(0, 'Dashboard', '🏠'),
                    _buildDrawerItem(1, 'Daily Routines', '✨'),
                    _buildDrawerItem(2, 'Nutrition & Habits', '🥗'),
                    _buildDrawerItem(3, 'Workout', '🧘‍♀️'),
                    _buildDrawerItem(4, 'Cycle History', '🌸'),
                    _buildDrawerItem(5, 'Pantry & Recipes', '🥑'),
                    _buildDrawerItem(6, 'Journal & Mood', '📖'),
                    _buildDrawerItem(7, 'Analytics', '📊'),

                    const Divider(height: 20),

                    // Settings Navigation Item
                    ListTile(
                      leading: const Text('⚙️', style: TextStyle(fontSize: 18)),
                      title: Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: colors.textMuted),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SettingsScreen()),
                        );
                      },
                    ),

                    // Appearance & Themes Navigation Item
                    ListTile(
                      leading: const Text('🎨', style: TextStyle(fontSize: 18)),
                      title: Text(
                        'Appearance & Themes',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: colors.primaryDark,
                        ),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          metadata.name.split(' ').first,
                          style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: colors.textPrimary),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const AppearanceScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Screen Body
        body: _buildBody(),

        // Bottom Navigation Bar for the 4 primary daily screens
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: colors.surface.withValues(alpha: 0.95),
            border: Border(top: BorderSide(color: colors.borderLight, width: 1)),
            boxShadow: [
              BoxShadow(
                color: colors.shadowColor,
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBottomNavItem(0, 'Dashboard', '🏠'),
                  _buildBottomNavItem(1, 'Routines', '✨'),
                  _buildBottomNavItem(2, 'Nutrition', '🥗'),
                  _buildBottomNavItem(3, 'Workout', '🧘‍♀️'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(int index, String label, String emoji) {
    final colors = context.colors;
    final isSelected = _currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => _onSelectTab(index),
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? colors.primary.withValues(alpha: 0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                emoji,
                style: TextStyle(
                  fontSize: isSelected ? 18 : 16,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? colors.textPrimary : colors.textMuted,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(int index, String label, String emoji) {
    final colors = context.colors;
    final isSelected = _currentIndex == index;

    return ListTile(
      leading: Text(emoji, style: const TextStyle(fontSize: 18)),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected ? colors.textPrimary : colors.textSecondary,
        ),
      ),
      selected: isSelected,
      selectedTileColor: colors.primary.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: () {
        Navigator.of(context).pop();
        setState(() => _currentIndex = index);
      },
    );
  }
}
