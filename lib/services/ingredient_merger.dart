import '../models/ingredient.dart';
import '../models/recipe.dart';

/// Represents a consolidated ingredient derived from multiple planned recipes.
class MergedIngredient {
  final String key;
  final String displayName;
  final double totalAmount;
  final String unit;
  final IngredientCategory category;
  final List<String> recipeSources;
  final bool isBought;

  const MergedIngredient({
    required this.key,
    required this.displayName,
    required this.totalAmount,
    required this.unit,
    required this.category,
    required this.recipeSources,
    this.isBought = false,
  });

  /// Human-friendly display string for quantity (e.g., "3 ½" or "500").
  String get formattedQuantity {
    if (totalAmount <= 0) return '';
    final intPart = totalAmount.floor();
    final fraction = totalAmount - intPart;

    String fractionStr = '';
    if ((fraction - 0.5).abs() < 0.05) {
      fractionStr = '½';
    } else if ((fraction - 0.25).abs() < 0.05) {
      fractionStr = '¼';
    } else if ((fraction - 0.75).abs() < 0.05) {
      fractionStr = '¾';
    } else if ((fraction - 0.33).abs() < 0.05 || (fraction - 0.333).abs() < 0.05) {
      fractionStr = '⅓';
    } else if ((fraction - 0.66).abs() < 0.05 || (fraction - 0.667).abs() < 0.05) {
      fractionStr = '⅔';
    }

    if (fractionStr.isNotEmpty) {
      if (intPart == 0) return fractionStr;
      return '$intPart $fractionStr';
    }

    if (totalAmount == intPart.toDouble()) {
      return intPart.toString();
    }
    return totalAmount.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');
  }

  /// Full display of quantity and unit, e.g. "500 g" or "3 tbsp".
  String get displayAmountWithUnit {
    final qty = formattedQuantity;
    if (qty.isEmpty) return unit.trim();
    if (unit.trim().isEmpty) return qty;
    return '$qty ${unit.trim()}';
  }

  MergedIngredient copyWith({
    String? key,
    String? displayName,
    double? totalAmount,
    String? unit,
    IngredientCategory? category,
    List<String>? recipeSources,
    bool? isBought,
  }) {
    return MergedIngredient(
      key: key ?? this.key,
      displayName: displayName ?? this.displayName,
      totalAmount: totalAmount ?? this.totalAmount,
      unit: unit ?? this.unit,
      category: category ?? this.category,
      recipeSources: recipeSources ?? this.recipeSources,
      isBought: isBought ?? this.isBought,
    );
  }
}

/// Core Dart logic to aggregate and merge duplicate ingredients using a Dart Map.
///
/// Implements the problem statement requirement:
/// "Dart Logic: Model Recipe as a Dart class with an ingredients List, and merge
/// multiple recipes' ingredients using a Map for the weekly list."
class IngredientMerger {
  /// Merges all ingredients across an arbitrary list of [recipes] into a consolidated list.
  ///
  /// Uses a Dart `Map<String, _Accumulator>` to group identical ingredients by their
  /// normalized name and unit, summing quantities and tracking source recipe titles.
  static List<MergedIngredient> mergeRecipes(
    List<Recipe> recipes, {
    Set<String> checkedKeys = const {},
  }) {
    // Dart Map key: normalized_name + '___' + normalized_unit
    final Map<String, _Accumulator> map = {};

    for (final recipe in recipes) {
      for (final ingredient in recipe.ingredients) {
        final normalizedName = _normalizeName(ingredient.name);
        final normalizedUnit = _normalizeUnit(ingredient.unit);
        final key = '${normalizedName}___$normalizedUnit';

        if (map.containsKey(key)) {
          final existing = map[key]!;
          existing.totalAmount += ingredient.amount;
          if (!existing.sources.contains(recipe.title)) {
            existing.sources.add(recipe.title);
          }
        } else {
          map[key] = _Accumulator(
            key: key,
            displayName: _capitalize(ingredient.name.trim()),
            totalAmount: ingredient.amount,
            unit: normalizedUnit,
            category: ingredient.category,
            sources: [recipe.title],
          );
        }
      }
    }

    // Convert Map values to sorted MergedIngredient list
    final List<MergedIngredient> result = map.values.map((acc) {
      return MergedIngredient(
        key: acc.key,
        displayName: acc.displayName,
        totalAmount: acc.totalAmount,
        unit: acc.unit,
        category: acc.category,
        recipeSources: acc.sources,
        isBought: checkedKeys.contains(acc.key),
      );
    }).toList();

    // Sort by category index, then alphabetically
    result.sort((a, b) {
      final catCompare = a.category.index.compareTo(b.category.index);
      if (catCompare != 0) return catCompare;
      return a.displayName.compareTo(b.displayName);
    });

    return result;
  }

  /// Groups merged ingredients by their supermarket [IngredientCategory] using a Dart Map.
  static Map<IngredientCategory, List<MergedIngredient>> groupByCategory(
    List<MergedIngredient> items,
  ) {
    final Map<IngredientCategory, List<MergedIngredient>> grouped = {};
    for (final item in items) {
      grouped.putIfAbsent(item.category, () => []).add(item);
    }
    return grouped;
  }

  /// Normalizes ingredient name for fuzzy matching (case-insensitive, trims plurals).
  static String _normalizeName(String name) {
    var clean = name.toLowerCase().trim();
    // Common plural cleanups
    if (clean.endsWith('es') && clean.length > 4 && !clean.endsWith('cheese')) {
      clean = clean.substring(0, clean.length - 2);
    } else if (clean.endsWith('s') && clean.length > 3 && !clean.endsWith('ss')) {
      clean = clean.substring(0, clean.length - 1);
    }
    return clean;
  }

  /// Standardizes unit abbreviations.
  static String _normalizeUnit(String unit) {
    final u = unit.toLowerCase().trim();
    switch (u) {
      case 'tablespoon':
      case 'tablespoons':
      case 'tbsp':
      case 'tbs':
        return 'tbsp';
      case 'teaspoon':
      case 'teaspoons':
      case 'tsp':
        return 'tsp';
      case 'cup':
      case 'cups':
        return 'cups';
      case 'gram':
      case 'grams':
      case 'g':
        return 'g';
      case 'kilogram':
      case 'kg':
      case 'kgs':
        return 'kg';
      case 'milliliter':
      case 'milliliters':
      case 'ml':
        return 'ml';
      case 'liter':
      case 'liters':
      case 'l':
        return 'L';
      case 'clove':
      case 'cloves':
        return 'cloves';
      case 'piece':
      case 'pieces':
      case 'pcs':
        return 'pcs';
      case 'slice':
      case 'slices':
        return 'slices';
      case 'can':
      case 'cans':
        return 'cans';
      case 'stalk':
      case 'stalks':
        return 'stalks';
      default:
        return u;
    }
  }

  static String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}

/// Internal helper accumulator used during the Map aggregation step.
class _Accumulator {
  final String key;
  final String displayName;
  double totalAmount;
  final String unit;
  final IngredientCategory category;
  final List<String> sources;

  _Accumulator({
    required this.key,
    required this.displayName,
    required this.totalAmount,
    required this.unit,
    required this.category,
    required this.sources,
  });
}
