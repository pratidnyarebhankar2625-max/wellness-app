import 'package:flutter/material.dart';
import '../../app/theme/theme_tokens.dart';
import '../../app/widgets/app_card.dart';

class RecipeItem {
  final String title;
  final String category;
  final String prepTime;
  final String emoji;
  final String tag;
  final List<String> ingredients;

  const RecipeItem({
    required this.title,
    required this.category,
    required this.prepTime,
    required this.emoji,
    required this.tag,
    required this.ingredients,
  });
}

/// Pantry & Hormone-Balancing Recipes screen.
class PantryScreen extends StatefulWidget {
  const PantryScreen({super.key});

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  String _selectedCategory = 'All';
  final Set<String> _shoppingListChecked = {'Organic Matcha Powder'};

  final List<String> _categories = ['All', 'Bowls', 'Drinks', 'Snacks', 'Tonics'];

  final List<RecipeItem> _recipes = const [
    RecipeItem(
      title: 'Matcha Chia Seed Pudding',
      category: 'Bowls',
      prepTime: '10 min',
      emoji: '🍵',
      tag: 'Hormone Sync',
      ingredients: ['Matcha Powder', 'Chia Seeds', 'Almond Milk', 'Raw Honey'],
    ),
    RecipeItem(
      title: 'Golden Pistachio Adaptogen Latte',
      category: 'Drinks',
      prepTime: '5 min',
      emoji: '✨',
      tag: 'Anti-Inflammatory',
      ingredients: ['Turmeric', 'Pistachio Milk', 'Ashwagandha', 'Ceylon Cinnamon'],
    ),
    RecipeItem(
      title: 'Wild Berry Antioxidant Glow Bowl',
      category: 'Bowls',
      prepTime: '8 min',
      emoji: '🍓',
      tag: 'Cellular Glow',
      ingredients: ['Blueberries', 'Acai', 'Hemp Hearts', 'Coconut Yogurt'],
    ),
    RecipeItem(
      title: 'Sunflower & Sesame Seed Crunch',
      category: 'Snacks',
      prepTime: '15 min',
      emoji: '🌻',
      tag: 'Luteal Support',
      ingredients: ['Sunflower Seeds', 'Black Sesame', 'Flax Meal', 'Maple Drizzle'],
    ),
  ];

  final List<String> _shoppingItems = [
    'Organic Ceremonial Matcha',
    'Raw Sprouted Pumpkin Seeds',
    'Cold-Pressed Flaxseed Oil',
    'Wild Blueberries & Raspberries',
    'Coconut Milk & Greek Yogurt',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    final filteredRecipes = _selectedCategory == 'All'
        ? _recipes
        : _recipes.where((r) => r.category == _selectedCategory).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Pantry & Nourishment',
            style: textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          Text(
            'Hormone-balancing recipes crafted for whole vitality.',
            style: textTheme.bodyMedium?.copyWith(
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 18),

          // Categories Filter Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((cat) {
                final isSel = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSel,
                    selectedColor: colors.primary,
                    backgroundColor: colors.surface,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: isSel ? FontWeight.w700 : FontWeight.w500,
                      color: isSel
                          ? (colors.textPrimary == const Color(0xFF2C3E35) ? const Color(0xFF1E2923) : Colors.white)
                          : colors.textPrimary,
                    ),
                    side: BorderSide(color: isSel ? colors.primary : colors.border, width: 1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedCategory = cat);
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 14),

          // Recipe Cards Grid
          ...filteredRecipes.map((recipe) {
            return AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(recipe.emoji, style: const TextStyle(fontSize: 26)),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: colors.accent.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    recipe.tag,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                ),
                                Text(
                                  '⏱️ ${recipe.prepTime}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: colors.textMuted,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              recipe.title,
                              style: textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: colors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: recipe.ingredients.map((ing) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: colors.surfaceHighlight,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: colors.borderLight, width: 0.8),
                        ),
                        child: Text(
                          '• $ing',
                          style: TextStyle(fontSize: 10.5, color: colors.textSecondary),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 6),

          // 🛒 Shopping List Card
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '🛒 Weekly Grocery Focus',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                    Text(
                      '${_shoppingListChecked.length}/${_shoppingItems.length}',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.primaryDark),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ..._shoppingItems.map((item) {
                  final isChecked = _shoppingListChecked.contains(item);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (isChecked) {
                          _shoppingListChecked.remove(item);
                        } else {
                          _shoppingListChecked.add(item);
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Icon(
                            isChecked ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                            size: 20,
                            color: isChecked ? colors.primary : colors.textMuted,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 13,
                                color: isChecked ? colors.textMuted : colors.textPrimary,
                                decoration: isChecked ? TextDecoration.lineThrough : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
