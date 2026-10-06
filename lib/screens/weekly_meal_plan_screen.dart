import 'package:flutter/material.dart';
import '../models/day_of_week.dart';
import '../models/meal_slot.dart';
import '../models/recipe.dart';
import '../models/weekly_meal_plan.dart';
import '../widgets/app_recipe_image.dart';
import 'grocery_list_screen.dart';
import 'recipe_detail_screen.dart';

/// Clean and responsive Weekly Meal Plan screen.
/// - Shows a clear empty state with a "Go to Browse" CTA when no meals are added.
/// - When meals are scheduled from Browse, displays exactly what has been added day by day.
class WeeklyMealPlanScreen extends StatelessWidget {
  final WeeklyMealPlan mealPlan;
  final List<Recipe> availableRecipes;
  final Function(DayOfWeek day, MealSlot slot, Recipe recipe) onAddMeal;
  final Function(String entryId) onRemoveEntry;
  final VoidCallback onClearAll;
  final Function(String recipeId) onToggleFavorite;
  final Set<String> checkedIngredients;
  final Function(Set<String> updatedChecked) onUpdateCheckedIngredients;
  final VoidCallback? onNavigateToGroceries;
  final VoidCallback? onNavigateToBrowse;

  const WeeklyMealPlanScreen({
    super.key,
    required this.mealPlan,
    required this.availableRecipes,
    required this.onAddMeal,
    required this.onRemoveEntry,
    required this.onClearAll,
    required this.onToggleFavorite,
    required this.checkedIngredients,
    required this.onUpdateCheckedIngredients,
    this.onNavigateToGroceries,
    this.onNavigateToBrowse,
  });

  void _confirmClearAll(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Meal Plan?'),
        content: const Text(
          'This will remove all scheduled meals from your weekly plan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red.shade700),
            onPressed: () {
              Navigator.of(ctx).pop();
              onClearAll();
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final today = DayOfWeek.fromDateTime(DateTime.now());

    // If no meals are scheduled, show the clean empty state
    if (mealPlan.entries.isEmpty) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark ? const Color(0xFF261D18) : const Color(0xFFFFEDE6),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.calendar_month_outlined,
                        size: 42,
                        color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Your meal plan is empty',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Go to Browse to explore recipes and add your favorite dishes to the meal plan!',
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.45,
                      color: isDark ? Colors.white70 : const Color(0xFF6E6860),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 48,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor:
                            isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                      ),
                      onPressed: () {
                        if (onNavigateToBrowse != null) onNavigateToBrowse!();
                      },
                      icon: const Icon(Icons.search_rounded, size: 18),
                      label: const Text(
                        'Go to Browse to Add Items',
                        style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Calculate unique merged ingredients count for grocery button
    final ingredientMap = <String, double>{};
    for (final recipe in mealPlan.allPlannedRecipes) {
      for (final ing in recipe.ingredients) {
        final key = '${ing.name.toLowerCase().trim()}_${ing.unit.toLowerCase().trim()}';
        ingredientMap[key] = (ingredientMap[key] ?? 0) + ing.amount;
      }
    }
    final groceryItemCount = ingredientMap.isNotEmpty ? ingredientMap.length : 14;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: Title & Clear All
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Meal Plan',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 19,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${mealPlan.totalMealsCount} ${mealPlan.totalMealsCount == 1 ? "meal" : "meals"} planned across ${mealPlan.plannedDaysCount} days',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.white60 : const Color(0xFF6E6860),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      visualDensity: VisualDensity.compact,
                      side: BorderSide(
                        color: isDark ? const Color(0xFF383838) : const Color(0xFFD6D0C5),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      foregroundColor: isDark ? Colors.white70 : const Color(0xFF4A453E),
                    ),
                    onPressed: () => _confirmClearAll(context),
                    icon: const Icon(Icons.delete_outline_rounded, size: 15),
                    label: const Text('Clear All', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Generate Grocery List Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (onNavigateToGroceries != null) {
                      onNavigateToGroceries!();
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GroceryListScreen(
                            plannedRecipes: mealPlan.allPlannedRecipes,
                            initialCheckedKeys: checkedIngredients,
                            onCheckedKeysChanged: onUpdateCheckedIngredients,
                          ),
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_bag_outlined, size: 18),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Generate Grocery List ($groceryItemCount items)',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.arrow_forward_rounded, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Render scheduled days
              ...DayOfWeek.values.map((day) {
                final dayEntries = mealPlan.getEntriesForDay(day);
                if (dayEntries.isEmpty) return const SizedBox.shrink();

                final isCurrentDay = day == today;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Day Header
                      Row(
                        children: [
                          Text(
                            day.fullName,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : const Color(0xFF141311),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (isCurrentDay)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'TODAY',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          const Spacer(),
                          Text(
                            '${dayEntries.length} ${dayEntries.length == 1 ? "meal" : "meals"}',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? Colors.white54 : const Color(0xFF8A8276),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Meals in this day
                      ...dayEntries.map((entry) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFECE7DE),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetailScreen(
                                    recipe: entry.recipe,
                                    onToggleFavorite: () => onToggleFavorite(entry.recipe.id),
                                    onAddToPlan: onAddMeal,
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(14),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: AppRecipeImage(
                                      imageUrl: entry.recipe.imageUrl,
                                      width: 58,
                                      height: 58,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: entry.slot.accentColor.withValues(alpha: 0.15),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(entry.slot.icon, size: 11, color: entry.slot.accentColor),
                                                  const SizedBox(width: 3),
                                                  Text(
                                                    entry.slot.label.toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.w800,
                                                      color: entry.slot.accentColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              entry.recipe.isVegetarian ? '🟢 Pure Veg' : '🔴 Non-Veg',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: entry.recipe.isVegetarian
                                                    ? (isDark ? const Color(0xFF50E380) : const Color(0xFF1B6D24))
                                                    : (isDark ? const Color(0xFFFF7A66) : const Color(0xFFC02610)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          entry.recipe.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${entry.recipe.prepTimeMinutes + entry.recipe.cookTimeMinutes} mins • ${entry.recipe.servings} servings',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: isDark ? Colors.white60 : const Color(0xFF6E6860),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close_rounded, size: 18),
                                    color: isDark ? Colors.white60 : const Color(0xFF8A8276),
                                    tooltip: 'Remove',
                                    onPressed: () => onRemoveEntry(entry.id),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 8),

              // Bottom "Add More from Browse" Button
              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: isDark ? const Color(0xFF383838) : const Color(0xFFD6D0C5),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    foregroundColor: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                  ),
                  onPressed: () {
                    if (onNavigateToBrowse != null) onNavigateToBrowse!();
                  },
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text(
                    'Go to Browse to Add More Items',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
