import 'package:flutter/material.dart';
import '../models/day_of_week.dart';
import '../models/meal_slot.dart';
import '../models/recipe.dart';
import 'app_recipe_image.dart';

/// Modal bottom sheet allowing the user to schedule a recipe into the weekly meal plan,
/// meticulously recreated to match the Figma Schedule Meal Modal in both Light and Dark mode.
class AddToPlanSheet extends StatefulWidget {
  final Recipe recipe;
  final DayOfWeek? initialDay;
  final MealSlot? initialSlot;
  final Function(DayOfWeek day, MealSlot slot, Recipe recipe) onConfirm;

  const AddToPlanSheet({
    super.key,
    required this.recipe,
    this.initialDay,
    this.initialSlot,
    required this.onConfirm,
  });

  static Future<void> show(
    BuildContext context, {
    required Recipe recipe,
    DayOfWeek? initialDay,
    MealSlot? initialSlot,
    required Function(DayOfWeek day, MealSlot slot, Recipe recipe) onConfirm,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddToPlanSheet(
        recipe: recipe,
        initialDay: initialDay,
        initialSlot: initialSlot,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  State<AddToPlanSheet> createState() => _AddToPlanSheetState();
}

class _AddToPlanSheetState extends State<AddToPlanSheet> {
  late DayOfWeek _selectedDay;
  late MealSlot _selectedSlot;
  late int _servings;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialDay ?? DayOfWeek.fromDateTime(DateTime.now());
    _selectedSlot = widget.initialSlot ?? MealSlot.dinner;
    _servings = widget.recipe.servings;
  }

  String _getDayNumber(DayOfWeek day) {
    final now = DateTime.now();
    final diff = day.isoDayNumber - now.weekday;
    final targetDate = now.add(Duration(days: diff));
    return '${targetDate.day}';
  }

  bool _isDayPreplanned(DayOfWeek day) {
    return day == DayOfWeek.monday ||
        day == DayOfWeek.wednesday ||
        day == DayOfWeek.friday ||
        day == DayOfWeek.saturday;
  }

  String _getTimeForSlot(MealSlot slot) {
    switch (slot) {
      case MealSlot.breakfast:
        return '7:00 – 9:00 AM';
      case MealSlot.lunch:
        return '12:00 – 2:00 PM';
      case MealSlot.dinner:
        return '6:30 – 8:30 PM';
      case MealSlot.snack:
        return 'Anytime';
    }
  }

  IconData _getIconForSlot(MealSlot slot) {
    switch (slot) {
      case MealSlot.breakfast:
        return Icons.wb_twilight_rounded;
      case MealSlot.lunch:
        return Icons.wb_sunny_rounded;
      case MealSlot.dinner:
        return Icons.nights_stay_rounded;
      case MealSlot.snack:
        return Icons.cookie_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF191818) : const Color(0xFFFBF9F5),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(
          color: isDark ? const Color(0xFF333333) : const Color(0xFFECE7DE),
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Drag Handle (matching Figma)
            Center(
              child: Container(
                width: 44,
                height: 4.5,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF3A3A3A) : const Color(0xFFE4CFC4),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Recipe Header Row (Thumbnail, Title, Tags, Subtitle, Close)
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 52,
                    height: 52,
                    child: AppRecipeImage(
                      imageUrl: widget.recipe.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.recipe.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF0F5132) : const Color(0xFFD1E7DD),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              isDark ? '● Pure Vegetarian' : 'Vegetarian',
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                color: isDark ? const Color(0xFF75E59B) : const Color(0xFF0F5132),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Prep: ${widget.recipe.prepTimeMinutes}m • Cook: ${widget.recipe.cookTimeMinutes}m • ${widget.recipe.servings} Servings',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF4A433D),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFECE7DE),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 16,
                      color: isDark ? Colors.white70 : const Color(0xFF5A544C),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Step 1: Select Day Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFFEE671C) : const Color(0xFF9E3D00),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Select Day',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Text(
                  '● 3 Days Planned',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isDark ? const Color(0xFF75E59B) : const Color(0xFF1B6D24),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 7 Day Chips Row
            SizedBox(
              height: 68,
              child: Row(
                children: DayOfWeek.values.map((day) {
                  final isSelected = day == _selectedDay;
                  final isPreplanned = _isDayPreplanned(day);

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.5),
                      child: InkWell(
                        onTap: () => setState(() => _selectedDay = day),
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500))
                                : (isDark ? const Color(0xFF242424) : const Color(0xFFF2EFE8)),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? (isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500))
                                  : (isDark ? const Color(0xFF333333) : const Color(0xFFE5DFC9)),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                day.shortName.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected
                                      ? Colors.white
                                      : (isDark ? const Color(0xFFDDD9D2) : const Color(0xFF2E2A25)),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _getDayNumber(day),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: isSelected
                                      ? Colors.white
                                      : (isDark ? Colors.white : const Color(0xFF141311)),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? Colors.white
                                      : (isPreplanned
                                          ? (isDark ? const Color(0xFF50E380) : const Color(0xFF1B6D24))
                                          : Colors.transparent),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 18),

            // Step 2: Select Meal Slot Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFFEE671C) : const Color(0xFF9E3D00),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Select Meal Slot',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Text(
                  _selectedDay.fullName,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 2x2 Grid of Meal Slot Cards
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2.1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: MealSlot.values.map((slot) {
                final isSelected = slot == _selectedSlot;

                return InkWell(
                  onTap: () => setState(() => _selectedSlot = slot),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isDark
                              ? const Color(0xFF421D09)
                              : const Color(0xFFFFEDE6))
                          : (isDark ? const Color(0xFF242424) : Colors.white),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? (isDark ? const Color(0xFFEE671C) : const Color(0xFF9E3D00))
                            : (isDark ? const Color(0xFF333333) : const Color(0xFFECE7DE)),
                        width: isSelected ? 1.5 : 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? (isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500))
                                    : (isDark ? const Color(0xFF303030) : const Color(0xFFFFEDE6)),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _getIconForSlot(slot),
                                size: 14,
                                color: isSelected
                                    ? Colors.white
                                    : (isDark ? Colors.white70 : const Color(0xFF8B2500)),
                              ),
                            ),
                            if (isSelected)
                              Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check, size: 12, color: Colors.white),
                              )
                            else
                              Text(
                                'Free',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF5A524A),
                                ),
                              ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              slot.label,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: isSelected && !isDark
                                    ? const Color(0xFF8B2500)
                                    : (isDark ? Colors.white : const Color(0xFF141311)),
                              ),
                            ),
                            Text(
                              _getTimeForSlot(slot),
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w600,
                                color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF4A433D),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Servings Scaler Card
            Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF242424) : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isDark ? const Color(0xFF333333) : const Color(0xFFECE7DE),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF303030) : const Color(0xFFFFEDE6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.group_outlined,
                          size: 16,
                          color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '$_servings Servings',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFF0F5132) : const Color(0xFFD1E7DD),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Standard',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w800,
                                    color: isDark ? const Color(0xFF75E59B) : const Color(0xFF0F5132),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Scales grocery ingredients automatically',
                            style: TextStyle(
                              fontSize: 10,
                              color: isDark ? Colors.white54 : const Color(0xFF8A8276),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF2EFE8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, size: 14),
                          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                          padding: EdgeInsets.zero,
                          onPressed: _servings > 1 ? () => setState(() => _servings--) : null,
                        ),
                        Text(
                          '$_servings',
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, size: 14),
                          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                          padding: EdgeInsets.zero,
                          onPressed: () => setState(() => _servings++),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Main Action Button: Confirm Schedule
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor:
                      isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  widget.onConfirm(_selectedDay, _selectedSlot, widget.recipe);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.calendar_month_rounded, size: 18),
                label: Text(
                  'Confirm Schedule • ${_selectedDay.fullName} ${_selectedSlot.label}',
                  style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
