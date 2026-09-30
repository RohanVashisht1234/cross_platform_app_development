import 'day_of_week.dart';
import 'meal_slot.dart';
import 'recipe.dart';

/// Represents a single meal assignment in the weekly schedule.
class MealPlanEntry {
  final String id;
  final DayOfWeek day;
  final MealSlot slot;
  final Recipe recipe;
  final DateTime assignedAt;

  MealPlanEntry({
    required this.id,
    required this.day,
    required this.slot,
    required this.recipe,
    DateTime? assignedAt,
  }) : assignedAt = assignedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day.name,
      'slot': slot.name,
      'recipe': recipe.toJson(),
      'assignedAt': assignedAt.toIso8601String(),
    };
  }

  factory MealPlanEntry.fromJson(Map<String, dynamic> json) {
    return MealPlanEntry(
      id: json['id'] as String? ?? UniqueKey().toString(),
      day: DayOfWeek.fromString(json['day'] as String?),
      slot: MealSlot.fromString(json['slot'] as String?),
      recipe: Recipe.fromJson(json['recipe'] as Map<String, dynamic>),
      assignedAt: json['assignedAt'] != null
          ? DateTime.tryParse(json['assignedAt'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
