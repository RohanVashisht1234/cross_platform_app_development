import 'package:flutter/material.dart';

/// Represents the culinary difficulty level of a recipe.
enum Difficulty {
  easy('Easy', Icons.speed_rounded, Color(0xFF2E7D32), Color(0xFFE8F5E9)),
  medium('Medium', Icons.tune_rounded, Color(0xFFE65100), Color(0xFFFFF3E0)),
  hard('Hard', Icons.local_fire_department_rounded, Color(0xFFC62828), Color(0xFFFFEBEE));

  final String label;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  const Difficulty(this.label, this.icon, this.color, this.backgroundColor);

  /// Deserializes a string into a [Difficulty] enum. Defaults to [medium].
  static Difficulty fromString(String? value) {
    if (value == null) return Difficulty.medium;
    return Difficulty.values.firstWhere(
      (d) => d.name.toLowerCase() == value.toLowerCase() || d.label.toLowerCase() == value.toLowerCase(),
      orElse: () => Difficulty.medium,
    );
  }
}
