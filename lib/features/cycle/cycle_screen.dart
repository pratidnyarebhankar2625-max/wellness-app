import 'package:flutter/material.dart';
import '../../app/theme/theme_tokens.dart';
import '../../app/widgets/app_card.dart';
import '../../app/widgets/custom_toast.dart';

/// Period & Cycle Tracker screen with interactive calendar, flow logger, and phase guidance.
class CycleScreen extends StatefulWidget {
  const CycleScreen({super.key});

  @override
  State<CycleScreen> createState() => _CycleScreenState();
}

class _CycleScreenState extends State<CycleScreen> {
  String _flow = 'Medium';
  final Set<String> _selectedSymptoms = {'Mood Swings', 'Low Energy'};
  int _selectedDay = 14;

  final List<String> _symptoms = [
    'Cramps',
    'Low Energy',
    'Mood Swings',
    'Bloating',
    'Glowing Skin',
    'Sweet Cravings',
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
          // Header
          Text(
            'Cycle & Rhythm',
            style: textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          Text(
            'Honor your body’s natural inner seasons. 🌸',
            style: textTheme.bodyMedium?.copyWith(
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 18),

          // 🌔 Current Phase Hero Circle Card
          AppCard(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.surface,
                    border: Border.all(color: colors.primary, width: 4.5),
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary.withValues(alpha: 0.25),
                        blurRadius: 18,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Day $_selectedDay',
                          style: textTheme.headlineLarge?.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                          ),
                        ),
                        Text(
                          'Ovulatory Phase',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: colors.accent.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    'Peak Estrogen & Magnetic Energy ✨',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),

          // 📅 Interactive Monthly Calendar Card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'August 2026',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                    Row(
                      children: [
                        _buildCalendarLegend('Period', colors.accent),
                        const SizedBox(width: 8),
                        _buildCalendarLegend('Ovulation', colors.primary),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Days of week header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                      .map((d) => SizedBox(
                            width: 36,
                            child: Center(
                              child: Text(
                                d,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: colors.textMuted,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 8),

                // Calendar Grid (28 day cycle sample)
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                  ),
                  itemCount: 28,
                  itemBuilder: (context, index) {
                    final dayNum = index + 1;
                    final isSelected = _selectedDay == dayNum;
                    final isPeriod = dayNum >= 1 && dayNum <= 5;
                    final isOvulation = dayNum >= 13 && dayNum <= 16;

                    Color bg = Colors.transparent;
                    Color fg = colors.textPrimary;
                    Border? border;

                    if (isPeriod) {
                      bg = colors.accent.withValues(alpha: 0.35);
                    } else if (isOvulation) {
                      bg = colors.primary.withValues(alpha: 0.35);
                    }

                    if (isSelected) {
                      border = Border.all(color: colors.textPrimary, width: 2);
                    }

                    return InkWell(
                      onTap: () {
                        setState(() => _selectedDay = dayNum);
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(10),
                          border: border,
                        ),
                        child: Center(
                          child: Text(
                            '$dayNum',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected || isPeriod || isOvulation
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: fg,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),

          // 📝 Log Flow & Symptoms Card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📝 Log Flow & Symptoms',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                Text(
                  'Flow Intensity',
                  style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: colors.textSecondary),
                ),
                const SizedBox(height: 6),

                // Flow Selector Row
                Row(
                  children: ['Spotting', 'Light', 'Medium', 'Heavy'].map((lvl) {
                    final isSel = _flow == lvl;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: InkWell(
                          onTap: () {
                            setState(() => _flow = lvl);
                            CustomToast.show(context, message: 'Flow logged: $lvl');
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: isSel ? colors.accent : colors.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSel ? colors.accentDark : colors.borderLight,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                lvl,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: colors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 14),

                Text(
                  'Symptoms',
                  style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: colors.textSecondary),
                ),
                const SizedBox(height: 6),

                // Symptoms Wrap Chips
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: _symptoms.map((sym) {
                    final isSel = _selectedSymptoms.contains(sym);
                    return FilterChip(
                      selected: isSel,
                      label: Text(sym),
                      labelStyle: TextStyle(
                        fontSize: 11.5,
                        fontWeight: isSel ? FontWeight.w600 : FontWeight.w500,
                        color: colors.textPrimary,
                      ),
                      backgroundColor: colors.surface,
                      selectedColor: colors.primary.withValues(alpha: 0.3),
                      side: BorderSide(
                        color: isSel ? colors.primary : colors.border,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedSymptoms.add(sym);
                          } else {
                            _selectedSymptoms.remove(sym);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),

          // 💡 Phase Insights Card
          AppCard(
            backgroundColor: colors.surfaceHighlight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('🌻', style: const TextStyle(fontSize: 26)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ovulatory Phase Nutrition',
                        style: textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Double down on zinc and magnesium. Incorporate sunflower and pumpkin seeds to support healthy progesterone synthesis.',
                        style: textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                          height: 1.35,
                        ),
                      ),
                    ],
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

  Widget _buildCalendarLegend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
