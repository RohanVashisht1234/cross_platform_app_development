import 'package:flutter_test/flutter_test.dart';
import 'package:mealcraft/models/day_of_week.dart';
import 'package:mealcraft/models/difficulty.dart';
import 'package:mealcraft/models/ingredient.dart';
import 'package:mealcraft/models/meal_slot.dart';
import 'package:mealcraft/models/recipe.dart';
import 'package:mealcraft/models/weekly_meal_plan.dart';

void main() {
  group('WeeklyMealPlan Model Tests', () {
    final testRecipe = Recipe(
      id: 'rec_test_1',
      title: 'Avocado Toast',
      description: 'Quick toast',
      category: 'Breakfast',
      imageUrl: '',
      prepTimeMinutes: 5,
      cookTimeMinutes: 5,
      difficulty: Difficulty.easy,
      servings: 2,
      calories: 280,
      ingredients: [
        const Ingredient(
          name: 'Bread',
          amount: 2,
          unit: 'slices',
          category: IngredientCategory.bakery,
        ),
      ],
      instructions: ['Toast and spread.'],
    );

    test('Adding and replacing meals per day and slot works correctly', () {
      var plan = const WeeklyMealPlan();
      expect(plan.totalMealsCount, equals(0));
      expect(plan.plannedDaysCount, equals(0));

      // Add to Monday breakfast
      plan = plan.addOrReplace(
        day: DayOfWeek.monday,
        slot: MealSlot.breakfast,
        recipe: testRecipe,
      );

      expect(plan.totalMealsCount, equals(1));
      expect(plan.plannedDaysCount, equals(1));
      expect(plan.getEntriesForDay(DayOfWeek.monday).length, equals(1));

      // Adding to same day and same slot replaces existing entry
      final updatedRecipe = testRecipe.copyWith(title: 'Sourdough Avocado Toast');
      plan = plan.addOrReplace(
        day: DayOfWeek.monday,
        slot: MealSlot.breakfast,
        recipe: updatedRecipe,
      );

      expect(plan.totalMealsCount, equals(1)); // Still 1
      expect(plan.getEntry(DayOfWeek.monday, MealSlot.breakfast)?.recipe.title, equals('Sourdough Avocado Toast'));

      // Add to Wednesday dinner
      plan = plan.addOrReplace(
        day: DayOfWeek.wednesday,
        slot: MealSlot.dinner,
        recipe: testRecipe,
      );

      expect(plan.totalMealsCount, equals(2));
      expect(plan.plannedDaysCount, equals(2));
    });

    test('Serialization to and from JSON preserves entire meal plan integrity', () {
      var original = const WeeklyMealPlan();
      original = original.addOrReplace(
        day: DayOfWeek.friday,
        slot: MealSlot.dinner,
        recipe: testRecipe,
      );

      final json = original.toJson();
      final restored = WeeklyMealPlan.fromJson(json);

      expect(restored.totalMealsCount, equals(1));
      final entry = restored.getEntry(DayOfWeek.friday, MealSlot.dinner);
      expect(entry, isNotNull);
      expect(entry!.recipe.title, equals('Avocado Toast'));
      expect(entry.recipe.prepTimeMinutes, equals(5));
      expect(entry.recipe.difficulty, equals(Difficulty.easy));
    });

    test('Clearing day and clearing all works', () {
      var plan = const WeeklyMealPlan();
      plan = plan.addOrReplace(day: DayOfWeek.monday, slot: MealSlot.lunch, recipe: testRecipe);
      plan = plan.addOrReplace(day: DayOfWeek.friday, slot: MealSlot.dinner, recipe: testRecipe);
      expect(plan.totalMealsCount, equals(2));

      plan = plan.clearDay(DayOfWeek.monday);
      expect(plan.totalMealsCount, equals(1));
      expect(plan.getEntriesForDay(DayOfWeek.monday).isEmpty, isTrue);

      plan = plan.clearAll();
      expect(plan.totalMealsCount, equals(0));
    });
  });
}
