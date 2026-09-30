import 'package:flutter/material.dart';

/// Categories to organize ingredients in shopping checklists.
enum IngredientCategory {
  produce('Fresh Produce & Aromatics', Icons.eco_rounded, Color(0xFF1B6D24)),
  dairy('Dairy & Plant-Based', Icons.local_drink_rounded, Color(0xFF0288D1)),
  proteins('Proteins, Poultry & Meat', Icons.restaurant_menu_rounded, Color(0xFFC2185B)),
  pantry('Pantry Staples', Icons.kitchen_rounded, Color(0xFF8D6E63)),
  spices('Herbs & Whole Spices', Icons.spa_rounded, Color(0xFF7B1FA2)),
  bakery('Bakery & Breads', Icons.bakery_dining_rounded, Color(0xFFF57C00)),
  other('Other Staples', Icons.shopping_basket_rounded, Color(0xFF607D8B));

  final String label;
  final IconData icon;
  final Color color;

  const IngredientCategory(this.label, this.icon, this.color);

  static IngredientCategory fromString(String? value) {
    if (value == null) return IngredientCategory.pantry;
    final normalized = value.toLowerCase().trim();
    if (normalized == 'proteins' ||
        normalized.contains('protein') ||
        normalized.contains('meat') ||
        normalized.contains('poultry') ||
        normalized.contains('seafood')) {
      return IngredientCategory.proteins;
    }
    return IngredientCategory.values.firstWhere(
      (c) => c.name == normalized || c.label.toLowerCase() == normalized,
      orElse: () => IngredientCategory.other,
    );
  }
}

/// Represents an ingredient required by a recipe.
class Ingredient {
  final String name;
  final double amount;
  final String unit;
  final IngredientCategory category;
  final String? notes;
  final bool isBought;

  const Ingredient({
    required this.name,
    required this.amount,
    required this.unit,
    this.category = IngredientCategory.pantry,
    this.notes,
    this.isBought = false,
  });

  /// Returns a clean, human-readable string for the quantity (e.g. "1 ½" or "250").
  String get formattedQuantity {
    if (amount <= 0) return '';

    // Handle common fractions
    final intPart = amount.floor();
    final fraction = amount - intPart;

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

    // Otherwise format without trailing .0 if integer
    if (amount == intPart.toDouble()) {
      return intPart.toString();
    }
    return amount.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '');
  }

  /// Full display string such as "200 g" or "2 tbsp".
  String get displayAmountWithUnit {
    final qty = formattedQuantity;
    if (qty.isEmpty) return unit.trim();
    if (unit.trim().isEmpty) return qty;
    return '$qty ${unit.trim()}';
  }

  /// Creates a copy with optionally modified fields.
  Ingredient copyWith({
    String? name,
    double? amount,
    String? unit,
    IngredientCategory? category,
    String? notes,
    bool? isBought,
  }) {
    return Ingredient(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      category: category ?? this.category,
      notes: notes ?? this.notes,
      isBought: isBought ?? this.isBought,
    );
  }

  /// Scales the ingredient amount by a given multiplier (e.g., for serving scaling).
  Ingredient scale(double factor) {
    return copyWith(amount: amount * factor);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'unit': unit,
      'category': category.name,
      if (notes != null) 'notes': notes,
      'isBought': isBought,
    };
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] as String? ?? 'Ingredient',
      amount: (json['amount'] as num?)?.toDouble() ?? 1.0,
      unit: json['unit'] as String? ?? '',
      category: IngredientCategory.fromString(json['category'] as String?),
      notes: json['notes'] as String?,
      isBought: json['isBought'] as bool? ?? false,
    );
  }

  @override
  String toString() => '$displayAmountWithUnit $name';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ingredient &&
          runtimeType == other.runtimeType &&
          name.toLowerCase() == other.name.toLowerCase() &&
          unit.toLowerCase() == other.unit.toLowerCase();

  @override
  int get hashCode => name.toLowerCase().hashCode ^ unit.toLowerCase().hashCode;
}
