import 'package:flutter/material.dart';
import '../../app/theme/theme_tokens.dart';
import '../../app/widgets/app_card.dart';
import '../../app/widgets/theme_chart.dart';
import '../../app/widgets/theme_scope.dart';

/// Analytics screen visualizing trends with charts dynamically styled to the active theme.
class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeScope.of(context);
    final metadata = themeController.currentMetadata;
    final colors = context.colors;
    final textTheme = context.textTheme;

    final wellnessScores = [74.0, 80.0, 85.0, 78.0, 92.0, 88.0, 94.0];
    final routineValues = [0.75, 0.90, 0.80, 0.65, 1.0, 0.85, 0.95];
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Holistic Analytics',
            style: textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          Text(
            'Visualize your harmony, consistency, and vital flow.',
            style: textTheme.bodyMedium?.copyWith(
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 18),

          // Active Palette Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: colors.surfaceCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.borderLight, width: 1),
            ),
            child: Row(
              children: [
                Text(metadata.emojis.first, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chart Engine: ${metadata.name}',
                        style: textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                        ),
                      ),
                      Text(
                        'Palette harmonized with active theme tokens.',
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 10.5,
                          color: colors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: colors.chartPalette.map((c) {
                    return Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.only(left: 4),
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // 1. 7-Day Wellness Score Area Chart Card
          AppCard(
            padding: const EdgeInsets.all(18),
            child: ThemeAreaChart(
              title: '7-Day Wellness Score Flow',
              dataPoints: wellnessScores,
              labels: days,
              height: 170,
              metricUnit: '%',
            ),
          ),

          const SizedBox(height: 4),

          // 2. Weekly Routine Consistency Bar Chart Card
          AppCard(
            padding: const EdgeInsets.all(18),
            child: ThemeBarChart(
              title: 'Weekly Routine Completion',
              values: routineValues,
              labels: days,
              height: 130,
            ),
          ),

          const SizedBox(height: 4),

          // 3. Sleep & Energy Correlation Metrics
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '⚡ Vitality & Sleep Correlation',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildMetricPill('Deep Sleep', '7h 48m', colors.primary),
                    const SizedBox(width: 10),
                    _buildMetricPill('Energy Peak', '9:30 AM', colors.accent),
                    const SizedBox(width: 10),
                    _buildMetricPill('Consistency', '94%', colors.primaryDark),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Morning hydration and seed cycling on Day 14 correspond with a +18% bump in afternoon vitality.',
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.textSecondary,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMetricPill(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
