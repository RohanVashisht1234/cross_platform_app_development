import 'day_of_week.dart';
import 'meal_plan_entry.dart';
import 'meal_slot.dart';
import 'recipe.dart';

/// Encapsulates the entire 7-day schedule of planned meals.
class WeeklyMealPlan {
  final List<MealPlanEntry> entries;

  const WeeklyMealPlan({this.entries = const []});

  /// Retrieves all meal entries assigned to a specific day of the week.
  List<MealPlanEntry> getEntriesForDay(DayOfWeek day) {
    return entries.where((e) => e.day == day).toList()
      ..sort((a, b) => a.slot.index.compareTo(b.slot.index));
  }

  /// Finds a specific entry by day and meal slot, if scheduled.
  MealPlanEntry? getEntry(DayOfWeek day, MealSlot slot) {
    try {
      return entries.firstWhere((e) => e.day == day && e.slot == slot);
    } catch (_) {
      return null;
    }
  }

  /// Adds a new recipe or replaces the existing entry for a specific day and slot.
  WeeklyMealPlan addOrReplace({
    required DayOfWeek day,
    required MealSlot slot,
    required Recipe recipe,
  }) {
    final updatedList = List<MealPlanEntry>.from(entries);
    // Remove existing if any
    updatedList.removeWhere((e) => e.day == day && e.slot == slot);
    // Add new
    updatedList.add(
      MealPlanEntry(
        id: '${day.name}_${slot.name}_${DateTime.now().millisecondsSinceEpoch}',
        day: day,
        slot: slot,
        recipe: recipe,
      ),
    );
    return WeeklyMealPlan(entries: updatedList);
  }

  /// Removes an entry by its unique ID.
  WeeklyMealPlan removeEntry(String entryId) {
    final updatedList = entries.where((e) => e.id != entryId).toList();
    return WeeklyMealPlan(entries: updatedList);
  }

  /// Removes all entries for a specific day.
  WeeklyMealPlan clearDay(DayOfWeek day) {
    final updatedList = entries.where((e) => e.day != day).toList();
    return WeeklyMealPlan(entries: updatedList);
  }

  /// Clears the entire week.
  WeeklyMealPlan clearAll() {
    return const WeeklyMealPlan(entries: []);
  }

  /// Total count of scheduled meals this week.
  int get totalMealsCount => entries.length;

  /// Count of distinct days having at least one scheduled meal (out of 7).
  int get plannedDaysCount {
    return entries.map((e) => e.day).toSet().length;
  }

  /// All unique recipes scheduled across the entire week.
  List<Recipe> get uniqueRecipes {
    final Map<String, Recipe> map = {};
    for (final entry in entries) {
      map[entry.recipe.id] = entry.recipe;
    }
    return map.values.toList();
  }

  /// All recipe instances planned across the week (including duplicates across days).
  List<Recipe> get allPlannedRecipes => entries.map((e) => e.recipe).toList();

  Map<String, dynamic> toJson() {
    return {
      'entries': entries.map((e) => e.toJson()).toList(),
    };
  }

  factory WeeklyMealPlan.fromJson(Map<String, dynamic> json) {
    final list = json['entries'] as List<dynamic>?;
    if (list == null) return const WeeklyMealPlan();
    return WeeklyMealPlan(
      entries: list.map((item) => MealPlanEntry.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }
}
