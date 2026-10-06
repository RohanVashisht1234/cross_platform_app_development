import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/recipe.dart';
import '../models/weekly_meal_plan.dart';
import 'sample_data.dart';

/// Manages local storage persistence for recipes, weekly meal plan, and shopping state.
///
/// Implements the problem statement requirement:
/// "All recipes and the current meal plan persist between sessions using local storage."
class StorageService {
  static const String _keyRecipes = 'mealcraft_recipes_v3';
  static const String _keyMealPlan = 'mealcraft_weekly_plan_v3';
  static const String _keyCheckedIngredients = 'mealcraft_checked_ingredients_v3';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  /// Factory initializer to obtain SharedPreferences instance.
  static Future<StorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  // ==========================================
  // RECIPES PERSISTENCE
  // ==========================================

  /// Loads persisted recipes or initializes with [SampleData.initialRecipes] on first run.
  Future<List<Recipe>> loadRecipes() async {
    final rawJson = _prefs.getString(_keyRecipes);
    if (rawJson == null || rawJson.trim().isEmpty) {
      // First app launch: store and return sample recipes
      final initial = SampleData.initialRecipes;
      await saveRecipes(initial);
      return initial;
    }

    try {
      final List<dynamic> decoded = jsonDecode(rawJson) as List<dynamic>;
      final savedRecipes = decoded.map((item) => Recipe.fromJson(item as Map<String, dynamic>)).toList();
      final savedIds = savedRecipes.map((r) => r.id).toSet();

      // Seamlessly merge any new recipes from SampleData that aren't already in storage
      final initial = SampleData.initialRecipes;
      final missingDefaults = initial.where((r) => !savedIds.contains(r.id)).toList();
      if (missingDefaults.isNotEmpty) {
        final merged = [...savedRecipes, ...missingDefaults];
        await saveRecipes(merged);
        return merged;
      }
      return savedRecipes;
    } catch (e) {
      // Fallback in case of corrupted data
      return SampleData.initialRecipes;
    }
  }

  /// Saves the complete list of recipes to local storage.
  Future<bool> saveRecipes(List<Recipe> recipes) async {
    final encoded = jsonEncode(recipes.map((r) => r.toJson()).toList());
    return await _prefs.setString(_keyRecipes, encoded);
  }

  // ==========================================
  // WEEKLY MEAL PLAN PERSISTENCE
  // ==========================================

  /// Loads the saved weekly meal plan, defaulting to an empty plan.
  Future<WeeklyMealPlan> loadMealPlan() async {
    final rawJson = _prefs.getString(_keyMealPlan);
    if (rawJson == null || rawJson.trim().isEmpty) {
      return const WeeklyMealPlan();
    }

    try {
      final Map<String, dynamic> decoded = jsonDecode(rawJson) as Map<String, dynamic>;
      return WeeklyMealPlan.fromJson(decoded);
    } catch (e) {
      return const WeeklyMealPlan();
    }
  }

  /// Persists the updated weekly meal plan to local storage.
  Future<bool> saveMealPlan(WeeklyMealPlan plan) async {
    final encoded = jsonEncode(plan.toJson());
    return await _prefs.setString(_keyMealPlan, encoded);
  }

  // ==========================================
  // SHOPPING CHECKLIST PERSISTENCE
  // ==========================================

  /// Loads the set of checked ingredient keys.
  Set<String> loadCheckedIngredients() {
    final list = _prefs.getStringList(_keyCheckedIngredients);
    return list?.toSet() ?? {};
  }

  /// Persists the set of checked ingredient keys.
  Future<bool> saveCheckedIngredients(Set<String> keys) async {
    return await _prefs.setStringList(_keyCheckedIngredients, keys.toList());
  }

  /// Clears all stored data (useful for reset/debugging).
  Future<void> clearAll() async {
    await _prefs.remove(_keyRecipes);
    await _prefs.remove(_keyMealPlan);
    await _prefs.remove(_keyCheckedIngredients);
  }
}
