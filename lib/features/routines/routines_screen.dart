import 'package:flutter/material.dart';
import '../../app/theme/theme_tokens.dart';
import '../../app/widgets/app_button.dart';
import '../../app/widgets/app_card.dart';
import '../../app/widgets/custom_toast.dart';

class RoutineGoal {
  final int id;
  final String text;
  bool completed;

  RoutineGoal({required this.id, required this.text, this.completed = false});
}

/// Daily Routines screen managing morning intentions, custom goals, and evening wind-down.
class RoutinesScreen extends StatefulWidget {
  const RoutinesScreen({super.key});

  @override
  State<RoutinesScreen> createState() => _RoutinesScreenState();
}

class _RoutinesScreenState extends State<RoutinesScreen> {
  bool _mWakeup = true;
  bool _mShot = true;
  bool _nWater = false;
  bool _nScreen = false;
  bool _winddownLock = true;

  final TextEditingController _goalController = TextEditingController();
  final List<RoutineGoal> _customGoals = [
    RoutineGoal(id: 1, text: '10-minute mindful breathing & tea', completed: true),
    RoutineGoal(id: 2, text: 'No phone during first 30 minutes', completed: false),
  ];

  void _addGoal() {
    final text = _goalController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _customGoals.add(RoutineGoal(id: DateTime.now().millisecondsSinceEpoch, text: text));
      _goalController.clear();
    });
    CustomToast.show(context, message: 'Intention added ✨');
  }

  void _showBedtimeAuditModal() {
    final colors = context.colors;
    final textTheme = context.textTheme;

    int completed = 0;
    int total = 4 + _customGoals.length;
    if (_mWakeup) completed++;
    if (_mShot) completed++;
    if (_nWater) completed++;
    if (_nScreen) completed++;
    for (var g in _customGoals) {
      if (g.completed) completed++;
    }
    final percentage = ((completed / total) * 100).round();

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: colors.surface,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '🌙',
                style: const TextStyle(fontSize: 36),
              ),
              const SizedBox(height: 8),
              Text(
                'Bedtime Energy Audit',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Here is how you protected your energy and rituals today.',
                textAlign: TextAlign.center,
                style: textTheme.bodySmall?.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: 20),

              // Stats Row
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                decoration: BoxDecoration(
                  color: colors.surfaceHighlight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.border, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          '$completed/$total',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                          ),
                        ),
                        Text(
                          'Tasks Done',
                          style: TextStyle(fontSize: 11, color: colors.textMuted),
                        ),
                      ],
                    ),
                    Container(width: 1, height: 32, color: colors.border),
                    Column(
                      children: [
                        Text(
                          '$percentage%',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: colors.primaryDark,
                          ),
                        ),
                        Text(
                          'Completion',
                          style: TextStyle(fontSize: 11, color: colors.textMuted),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),
              Text(
                percentage >= 80
                    ? '✨ Flawless day! You are radiant. Sleep peacefully.'
                    : '💛 You showed up and listened to your body today. Rest deeply.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 22),
              AppButton.primary(
                label: 'Goodnight ✨',
                isFullWidth: true,
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Daily Routines',
            style: textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          Text(
            "Let's protect that sacred energy today. ✨",
            style: textTheme.bodyMedium?.copyWith(
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 20),

          // ☀️ Morning Intentions Card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('☀️', style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Text(
                      'Morning Intentions',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildCheckboxTile(
                  title: 'Early Wake-Up & Gentle Stretch Prompt',
                  checked: _mWakeup,
                  onChanged: (val) => setState(() => _mWakeup = val ?? false),
                ),
                Divider(color: colors.borderLight, height: 1),
                _buildCheckboxTile(
                  title: 'Morning Ginger-Honey / Lemon Shot',
                  checked: _mShot,
                  onChanged: (val) => setState(() => _mShot = val ?? false),
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),

          // ✨ My Intentions & Custom Goals Card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('✨', style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Text(
                      'My Intentions & Goals',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Add Goal Bar
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _goalController,
                        style: TextStyle(color: colors.textPrimary, fontSize: 13.5),
                        decoration: InputDecoration(
                          hintText: "What's your focus today?",
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                        onSubmitted: (_) => _addGoal(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    AppButton.primary(
                      label: '＋ Add',
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      borderRadius: 14,
                      onPressed: _addGoal,
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Goals List
                if (_customGoals.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: Text(
                        'No custom goals set. Add one above!',
                        style: textTheme.bodySmall?.copyWith(color: colors.textMuted),
                      ),
                    ),
                  )
                else
                  ..._customGoals.map((g) {
                    return _buildStarCheckboxTile(
                      title: g.text,
                      checked: g.completed,
                      onChanged: (val) {
                        setState(() => g.completed = val ?? false);
                      },
                    );
                  }),
              ],
            ),
          ),

          const SizedBox(height: 4),

          // 🌙 Evening Wind-Down Card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('🌙', style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Text(
                      'Evening Wind-Down',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildCheckboxTile(
                  title: 'Log Final Water Count',
                  checked: _nWater,
                  onChanged: (val) => setState(() => _nWater = val ?? false),
                ),
                Divider(color: colors.borderLight, height: 1),
                _buildCheckboxTile(
                  title: 'Turn Off Screens & Prepare for Sleep',
                  checked: _nScreen,
                  onChanged: (val) => setState(() => _nScreen = val ?? false),
                ),

                const SizedBox(height: 14),

                // Screen Lock Reminder Setting
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colors.surfaceHighlight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colors.borderLight, width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Screen Lock Reminder',
                              style: textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colors.textPrimary,
                              ),
                            ),
                            Text(
                              'Gentle notification 30 mins before bed',
                              style: textTheme.bodySmall?.copyWith(
                                fontSize: 11,
                                color: colors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch.adaptive(
                        value: _winddownLock,
                        onChanged: (val) => setState(() => _winddownLock = val),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Bedtime Audit Action Button
          Center(
            child: AppButton(
              label: '🌙 Bedtime Audit Check',
              variant: AppButtonVariant.secondary,
              borderRadius: 9999,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              onPressed: _showBedtimeAuditModal,
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCheckboxTile({
    required String title,
    required bool checked,
    required ValueChanged<bool?> onChanged,
  }) {
    final colors = context.colors;
    return InkWell(
      onTap: () => onChanged(!checked),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: checked ? colors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: checked ? colors.primary : colors.border,
                  width: 1.5,
                ),
              ),
              child: checked
                  ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: checked ? colors.textMuted : colors.textPrimary,
                  decoration: checked ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarCheckboxTile({
    required String title,
    required bool checked,
    required ValueChanged<bool?> onChanged,
  }) {
    final colors = context.colors;
    return InkWell(
      onTap: () => onChanged(!checked),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: checked ? colors.primary : Colors.transparent,
                border: Border.all(
                  color: checked ? colors.primary : colors.border,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  '✧',
                  style: TextStyle(
                    fontSize: 14,
                    color: checked ? Colors.white : colors.textMuted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: checked ? colors.textMuted : colors.textPrimary,
                  decoration: checked ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
