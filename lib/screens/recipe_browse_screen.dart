import 'package:flutter/material.dart';
import '../models/day_of_week.dart';
import '../models/meal_slot.dart';
import '../models/recipe.dart';
import '../models/weekly_meal_plan.dart';
import '../widgets/add_to_plan_sheet.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

/// Screen enabling users to browse recipes in a responsive GridView,
/// filter by cuisine categories, view weekly progress cues, and schedule meals.
///
/// Implements the problem statement requirement:
/// - "Build Recipe Browse, Recipe Detail, and Weekly Meal Plan screens using GridView, Card and ListView widgets."
/// - "Show recipe photo, name, prep time, and difficulty level on every Recipe Browse card."
class RecipeBrowseScreen extends StatefulWidget {
  final List<Recipe> recipes;
  final WeeklyMealPlan mealPlan;
  final Function(String recipeId) onToggleFavorite;
  final Function(DayOfWeek day, MealSlot slot, Recipe recipe) onAddToPlan;
  final VoidCallback onNavigateToMealPlan;
  final VoidCallback onAddNewRecipe;

  const RecipeBrowseScreen({
    super.key,
    required this.recipes,
    required this.mealPlan,
    required this.onToggleFavorite,
    required this.onAddToPlan,
    required this.onNavigateToMealPlan,
    required this.onAddNewRecipe,
  });

  @override
  State<RecipeBrowseScreen> createState() => _RecipeBrowseScreenState();
}

class _RecipeBrowseScreenState extends State<RecipeBrowseScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    '🍗 Non-Veg Special',
    '🥬 Pure Veg',
    'North Indian',
    'South Indian',
    'Curries & Dal',
    'Rice Special',
    'Breakfast & Snacks',
    'Global Delights',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Recipe> _getFilteredRecipes() {
    return widget.recipes.where((recipe) {
      final matchesSearch = _searchQuery.isEmpty ||
          recipe.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          recipe.ingredients.any(
            (i) => i.name.toLowerCase().contains(_searchQuery.toLowerCase()),
          );

      bool matchesCategory = true;
      if (_selectedCategory == '🍗 Non-Veg Special') {
        matchesCategory = !recipe.isVegetarian;
      } else if (_selectedCategory == '🥬 Pure Veg') {
        matchesCategory = recipe.isVegetarian;
      } else if (_selectedCategory != 'All') {
        matchesCategory = recipe.category.toLowerCase() == _selectedCategory.toLowerCase() ||
            recipe.tags.any((t) => t.toLowerCase() == _selectedCategory.toLowerCase());
      }

      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final filtered = _getFilteredRecipes();
    final plannedDays = widget.mealPlan.plannedDaysCount;
    final totalMeals = widget.mealPlan.totalMealsCount;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'browse_add_recipe_btn',
        onPressed: widget.onAddNewRecipe,
        backgroundColor: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded, size: 18),
        label: const Text(
          'Add Recipe',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Input Pill
            Container(
              height: 44,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF7F5F0),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFECE7DE),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    size: 20,
                    color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF4A433D),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) => setState(() => _searchQuery = val),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : const Color(0xFF141311),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search recipes, ingredients...',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isDark ? const Color(0xFFA8A39D) : const Color(0xFF6B635A),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  if (isDark) ...[
                    const Icon(Icons.mic_none_rounded, size: 18, color: Color(0xFFDDD9D2)),
                    const SizedBox(width: 10),
                  ],
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Filter options: Pure Sattvic, Allium-Free, Quick Prep.'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Icon(
                      Icons.tune_rounded,
                      size: 18,
                      color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF38332E),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Horizontal Filter Chips Row
            SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = cat == _selectedCategory;

                  return InkWell(
                    onTap: () => setState(() => _selectedCategory = cat),
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500))
                            : (isDark ? const Color(0xFF201F1F) : Colors.white),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isSelected
                              ? (isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500))
                              : (isDark ? const Color(0xFF333333) : const Color(0xFFE5DFC9)),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isSelected && isDark) ...[
                            const Icon(Icons.restaurant_rounded, size: 12, color: Colors.white),
                            const SizedBox(width: 4),
                          ],
                          Text(
                            isSelected && !isDark && cat == 'All' ? 'All •' : cat,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? Colors.white
                                  : (isDark ? const Color(0xFFDDD9D2) : const Color(0xFF2E2A25)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 14),

            // Weekly Meal Plan Progress Cue Card
            InkWell(
              onTap: widget.onNavigateToMealPlan,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF201F1F) : const Color(0xFFFFEDE6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFFFD1BD),
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF421D09) : const Color(0xFF8B2500),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.calendar_month_rounded, size: 18, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    isDark ? 'Weekly Meal Plan' : 'Weekly Meal Plan Progress',
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                                  ),
                                  if (isDark) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF421D09),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Text(
                                        'In Progress',
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFFEE671C),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '$plannedDays of 7 days planned ($totalMeals Indian meals scheduled)',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF3D3730),
                                ),
                              ),
                              if (isDark)
                                const Text(
                                  '● Tap to view',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFFEE671C),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 16,
                          color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                        ),
                      ],
                    ),
                    if (isDark) ...[
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: (plannedDays / 7.0).clamp(0.1, 1.0),
                          minHeight: 4,
                          backgroundColor: const Color(0xFF2C2C2C),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFEE671C)),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Section Header: Curated For You (in Dark Mode)
            if (isDark)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Curated For You ${filtered.length} recipes',
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                    const Row(
                      children: [
                        Text(
                          'Sort',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white70),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.swap_vert_rounded, size: 16, color: Colors.white70),
                      ],
                    ),
                  ],
                ),
              ),

            // Recipe Grid View
            filtered.isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.70,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final recipe = filtered[index];
                      return RecipeCard(
                        recipe: recipe,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailScreen(
                                recipe: recipe,
                                onToggleFavorite: () => widget.onToggleFavorite(recipe.id),
                                onAddToPlan: widget.onAddToPlan,
                              ),
                            ),
                          );
                        },
                        onToggleFavorite: () => widget.onToggleFavorite(recipe.id),
                        onAddToPlan: () {
                          AddToPlanSheet.show(
                            context,
                            recipe: recipe,
                            onConfirm: widget.onAddToPlan,
                          );
                        },
                      );
                    },
                  )
                : EmptyStateView(
                    icon: Icons.search_off_rounded,
                    title: 'No pure vegetarian recipes found',
                    subtitle: 'Try a different search keyword or category filter.',
                    actionLabel: 'Reset Filters',
                    onAction: () {
                      setState(() {
                        _searchController.clear();
                        _searchQuery = '';
                        _selectedCategory = 'All';
                      });
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
