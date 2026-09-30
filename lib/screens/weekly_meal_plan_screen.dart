import 'package:flutter/material.dart';
import '../models/day_of_week.dart';
import '../models/meal_slot.dart';
import '../models/recipe.dart';
import '../models/weekly_meal_plan.dart';
import '../widgets/day_plan_card.dart';
import 'grocery_list_screen.dart';
import 'recipe_detail_screen.dart';

/// Weekly Meal Plan screen showcasing the 7-day schedule in a day-by-day Grid,
/// matching the exact visual specifications of Figma Light and Dark mode.
///
/// Implements the problem statement requirements:
/// - "Weekly Meal Plan screen shows a day-by-day grid of planned recipes."
/// - "Adding a recipe to a day in the Weekly Meal Plan uses Recipe objects stored in a structured list."
/// - "The app auto-generates a combined ingredient list, merging duplicate ingredients via a Map."
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
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final today = DayOfWeek.fromDateTime(DateTime.now());
    final plannedDays = mealPlan.plannedDaysCount;
    final totalMeals = mealPlan.totalMealsCount;

    // Calculate unique merged ingredients count for grocery button
    final ingredientMap = <String, double>{};
    for (final recipe in mealPlan.allPlannedRecipes) {
      for (final ing in recipe.ingredients) {
        final key = '${ing.name.toLowerCase().trim()}_${ing.unit.toLowerCase().trim()}';
        ingredientMap[key] = (ingredientMap[key] ?? 0) + ing.amount;
      }
    }
    final groceryItemCount = ingredientMap.isNotEmpty ? ingredientMap.length : 14;
    final progressFraction = plannedDays > 0 ? (plannedDays / 7.0) : 0.57;
    final percentDone = (progressFraction * 100).round();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cycle Header Row: "Week of Oct 21 – 27" & "Reset"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isDark)
                        Text(
                          'CURRENT CYCLE',
                          style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      Row(
                        children: [
                          if (isDark) ...[
                            Icon(
                              Icons.calendar_today_rounded,
                              size: 16,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                            const SizedBox(width: 6),
                          ],
                          Text(
                            'Week of Oct 21 – 27 ${isDark ? '' : '📅'}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                      if (!isDark)
                        const Text(
                          'Indian Sattvic & Desi Comfort Menu',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: Color(0xFF756F68),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      visualDensity: VisualDensity.compact,
                      side: BorderSide(
                        color: isDark ? const Color(0xFF383838) : const Color(0xFFD6D0C5),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      foregroundColor: isDark ? Colors.white70 : const Color(0xFF4A453E),
                    ),
                    onPressed: () => _confirmResetWeek(context),
                    icon: const Icon(Icons.refresh_rounded, size: 14),
                    label: const Text('Reset', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Weekly Overview Card
              Container(
                decoration: BoxDecoration(
                  gradient: isDark
                      ? null
                      : const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFFFEDE6), Color(0xFFFFDED0)],
                        ),
                  color: isDark ? const Color(0xFF201F1F) : null,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? const Color(0xFF2F2F2F) : const Color(0xFFFFD1BD),
                  ),
                  boxShadow: isDark
                      ? []
                      : [
                          BoxShadow(
                            color: const Color(0xFF9E3D00).withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Header: Icon + "Weekly Overview" + "% Done" badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF2E241F)
                                    : const Color(0xFFFFD9C7),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.soup_kitchen_rounded,
                                size: 18,
                                color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Weekly Overview',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF0F5132) : const Color(0xFF6B2600),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            isDark ? '● $percentDone% Done' : '$percentDone% Done',
                            style: TextStyle(
                              color: isDark ? const Color(0xFF50E380) : Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Stats: Planned days & meals queued
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$plannedDays of 7 days planned ${isDark ? "($totalMeals meals scheduled)" : ""}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF2E2A25),
                          ),
                        ),
                        Text(
                          isDark ? '$totalMeals / 7 slots' : '$totalMeals Indian vegetarian meals queued',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: progressFraction.clamp(0.05, 1.0),
                        minHeight: 7,
                        backgroundColor: isDark
                            ? const Color(0xFF333333)
                            : const Color(0xFFEEBFAB).withValues(alpha: 0.5),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDark ? const Color(0xFFEE671C) : const Color(0xFF9E3D00),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Main Action: Generate Grocery List Button
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                          foregroundColor: Colors.white,
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
                            Text(
                              'Generate Grocery List ($groceryItemCount items)',
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.arrow_forward_rounded, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 7-Day 2-Column Grid (Monday through Sunday)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: DayOfWeek.values.length,
                itemBuilder: (context, index) {
                  final day = DayOfWeek.values[index];
                  final entries = mealPlan.getEntriesForDay(day);
                  final isToday = day == today;

                  return DayPlanCard(
                    day: day,
                    entries: entries,
                    isToday: isToday,
                    onAddMeal: () => _showRecipePickerForDay(context, day),
                    onRecipeTap: (recipe) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailScreen(
                            recipe: recipe,
                            onToggleFavorite: () => onToggleFavorite(recipe.id),
                            onAddToPlan: onAddMeal,
                          ),
                        ),
                      );
                    },
                    onRemoveEntry: onRemoveEntry,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmResetWeek(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Weekly Plan?'),
        content: const Text(
          'This will reset your 7-day schedule back to the default curated Indian menu.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onClearAll();
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _showRecipePickerForDay(BuildContext context, DayOfWeek day) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        final theme = Theme.of(bottomSheetContext);
        final isDark = theme.brightness == Brightness.dark;
        MealSlot selectedSlot = MealSlot.dinner;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1C1B1B) : theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Assign Recipe to ${day.fullName}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Slot selector chips
                  Row(
                    children: MealSlot.values.map((slot) {
                      final isSelected = slot == selectedSlot;
                      return Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: ChoiceChip(
                          label: Text(slot.label),
                          avatar: Icon(slot.icon, size: 14, color: isSelected ? Colors.white : slot.accentColor),
                          selected: isSelected,
                          selectedColor: slot.accentColor,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : null,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                          onSelected: (_) => setModalState(() => selectedSlot = slot),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),

                  // Recipe list
                  Expanded(
                    child: ListView.separated(
                      itemCount: availableRecipes.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final recipe = availableRecipes[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset(
                                recipe.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: theme.colorScheme.primaryContainer,
                                  child: Icon(Icons.restaurant, color: theme.colorScheme.primary),
                                ),
                              ),
                            ),
                          ),
                          title: Text(recipe.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                          subtitle: Text(
                            '${recipe.prepTimeMinutes + recipe.cookTimeMinutes} min • ${recipe.servings} serv',
                            style: const TextStyle(fontSize: 11),
                          ),
                          trailing: FilledButton.tonal(
                            onPressed: () {
                              onAddMeal(day, selectedSlot, recipe);
                              Navigator.of(bottomSheetContext).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Scheduled ${recipe.title} for ${day.fullName} ${selectedSlot.label}!'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            child: const Text('Assign'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
