import 'package:flutter/material.dart';
import '../models/day_of_week.dart';
import '../models/meal_plan_entry.dart';
import '../models/recipe.dart';
import 'app_recipe_image.dart';

/// Card widget representing a single day in the Weekly Meal Plan 2-Column Grid,
/// matching the exact visual specifications of the Figma mockups.
class DayPlanCard extends StatelessWidget {
  final DayOfWeek day;
  final List<MealPlanEntry> entries;
  final bool isToday;
  final VoidCallback onAddMeal;
  final Function(Recipe recipe) onRecipeTap;
  final Function(String entryId) onRemoveEntry;

  const DayPlanCard({
    super.key,
    required this.day,
    required this.entries,
    required this.isToday,
    required this.onAddMeal,
    required this.onRecipeTap,
    required this.onRemoveEntry,
  });

  String _getDateSubtitle() {
    switch (day) {
      case DayOfWeek.monday:
        return 'MON • OCT 21';
      case DayOfWeek.tuesday:
        return 'TUE • OCT 22';
      case DayOfWeek.wednesday:
        return 'WED • OCT 23';
      case DayOfWeek.thursday:
        return 'THU • OCT 24';
      case DayOfWeek.friday:
        return 'FRI • OCT 25';
      case DayOfWeek.saturday:
        return 'SAT • OCT 26';
      case DayOfWeek.sunday:
        return 'SUN • OCT 27';
    }
  }

  String _getDayTitle() {
    if (isToday) return 'Today';
    switch (day) {
      case DayOfWeek.monday:
        return 'Today';
      case DayOfWeek.tuesday:
        return 'Tomorrow';
      case DayOfWeek.wednesday:
        return 'Midweek';
      case DayOfWeek.thursday:
        return 'Curry Night?';
      case DayOfWeek.friday:
        return 'Dal Makhani Friday';
      case DayOfWeek.saturday:
        return 'Royal Feast';
      case DayOfWeek.sunday:
        return 'Sunday Prep & Slow Cooking';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hasMeals = entries.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isToday
              ? (isDark ? const Color(0xFFEE671C) : const Color(0xFF9E3D00))
              : (isDark ? const Color(0xFF2C2C2C) : const Color(0xFFECE7DE)),
          width: isToday ? 1.8 : 1.0,
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Date & Status Badge / Add Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getDateSubtitle(),
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                  color: isDark ? const Color(0xFF9E9E9E) : const Color(0xFF8E8880),
                ),
              ),
              if (isToday)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'TODAY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                )
              else
                InkWell(
                  onTap: onAddMeal,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF2D2D2D)
                          : const Color(0xFFF0ECE3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      size: 13,
                      color: isDark ? Colors.white70 : const Color(0xFF6B655D),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 3),

          // Main Day Headline (Today, Tomorrow, Midweek, etc.)
          Text(
            _getDayTitle(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),

          // Body: Either populated meal card or empty slot prompt
          Expanded(
            child: hasMeals
                ? _buildPopulatedMealCard(context, entries.first, isDark)
                : _buildEmptySlotCard(context, isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildPopulatedMealCard(
      BuildContext context, MealPlanEntry entry, bool isDark) {
    final totalTime = entry.recipe.prepTimeMinutes + entry.recipe.cookTimeMinutes;

    return Material(
      color: isDark ? const Color(0xFF161616) : const Color(0xFFF9F8F5),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => onRecipeTap(entry.recipe),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFEBE6DC),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Slot Row: Icon + DINNER + Remove/Close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        entry.slot.icon,
                        size: 11,
                        color: isDark ? const Color(0xFFEE671C) : const Color(0xFF9E3D00),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        entry.slot.label.toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          color: isDark ? const Color(0xFFEE671C) : const Color(0xFF9E3D00),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => onRemoveEntry(entry.id),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Icon(
                        Icons.close_rounded,
                        size: 13,
                        color: isDark ? Colors.white60 : const Color(0xFF757068),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),

              // Recipe Photo with rounded corners
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AppRecipeImage(
                        imageUrl: entry.recipe.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 6),

              // Recipe Title
              Text(
                entry.recipe.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 4),

              // Footer: Servings & Cooking Time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.group_outlined,
                        size: 11,
                        color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF4A433D),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${entry.recipe.servings} serv',
                        style: TextStyle(
                          fontSize: 9.5,
                          color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF4A433D),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '$totalTime min',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      color: isDark ? const Color(0xFFEE671C) : const Color(0xFF9E3D00),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptySlotCard(BuildContext context, bool isDark) {
    final isThursday = day == DayOfWeek.thursday;

    return Material(
      color: isDark ? const Color(0xFF161616) : const Color(0xFFF7F5F0),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onAddMeal,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? const Color(0xFF262626) : const Color(0xFFEBE6DC),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? const Color(0xFF242424) : const Color(0xFFEAE5DC),
                ),
                child: Icon(
                  isThursday ? Icons.restaurant_rounded : Icons.add_rounded,
                  size: 18,
                  color: isDark ? Colors.white70 : const Color(0xFF5E574E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Assign Recipe',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF201F1F),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                isThursday ? 'Explore recommendations' : 'Quick prep or takeout',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF5A524A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
