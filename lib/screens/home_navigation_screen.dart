import 'package:flutter/material.dart';
import '../models/day_of_week.dart';
import '../models/meal_slot.dart';
import '../models/recipe.dart';
import '../models/weekly_meal_plan.dart';
import '../services/storage_service.dart';
import 'add_recipe_screen.dart';
import 'favorites_screen.dart';
import 'grocery_list_screen.dart';
import 'profile_screen.dart';
import 'recipe_browse_screen.dart';
import 'weekly_meal_plan_screen.dart';

/// Main scaffold coordinating the bottom NavigationBar and persistent state.
class HomeNavigationScreen extends StatefulWidget {
  final StorageService storageService;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final ThemeMode currentThemeMode;

  const HomeNavigationScreen({
    super.key,
    required this.storageService,
    required this.onThemeModeChanged,
    required this.currentThemeMode,
  });

  @override
  State<HomeNavigationScreen> createState() => _HomeNavigationScreenState();
}

class _HomeNavigationScreenState extends State<HomeNavigationScreen> {
  int _currentIndex = 0;
  bool _isLoading = true;

  List<Recipe> _recipes = [];
  WeeklyMealPlan _mealPlan = const WeeklyMealPlan();
  Set<String> _checkedIngredients = {};

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    setState(() => _isLoading = true);
    final loadedRecipes = await widget.storageService.loadRecipes();
    final loadedMealPlan = await widget.storageService.loadMealPlan();
    final loadedChecked = widget.storageService.loadCheckedIngredients();

    setState(() {
      _recipes = loadedRecipes;
      _mealPlan = loadedMealPlan;
      _checkedIngredients = loadedChecked;
      _isLoading = false;
    });
  }

  // Recipe Favorite Toggle
  Future<void> _toggleFavorite(String recipeId) async {
    final updated = _recipes.map((r) {
      if (r.id == recipeId) {
        return r.copyWith(isFavorite: !r.isFavorite);
      }
      return r;
    }).toList();

    setState(() {
      _recipes = updated;
    });
    await widget.storageService.saveRecipes(updated);
  }

  // Add Recipe to Weekly Plan
  Future<void> _addMealToPlan(DayOfWeek day, MealSlot slot, Recipe recipe) async {
    final updatedPlan = _mealPlan.addOrReplace(
      day: day,
      slot: slot,
      recipe: recipe,
    );

    setState(() {
      _mealPlan = updatedPlan;
    });
    await widget.storageService.saveMealPlan(updatedPlan);
  }

  // Remove Entry from Plan
  Future<void> _removePlanEntry(String entryId) async {
    final updatedPlan = _mealPlan.removeEntry(entryId);
    setState(() {
      _mealPlan = updatedPlan;
    });
    await widget.storageService.saveMealPlan(updatedPlan);
  }

  // Clear Entire Weekly Plan
  Future<void> _clearPlan() async {
    final updatedPlan = _mealPlan.clearAll();
    setState(() {
      _mealPlan = updatedPlan;
    });
    await widget.storageService.saveMealPlan(updatedPlan);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Weekly meal plan cleared.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Save Custom Recipe
  Future<void> _saveCustomRecipe(Recipe newRecipe) async {
    final updated = [newRecipe, ..._recipes];
    setState(() {
      _recipes = updated;
    });
    await widget.storageService.saveRecipes(updated);
  }

  // Update Shopping Checked State
  Future<void> _updateCheckedIngredients(Set<String> updated) async {
    setState(() {
      _checkedIngredients = updated;
    });
    await widget.storageService.saveCheckedIngredients(updated);
  }

  void _openAddRecipeScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddRecipeScreen(onSaveRecipe: _saveCustomRecipe),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = widget.currentThemeMode == ThemeMode.dark;

    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: theme.colorScheme.primary),
              const SizedBox(height: 16),
              const Text('Loading MealCraft culinary space...'),
            ],
          ),
        ),
      );
    }

    final pages = [
      RecipeBrowseScreen(
        recipes: _recipes,
        mealPlan: _mealPlan,
        onToggleFavorite: _toggleFavorite,
        onAddToPlan: _addMealToPlan,
        onNavigateToMealPlan: () => setState(() => _currentIndex = 1),
        onAddNewRecipe: _openAddRecipeScreen,
      ),
      WeeklyMealPlanScreen(
        mealPlan: _mealPlan,
        availableRecipes: _recipes,
        onAddMeal: _addMealToPlan,
        onRemoveEntry: _removePlanEntry,
        onClearAll: _clearPlan,
        onToggleFavorite: _toggleFavorite,
        checkedIngredients: _checkedIngredients,
        onUpdateCheckedIngredients: _updateCheckedIngredients,
        onNavigateToGroceries: () => setState(() => _currentIndex = 2),
      ),
      GroceryListScreen(
        plannedRecipes: _mealPlan.allPlannedRecipes,
        initialCheckedKeys: _checkedIngredients,
        onCheckedKeysChanged: _updateCheckedIngredients,
      ),
      FavoritesScreen(
        recipes: _recipes,
        onToggleFavorite: _toggleFavorite,
        onAddToPlan: _addMealToPlan,
        onAddNewRecipe: _openAddRecipeScreen,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        elevation: 0,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/app_logo.png',
                width: 34,
                height: 34,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFFEE671C) : const Color(0xFF9E3D00),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.restaurant_rounded,
                    color: Colors.white,
                    size: 19,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'MEALCRAFT',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: isDark ? const Color(0xFFEE671C) : const Color(0xFF9E3D00),
                  ),
                ),
                Text(
                  _currentIndex == 1
                      ? 'Meal Plan'
                      : (_currentIndex == 0
                          ? 'Browse'
                          : (_currentIndex == 2 ? 'Combined Grocery List' : 'Favorites')),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Theme Toggle
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              size: 20,
            ),
            tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            onPressed: () {
              widget.onThemeModeChanged(isDark ? ThemeMode.light : ThemeMode.dark);
            },
          ),
          // Notification Bell with Badge Dot
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded, size: 21),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All weekly meal prep notifications are active.'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              Positioned(
                top: 13,
                right: 13,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF50E380) : const Color(0xFF9E3D00),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          // User Profile Avatar
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 4),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: 'Browse',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: _mealPlan.totalMealsCount > 0,
              label: Text('${_mealPlan.totalMealsCount}'),
              child: const Icon(Icons.calendar_month_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: _mealPlan.totalMealsCount > 0,
              label: Text('${_mealPlan.totalMealsCount}'),
              child: const Icon(Icons.calendar_month_rounded),
            ),
            label: 'Meal Plan',
          ),
          const NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(Icons.shopping_bag_rounded),
            label: 'Groceries',
          ),
          const NavigationDestination(
            icon: Icon(Icons.favorite_border_rounded),
            selectedIcon: Icon(Icons.favorite_rounded),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
