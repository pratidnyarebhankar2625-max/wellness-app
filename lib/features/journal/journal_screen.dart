import 'package:flutter/material.dart';
import '../../app/theme/theme_tokens.dart';
import '../../app/widgets/app_button.dart';
import '../../app/widgets/app_card.dart';
import '../../app/widgets/custom_toast.dart';

class JournalEntry {
  final int id;
  final String date;
  final String mood;
  final String moodEmoji;
  final String prompt;
  final String text;

  const JournalEntry({
    required this.id,
    required this.date,
    required this.mood,
    required this.moodEmoji,
    required this.prompt,
    required this.text,
  });
}

/// Journal & Mindful Reflection screen.
class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  String _selectedMood = 'Radiant';
  String _selectedEmoji = '🌸';
  final TextEditingController _textController = TextEditingController();

  final List<Map<String, String>> _moods = const [
    {'label': 'Radiant', 'emoji': '🌸'},
    {'label': 'Grounded', 'emoji': '🌿'},
    {'label': 'Tender', 'emoji': '💖'},
    {'label': 'Low Energy', 'emoji': '☁️'},
    {'label': 'Anxious', 'emoji': '🌧️'},
  ];

  final List<JournalEntry> _entries = [
    JournalEntry(
      id: 1,
      date: 'Today, 8:45 AM',
      mood: 'Radiant',
      moodEmoji: '🌸',
      prompt: 'What brought you peace today?',
      text: 'Morning ginger-honey tea in quiet sunlight before looking at any screens. Felt so deeply centered and energized for the day.',
    ),
    JournalEntry(
      id: 2,
      date: 'Yesterday, 9:20 PM',
      mood: 'Grounded',
      moodEmoji: '🌿',
      prompt: 'Glow moment',
      text: 'Finished a 25 min gentle pilates sculpt and walked under the trees. Honored my body’s need for slower rhythm.',
    ),
  ];

  void _saveEntry() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _entries.insert(
        0,
        JournalEntry(
          id: DateTime.now().millisecondsSinceEpoch,
          date: 'Just now',
          mood: _selectedMood,
          moodEmoji: _selectedEmoji,
          prompt: 'Daily reflection',
          text: text,
        ),
      );
      _textController.clear();
    });

    CustomToast.show(context, message: 'Reflection saved ✨');
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
            'Mindful Journal',
            style: textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          Text(
            'A gentle sanctuary for your thoughts and gratitude.',
            style: textTheme.bodyMedium?.copyWith(
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 18),

          // Write Reflection Card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today’s Mood & Pulse',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),

                // Mood Selector Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _moods.map((m) {
                    final isSel = _selectedMood == m['label'];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedMood = m['label']!;
                          _selectedEmoji = m['emoji']!;
                        });
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSel ? colors.primary.withValues(alpha: 0.25) : colors.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSel ? colors.primary : colors.borderLight,
                            width: isSel ? 1.8 : 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(m['emoji']!, style: const TextStyle(fontSize: 20)),
                            const SizedBox(height: 2),
                            Text(
                              m['label']!,
                              style: TextStyle(
                                fontSize: 9.5,
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

                const SizedBox(height: 16),

                Text(
                  'What is bringing you serenity right now?',
                  style: textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),

                TextField(
                  controller: _textController,
                  maxLines: 3,
                  style: TextStyle(fontSize: 13.5, color: colors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Write freely... gratitude, body sensations, reflections.',
                  ),
                ),

                const SizedBox(height: 12),

                Align(
                  alignment: Alignment.centerRight,
                  child: AppButton.primary(
                    label: 'Save Reflection ✨',
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    borderRadius: 14,
                    onPressed: _saveEntry,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Saved Entries Section
          Text(
            'Recent Entries',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),

          if (_entries.isEmpty)
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: colors.surfaceCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colors.borderLight, width: 1),
              ),
              child: Center(
                child: Column(
                  children: [
                    Text('📖', style: const TextStyle(fontSize: 36)),
                    const SizedBox(height: 10),
                    Text(
                      'Your journal is empty',
                      style: textTheme.titleSmall?.copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Capture your first moment of serenity above.',
                      style: textTheme.bodySmall?.copyWith(color: colors.textMuted),
                    ),
                  ],
                ),
              ),
            )
          else
            ..._entries.map((entry) {
              return AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(entry.moodEmoji, style: const TextStyle(fontSize: 18)),
                            const SizedBox(width: 8),
                            Text(
                              entry.mood,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: colors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          entry.date,
                          style: TextStyle(fontSize: 11, color: colors.textMuted),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      entry.text,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.textPrimary,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              );
            }),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
