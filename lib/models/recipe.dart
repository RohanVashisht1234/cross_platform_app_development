import 'difficulty.dart';
import 'ingredient.dart';

/// Models a culinary recipe with comprehensive details, ingredients, and instructions.
class Recipe {
  final String id;
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final Difficulty difficulty;
  final int servings;
  final int calories;
  final List<Ingredient> ingredients;
  final List<String> instructions;
  final List<String> tags;
  final bool isFavorite;
  final bool isCustom;

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.difficulty,
    this.servings = 4,
    this.calories = 450,
    required this.ingredients,
    required this.instructions,
    this.tags = const [],
    this.isFavorite = false,
    this.isCustom = false,
  });

  /// Total preparation and cooking duration combined.
  int get totalTimeMinutes => prepTimeMinutes + cookTimeMinutes;

  String get formattedPrepTime => '${prepTimeMinutes}m';
  String get formattedCookTime => '${cookTimeMinutes}m';
  String get formattedTotalTime => '${totalTimeMinutes}m';

  /// Returns scaled ingredients for a targeted serving size.
  List<Ingredient> getScaledIngredients(int targetServings) {
    if (servings <= 0 || targetServings == servings) return ingredients;
    final factor = targetServings / servings;
    return ingredients.map((i) => i.scale(factor)).toList();
  }

  /// Convenience alias for [getScaledIngredients].
  List<Ingredient> scaleIngredients(int targetServings) => getScaledIngredients(targetServings);

  Recipe copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? imageUrl,
    int? prepTimeMinutes,
    int? cookTimeMinutes,
    Difficulty? difficulty,
    int? servings,
    int? calories,
    List<Ingredient>? ingredients,
    List<String>? instructions,
    List<String>? tags,
    bool? isFavorite,
    bool? isCustom,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      cookTimeMinutes: cookTimeMinutes ?? this.cookTimeMinutes,
      difficulty: difficulty ?? this.difficulty,
      servings: servings ?? this.servings,
      calories: calories ?? this.calories,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
      isCustom: isCustom ?? this.isCustom,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'prepTimeMinutes': prepTimeMinutes,
      'cookTimeMinutes': cookTimeMinutes,
      'difficulty': difficulty.name,
      'servings': servings,
      'calories': calories,
      'ingredients': ingredients.map((i) => i.toJson()).toList(),
      'instructions': instructions,
      'tags': tags,
      'isFavorite': isFavorite,
      'isCustom': isCustom,
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String? ?? UniqueKey().toString(),
      title: json['title'] as String? ?? 'Untitled Recipe',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? 'General',
      imageUrl: json['imageUrl'] as String? ?? '',
      prepTimeMinutes: (json['prepTimeMinutes'] as num?)?.toInt() ?? 15,
      cookTimeMinutes: (json['cookTimeMinutes'] as num?)?.toInt() ?? 20,
      difficulty: Difficulty.fromString(json['difficulty'] as String?),
      servings: (json['servings'] as num?)?.toInt() ?? 4,
      calories: (json['calories'] as num?)?.toInt() ?? 400,
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((item) => Ingredient.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      instructions: (json['instructions'] as List<dynamic>?)
              ?.map((item) => item.toString())
              .toList() ??
          [],
      tags: (json['tags'] as List<dynamic>?)?.map((t) => t.toString()).toList() ?? [],
      isFavorite: json['isFavorite'] as bool? ?? false,
      isCustom: json['isCustom'] as bool? ?? false,
    );
  }
}

class UniqueKey {
  @override
  String toString() => DateTime.now().microsecondsSinceEpoch.toString();
}
