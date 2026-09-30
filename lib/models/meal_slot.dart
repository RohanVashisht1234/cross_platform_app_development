import 'package:flutter/material.dart';

/// Represents a meal slot during a day.
enum MealSlot {
  breakfast('Breakfast', Icons.wb_twilight_rounded, Color(0xFFF57C00)),
  lunch('Lunch', Icons.wb_sunny_rounded, Color(0xFFE65100)),
  dinner('Dinner', Icons.nights_stay_rounded, Color(0xFF5C6BC0)),
  snack('Snack', Icons.cookie_rounded, Color(0xFF8D6E63));

  final String label;
  final IconData icon;
  final Color accentColor;

  const MealSlot(this.label, this.icon, this.accentColor);

  static MealSlot fromString(String? value) {
    if (value == null) return MealSlot.dinner;
    final normalized = value.toLowerCase().trim();
    return MealSlot.values.firstWhere(
      (s) => s.name == normalized || s.label.toLowerCase() == normalized,
      orElse: () => MealSlot.dinner,
    );
  }
}
