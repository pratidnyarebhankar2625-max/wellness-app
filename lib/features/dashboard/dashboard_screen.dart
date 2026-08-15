import 'package:flutter/material.dart';
import '../../app/theme/theme_tokens.dart';
import '../../app/widgets/app_button.dart';
import '../../app/widgets/app_card.dart';
import '../../app/widgets/custom_toast.dart';
import '../../app/widgets/wellness_score_ring.dart';

/// Comprehensive Dashboard screen providing wellness overview and quick logging.
class DashboardScreen extends StatefulWidget {
  final Function(int)? onNavigateTab;

  const DashboardScreen({super.key, this.onNavigateTab});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _waterGlasses = 5;
  String _selectedMood = 'Radiant';

  final List<Map<String, String>> _moods = [
    {'label': 'Radiant', 'emoji': '🌸'},
    {'label': 'Calm', 'emoji': '🌿'},
    {'label': 'Tender', 'emoji': '💖'},
    {'label': 'Grounded', 'emoji': '🧘‍♀️'},
    {'label': 'Tired', 'emoji': '☁️'},
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, gorgeous ✨',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Daily Vitality & Rhythm',
                      style: textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: colors.accent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: colors.accent.withValues(alpha: 0.4), width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('🩸', style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    Text(
                      'Day 14',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Main Hero Score Card
          AppCard(
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
            hasGlow: true,
            child: Row(
              children: [
                WellnessScoreRing(
                  score: 0.88,
                  size: 130,
                  label: 'Balance',
                  subtitle: '88% Optimal',
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Radiant Energy Flow',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your morning rituals and hydration are perfectly synced with your natural cycle.',
                        style: textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildMiniStat('Routines', '4/4', colors.primary),
                          const SizedBox(width: 8),
                          _buildMiniStat('Hydration', '$_waterGlasses/8', colors.accent),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          // Daily Focus & Botanical Affirmation Card
          AppCard(
            backgroundColor: colors.surfaceHighlight,
            borderColor: colors.primary.withValues(alpha: 0.3),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(child: Text('🌿', style: TextStyle(fontSize: 20))),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily Intention Focus',
                        style: textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '"I nourish my body gently and honor my natural cycles today."',
                        style: textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          // Mood Selector Widget
          AppCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'How is your spirit today?',
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                    Text(
                      _selectedMood,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colors.primaryDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _moods.map((m) {
                    final isSel = _selectedMood == m['label'];
                    return InkWell(
                      onTap: () {
                        setState(() => _selectedMood = m['label']!);
                        CustomToast.show(
                          context,
                          message: 'Mood logged: ${m['label']} ${m['emoji']}',
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSel
                              ? colors.primary.withValues(alpha: 0.25)
                              : colors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSel ? colors.primary : colors.borderLight,
                            width: isSel ? 1.8 : 1,
                          ),
                          boxShadow: isSel
                              ? [
                                  BoxShadow(
                                    color: colors.primary.withValues(alpha: 0.2),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : [],
                        ),
                        child: Column(
                          children: [
                            Text(m['emoji']!, style: const TextStyle(fontSize: 22)),
                            const SizedBox(height: 3),
                            Text(
                              m['label']!,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                                color: isSel ? colors.textPrimary : colors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 6),

          // Two Column Widget: Hydration & Sleep
          Row(
            children: [
              // Hydration Card
              Expanded(
                child: AppCard(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('💧 Hydration', style: textTheme.labelLarge?.copyWith(color: colors.textPrimary)),
                          Text('$_waterGlasses/8', style: TextStyle(fontWeight: FontWeight.w700, color: colors.textPrimary)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: _waterGlasses / 8,
                          minHeight: 8,
                          backgroundColor: colors.borderLight,
                          valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
                        ),
                      ),
                      const SizedBox(height: 10),
                      AppButton.primary(
                        label: '＋ Drink Glass',
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        borderRadius: 12,
                        isFullWidth: true,
                        onPressed: () {
                          setState(() {
                            if (_waterGlasses < 8) _waterGlasses++;
                          });
                          CustomToast.show(context, message: 'Glass logged! Stay radiant 💧');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Sleep & Wind-Down Card
              Expanded(
                child: AppCard(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('🌙 Rest & Sleep', style: textTheme.labelLarge?.copyWith(color: colors.textPrimary)),
                          Text('7.8h', style: TextStyle(fontWeight: FontWeight.w700, color: colors.textPrimary)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Deep sleep score 88%. Optimal restorative cycle.',
                        style: textTheme.bodySmall?.copyWith(fontSize: 11, color: colors.textSecondary),
                      ),
                      const SizedBox(height: 10),
                      AppButton.secondary(
                        label: 'Night Wind-Down',
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        borderRadius: 12,
                        isFullWidth: true,
                        onPressed: () {
                          if (widget.onNavigateTab != null) {
                            widget.onNavigateTab!(1); // Navigate to Routines
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
