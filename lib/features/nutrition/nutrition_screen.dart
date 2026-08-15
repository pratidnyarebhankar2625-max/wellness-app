import 'package:flutter/material.dart';
import '../../app/theme/theme_tokens.dart';
import '../../app/widgets/app_button.dart';
import '../../app/widgets/app_card.dart';
import '../../app/widgets/custom_toast.dart';

class SeedItem {
  final String id;
  final String icon;
  final String name;

  const SeedItem({required this.id, required this.icon, required this.name});
}

/// Nutrition, seed cycling, hydration, and gut health tracking screen.
class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  int _waterGlasses = 5;
  bool _fruitEaten = false;
  final Set<String> _selectedSeeds = {'pumpkin', 'chia'};

  String _gutConsistency = 'smooth';
  String _gutEase = 'Effortless';
  final Set<String> _gutFeels = {'Light & Empty', 'Good after Ginger Shot'};

  final List<SeedItem> _seeds = const [
    SeedItem(id: 'sesame', icon: '🖤', name: 'Black Sesame'),
    SeedItem(id: 'pumpkin', icon: '🎃', name: 'Pumpkin Seeds'),
    SeedItem(id: 'sunflower', icon: '🌻', name: 'Sunflower Seeds'),
    SeedItem(id: 'chia', icon: '🌾', name: 'Chia / Flax'),
  ];

  final List<Map<String, String>> _bristolScale = const [
    {'id': 'hard', 'emoji': '🪨', 'label': 'Hard/Lumpy'},
    {'id': 'sausage', 'emoji': '🌭', 'label': 'Sausage'},
    {'id': 'smooth', 'emoji': '🐍', 'label': 'Smooth/Soft'},
    {'id': 'liquid', 'emoji': '💧', 'label': 'Liquid/Mushy'},
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
            'Nutrition & Habits',
            style: textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          Text(
            'Fuel your body with intention and cellular nourishment. ✨',
            style: textTheme.bodyMedium?.copyWith(
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 18),

          // 🍎 Fruit Check Alert Banner (Dynamic Theme Accent)
          if (!_fruitEaten)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colors.accent.withValues(alpha: 0.45), width: 1.2),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: colors.accent.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(child: Text('🍎', style: TextStyle(fontSize: 22))),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily Fruit Check',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Have you had fresh antioxidant fruit today?',
                          style: TextStyle(
                            fontSize: 12,
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  AppButton(
                    label: 'Yes, ate fruit!',
                    variant: AppButtonVariant.accent,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    borderRadius: 12,
                    onPressed: () {
                      setState(() => _fruitEaten = true);
                      CustomToast.show(context, message: 'Fruit logged! Glowing skin unlocked 🍓');
                    },
                  ),
                ],
              ),
            ),

          // 💧 Mindful Hydration Card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '💧 Mindful Hydration',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                    Text(
                      '$_waterGlasses / 8 Glasses',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: colors.primaryDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Glasses Grid
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(8, (index) {
                    final isFilled = index < _waterGlasses;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _waterGlasses = index + 1;
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 32,
                        height: 42,
                        decoration: BoxDecoration(
                          color: isFilled
                              ? colors.primary.withValues(alpha: 0.3)
                              : colors.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isFilled ? colors.primary : colors.borderLight,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            isFilled ? '💧' : '🥛',
                            style: TextStyle(
                              fontSize: isFilled ? 16 : 14,
                              color: isFilled ? null : colors.textMuted,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 16),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: AppButton.primary(
                        label: '＋ Drink Glass',
                        onPressed: () {
                          setState(() {
                            if (_waterGlasses < 8) _waterGlasses++;
                          });
                          CustomToast.show(context, message: 'Hydration logged 💧');
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: AppButton.secondary(
                        label: '🕒 Snooze',
                        onPressed: () {
                          CustomToast.show(
                            context,
                            message: 'Water reminder snoozed 30m ✨',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),

          // 🌻 Seed Cycling Journal Card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '🌻 Seed Cycling Journal',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                    Text(
                      '${_selectedSeeds.length}/4 Stamped',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.primaryDark),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Tap each seed stamp to log your hormone-supporting seed dosage today.',
                  style: textTheme.bodySmall?.copyWith(color: colors.textMuted),
                ),
                const SizedBox(height: 16),

                // 4-Seed Circular Stamps Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _seeds.map((seed) {
                    final isStamped = _selectedSeeds.contains(seed.id);
                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (isStamped) {
                            _selectedSeeds.remove(seed.id);
                          } else {
                            _selectedSeeds.add(seed.id);
                          }
                        });
                        CustomToast.show(
                          context,
                          message: isStamped ? 'Unstamped ${seed.name}' : 'Stamped ${seed.name}! ✨',
                        );
                      },
                      borderRadius: BorderRadius.circular(9999),
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 62,
                            height: 62,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isStamped ? colors.surfaceHighlight : colors.surface,
                              border: Border.all(
                                color: isStamped ? colors.primary : colors.border,
                                width: isStamped ? 2.5 : 1.2,
                              ),
                              boxShadow: isStamped
                                  ? [
                                      BoxShadow(
                                        color: colors.primary.withValues(alpha: 0.3),
                                        blurRadius: 12,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                seed.icon,
                                style: TextStyle(
                                  fontSize: 26,
                                  color: isStamped ? null : Colors.grey.withValues(alpha: 0.4),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            seed.name,
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: isStamped ? FontWeight.w700 : FontWeight.w500,
                              color: isStamped ? colors.textPrimary : colors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),

          // 🦠 Gut Health & Regularity Card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🦠 Gut Health & Second Brain',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  'Daily Consistency (Bristol Scale)',
                  style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: colors.textSecondary),
                ),
                const SizedBox(height: 8),

                // Bristol Scale Tap Grid
                Row(
                  children: _bristolScale.map((item) {
                    final isSel = _gutConsistency == item['id'];
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: InkWell(
                          onTap: () => setState(() => _gutConsistency = item['id']!),
                          borderRadius: BorderRadius.circular(12),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: isSel ? colors.primary.withValues(alpha: 0.2) : colors.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSel ? colors.primary : colors.borderLight,
                                width: isSel ? 1.8 : 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(item['emoji']!, style: const TextStyle(fontSize: 18)),
                                const SizedBox(height: 2),
                                Text(
                                  item['label']!,
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                                    color: isSel ? colors.textPrimary : colors.textMuted,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 14),

                Text(
                  'Digestion Ease',
                  style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: colors.textSecondary),
                ),
                const SizedBox(height: 6),
                Row(
                  children: ['Effortless', 'Normal', 'Straining'].map((level) {
                    final isSel = _gutEase == level;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: isSel ? colors.primary : colors.surface,
                            foregroundColor: isSel
                                ? (colors.textPrimary == const Color(0xFF2C3E35) ? const Color(0xFF1E2923) : Colors.white)
                                : colors.textPrimary,
                            side: BorderSide(color: isSel ? colors.primary : colors.border, width: 1),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () => setState(() => _gutEase = level),
                          child: Text(level, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 14),

                Text(
                  'How do you feel?',
                  style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600, color: colors.textSecondary),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: ['Bloated', 'Light & Empty', 'Gassy', 'Good after Ginger Shot'].map((sym) {
                    final isSel = _gutFeels.contains(sym);
                    return FilterChip(
                      selected: isSel,
                      label: Text(sym),
                      labelStyle: TextStyle(
                        fontSize: 10.5,
                        fontWeight: isSel ? FontWeight.w600 : FontWeight.w500,
                        color: colors.textPrimary,
                      ),
                      backgroundColor: colors.surface,
                      selectedColor: colors.primary.withValues(alpha: 0.25),
                      side: BorderSide(
                        color: isSel ? colors.primary : colors.border,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _gutFeels.add(sym);
                          } else {
                            _gutFeels.remove(sym);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
