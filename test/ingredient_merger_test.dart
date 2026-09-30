import 'package:flutter_test/flutter_test.dart';
import 'package:mealcraft/models/difficulty.dart';
import 'package:mealcraft/models/ingredient.dart';
import 'package:mealcraft/models/recipe.dart';
import 'package:mealcraft/services/ingredient_merger.dart';

void main() {
  group('IngredientMerger Unit Tests', () {
    final recipeA = Recipe(
      id: 'test_a',
      title: 'Ginger Butter Rice',
      description: 'Fragrant butter rice',
      category: 'Indian',
      imageUrl: '',
      prepTimeMinutes: 5,
      cookTimeMinutes: 10,
      difficulty: Difficulty.easy,
      ingredients: [
        const Ingredient(
          name: 'Olive Oil',
          amount: 2.0,
          unit: 'tbsp',
          category: IngredientCategory.pantry,
        ),
        const Ingredient(
          name: 'Fresh Ginger',
          amount: 3.0,
          unit: 'tsp',
          category: IngredientCategory.produce,
        ),
      ],
      instructions: ['Boil and toss.'],
    );

    final recipeB = Recipe(
      id: 'test_b',
      title: 'Herbed Ginger Toast',
      description: 'Crispy bread',
      category: 'Appetizers',
      imageUrl: '',
      prepTimeMinutes: 5,
      cookTimeMinutes: 5,
      difficulty: Difficulty.easy,
      ingredients: [
        const Ingredient(
          name: 'olive oil', // Case-insensitive test
          amount: 3.0,
          unit: 'tbsp',
          category: IngredientCategory.pantry,
        ),
        const Ingredient(
          name: 'Fresh Ginger',
          amount: 2.0,
          unit: 'tsp',
          category: IngredientCategory.produce,
        ),
        const Ingredient(
          name: 'Sourdough Bread',
          amount: 4.0,
          unit: 'slices',
          category: IngredientCategory.bakery,
        ),
      ],
      instructions: ['Toast and rub.'],
    );

    test('Deduplicates and sums quantities across multiple recipes via Map', () {
      final merged = IngredientMerger.mergeRecipes([recipeA, recipeB]);

      // Should have 3 unique items: Fresh Ginger, Olive Oil, Sourdough Bread
      expect(merged.length, equals(3));

      // Find Olive Oil: 2 + 3 = 5 tbsp
      final oliveOil = merged.firstWhere((i) => i.displayName.toLowerCase().contains('olive oil'));
      expect(oliveOil.totalAmount, equals(5.0));
      expect(oliveOil.unit, equals('tbsp'));
      expect(oliveOil.recipeSources, containsAll(['Ginger Butter Rice', 'Herbed Ginger Toast']));

      // Find Fresh Ginger: 3 + 2 = 5 tsp
      final ginger = merged.firstWhere((i) => i.displayName.toLowerCase().contains('ginger'));
      expect(ginger.totalAmount, equals(5.0));
      expect(ginger.unit, equals('tsp'));
      expect(ginger.recipeSources.length, equals(2));

      // Find Bread: 4 slices
      final bread = merged.firstWhere((i) => i.displayName.toLowerCase().contains('bread'));
      expect(bread.totalAmount, equals(4.0));
      expect(bread.recipeSources, equals(['Herbed Ginger Toast']));
    });

    test('Groups merged ingredients by supermarket aisle categories', () {
      final merged = IngredientMerger.mergeRecipes([recipeA, recipeB]);
      final grouped = IngredientMerger.groupByCategory(merged);

      expect(grouped.containsKey(IngredientCategory.produce), isTrue);
      expect(grouped.containsKey(IngredientCategory.pantry), isTrue);
      expect(grouped.containsKey(IngredientCategory.bakery), isTrue);

      expect(grouped[IngredientCategory.produce]!.length, equals(1)); // Fresh Ginger
      expect(grouped[IngredientCategory.pantry]!.length, equals(1)); // Olive oil
      expect(grouped[IngredientCategory.bakery]!.length, equals(1)); // Bread
    });

    test('Ingredient scaling calculates correct quantities for servings', () {
      final scaled = recipeA.getScaledIngredients(8); // Scaled from 4 to 8 servings (2x)
      final scaledOil = scaled.firstWhere((i) => i.name == 'Olive Oil');
      expect(scaledOil.amount, equals(4.0)); // 2.0 * 2 = 4.0
    });
  });
}
