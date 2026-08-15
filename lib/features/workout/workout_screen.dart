import 'dart:async';
import 'package:flutter/material.dart';
import '../../app/theme/theme_tokens.dart';
import '../../app/widgets/app_button.dart';
import '../../app/widgets/app_card.dart';
import '../../app/widgets/custom_toast.dart';

/// Workout screen with curated routines, rep counter matrix, and interval rest timer.
class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  int _selectedWorkoutIndex = 0;
  final int _repGoal = 30;
  int _repDone = 18;

  // Timer state
  int _timerSeconds = 45;
  int _initialTimerSeconds = 45;
  bool _isTimerRunning = false;
  Timer? _timer;

  final List<Map<String, dynamic>> _workouts = [
    {
      'title': 'Pilates Core Flow',
      'duration': '22 min',
      'level': 'Gentle / Core',
      'icon': '🩰',
      'calories': '160 kcal',
    },
    {
      'title': 'Glute Sculpt & Tone',
      'duration': '28 min',
      'level': 'Targeted Tone',
      'icon': '🍑',
      'calories': '210 kcal',
    },
    {
      'title': 'Mindful Yoga & Stretch',
      'duration': '18 min',
      'level': 'Restorative',
      'icon': '🧘‍♀️',
      'calories': '110 kcal',
    },
    {
      'title': 'HIIT Energy Burst',
      'duration': '15 min',
      'level': 'High Intensity',
      'icon': '⚡',
      'calories': '240 kcal',
    },
  ];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (_isTimerRunning) return;
    setState(() => _isTimerRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
      } else {
        timer.cancel();
        setState(() => _isTimerRunning = false);
        CustomToast.show(context, message: 'Rest complete! Ready for next set ✨');
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isTimerRunning = false);
  }

  void _resetTimer(int seconds) {
    _timer?.cancel();
    setState(() {
      _isTimerRunning = false;
      _initialTimerSeconds = seconds;
      _timerSeconds = seconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    final repsLeft = (_repGoal - _repDone).clamp(0, 999);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Mindful Movement',
            style: textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          Text(
            'Honor your energy cycle with intentional sculpting.',
            style: textTheme.bodyMedium?.copyWith(
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 18),

          // Workout Selection Cards Carousel / Grid
          Text(
            'Select Routine',
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),

          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _workouts.length,
              itemBuilder: (context, index) {
                final w = _workouts[index];
                final isSel = _selectedWorkoutIndex == index;

                return InkWell(
                  onTap: () => setState(() => _selectedWorkoutIndex = index),
                  borderRadius: BorderRadius.circular(20),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 170,
                    margin: const EdgeInsets.only(right: 12, bottom: 4),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isSel ? colors.surfaceHighlight : colors.surfaceCard,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSel ? colors.primary : colors.border,
                        width: isSel ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isSel ? colors.primary.withValues(alpha: 0.25) : colors.shadowColor,
                          blurRadius: isSel ? 14 : 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(w['icon'] as String, style: const TextStyle(fontSize: 22)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: colors.primary.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                w['duration'] as String,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: colors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              w['title'] as String,
                              style: textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: colors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              w['level'] as String,
                              style: textTheme.bodySmall?.copyWith(
                                fontSize: 10.5,
                                color: colors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 14),

          // Rep Counter Matrix Card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '🔢 Rep Counter Matrix',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: colors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Set 3 of 4',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Goal / Done / Left Matrix
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colors.surfaceHighlight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colors.borderLight, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMatrixColumn('Goal', '$_repGoal', colors.textSecondary),
                      Container(width: 1, height: 36, color: colors.border),
                      _buildMatrixColumn('Done', '$_repDone', colors.primaryDark),
                      Container(width: 1, height: 36, color: colors.border),
                      _buildMatrixColumn('Left', '$repsLeft', colors.accentDark),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Rep Increment Buttons
                Row(
                  children: [
                    Expanded(
                      child: AppButton.secondary(
                        label: '-1',
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        borderRadius: 14,
                        onPressed: () {
                          if (_repDone > 0) {
                            setState(() => _repDone--);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: AppButton.primary(
                        label: '＋ 1 Rep',
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        borderRadius: 14,
                        onPressed: () {
                          setState(() => _repDone++);
                          if (_repDone == _repGoal) {
                            CustomToast.show(context, message: 'Goal achieved! You are glowing ✨');
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppButton.secondary(
                        label: '＋5',
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        borderRadius: 14,
                        onPressed: () {
                          setState(() => _repDone += 5);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),

          // Interval / Rest Timer Card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '⏱️ Interval & Rest Timer',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                    Row(
                      children: [30, 45, 60].map((s) {
                        final isPreset = _initialTimerSeconds == s;
                        return Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: InkWell(
                            onTap: () => _resetTimer(s),
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: isPreset ? colors.primary : colors.surface,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: colors.border, width: 0.8),
                              ),
                              child: Text(
                                '${s}s',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: isPreset
                                      ? (colors.textPrimary == const Color(0xFF2C3E35) ? const Color(0xFF1E2923) : Colors.white)
                                      : colors.textMuted,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Circular Timer Display
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          value: _timerSeconds / _initialTimerSeconds,
                          strokeWidth: 10,
                          backgroundColor: colors.borderLight,
                          valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '0:${_timerSeconds.toString().padLeft(2, '0')}',
                            style: textTheme.headlineLarge?.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: colors.textPrimary,
                            ),
                          ),
                          Text(
                            _isTimerRunning ? 'Resting...' : 'Ready',
                            style: TextStyle(
                              fontSize: 10,
                              color: colors.textMuted,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // Timer Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!_isTimerRunning)
                      AppButton.primary(
                        label: '▶ Start Rest',
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                        onPressed: _startTimer,
                      )
                    else
                      AppButton.accent(
                        label: '⏸ Pause',
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                        onPressed: _pauseTimer,
                      ),
                    const SizedBox(width: 12),
                    AppButton.secondary(
                      label: '↺ Reset',
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      onPressed: () => _resetTimer(_initialTimerSeconds),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMatrixColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
