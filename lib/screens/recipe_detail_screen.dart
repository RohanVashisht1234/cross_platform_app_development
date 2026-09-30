import 'dart:async';
import 'package:flutter/material.dart';
import '../models/day_of_week.dart';
import '../models/meal_slot.dart';
import '../models/recipe.dart';
import '../widgets/add_to_plan_sheet.dart';
import '../widgets/app_recipe_image.dart';
import 'profile_screen.dart';

/// Comprehensive Recipe Detail screen with servings scaling, step tracking,
/// active in-step simmer timer, and architectural justification,
/// meticulously recreated to match the Figma Light and Dark mode specifications.
class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback onToggleFavorite;
  final Function(DayOfWeek day, MealSlot slot, Recipe recipe) onAddToPlan;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
    required this.onToggleFavorite,
    required this.onAddToPlan,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late Recipe _recipe;
  late int _servings;
  final Set<int> _completedSteps = {0}; // Step 1 completed by default matching mockup
  final Set<int> _checkedIngredients = {0}; // First ingredient checked matching mockup

  // Active cooking timer state (simmer timer initialized at 10:00)
  Timer? _countdownTimer;
  int _timerSecondsRemaining = 10 * 60; // 10:00
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _recipe = widget.recipe;
    _servings = widget.recipe.servings;
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    if (_isTimerRunning) {
      _countdownTimer?.cancel();
      setState(() => _isTimerRunning = false);
    } else {
      _countdownTimer?.cancel();
      setState(() => _isTimerRunning = true);
      _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) return;
        if (_timerSecondsRemaining > 0) {
          setState(() => _timerSecondsRemaining--);
        } else {
          timer.cancel();
          setState(() => _isTimerRunning = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Simmer stage finished! Proceed to fold in paneer and cream.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      });
    }
  }

  String _formatTimer(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final scaleFactor = _servings / _recipe.servings;
    final scaledIngredients = _recipe.scaleIngredients(_servings);
    final totalMinutes = _recipe.prepTimeMinutes + _recipe.cookTimeMinutes;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/app_logo.png',
                width: 28,
                height: 28,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFFEE671C) : const Color(0xFF9E3D00),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.restaurant_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              isDark ? 'Recipe Detail & Simmer' : 'Recipe Details',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, size: 20),
            tooltip: 'Share Recipe',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Recipe link copied: ${_recipe.title}'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 4),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 16),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image with Overlays
            Stack(
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: AppRecipeImage(
                    imageUrl: _recipe.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                // Top floating buttons overlay
                Positioned(
                  top: 12,
                  left: 14,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: (isDark ? Colors.black : Colors.white).withValues(alpha: 0.85),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        size: 18,
                        color: isDark ? Colors.white : const Color(0xFF201F1F),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 14,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Shared ${_recipe.title}'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: (isDark ? Colors.black : Colors.white).withValues(alpha: 0.85),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.share_outlined,
                            size: 18,
                            color: isDark ? Colors.white : const Color(0xFF201F1F),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          widget.onToggleFavorite();
                          setState(() {
                            _recipe = _recipe.copyWith(isFavorite: !_recipe.isFavorite);
                          });
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: (isDark ? Colors.black : Colors.white).withValues(alpha: 0.85),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Icon(
                            _recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                            size: 18,
                            color: const Color(0xFFEE671C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Rating pill overlay
                Positioned(
                  bottom: 12,
                  left: isDark ? 14 : null,
                  right: isDark ? null : 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: (isDark ? Colors.black : Colors.white).withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded, size: 15, color: Color(0xFFE6A100)),
                        const SizedBox(width: 3),
                        Text(
                          '4.9',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : const Color(0xFF201F1F),
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          isDark ? ' (1.4k)' : ' (142)',
                          style: TextStyle(
                            fontSize: 10.5,
                            color: isDark ? Colors.white60 : const Color(0xFF756F68),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Content Body
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges Row
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      if (_recipe.isVegetarian) ...[
                        _buildPillBadge(
                          label: 'PURE VEGETARIAN',
                          dotColor: const Color(0xFF0F5132),
                          bgColor: isDark ? const Color(0xFF0F5132) : const Color(0xFFD1E7DD),
                          textColor: isDark ? const Color(0xFF75E59B) : const Color(0xFF0F5132),
                        ),
                        _buildPillBadge(
                          label: 'SATTVIC TRADITION',
                          dotColor: isDark ? const Color(0xFFEE671C) : const Color(0xFF0F5132),
                          bgColor: isDark ? const Color(0xFF421D09) : const Color(0xFFD1E7DD),
                          textColor: isDark ? const Color(0xFFFFB28A) : const Color(0xFF0F5132),
                        ),
                      ] else ...[
                        _buildPillBadge(
                          label: 'AUTHENTIC NON-VEG',
                          dotColor: const Color(0xFF8B1A1A),
                          bgColor: isDark ? const Color(0xFF4A1010) : const Color(0xFFFFD8D8),
                          textColor: isDark ? const Color(0xFFFFB4AB) : const Color(0xFF8B1A1A),
                        ),
                        _buildPillBadge(
                          label: 'ONION & GARLIC BASE',
                          dotColor: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                          bgColor: isDark ? const Color(0xFF421D09) : const Color(0xFFFFEDE6),
                          textColor: isDark ? const Color(0xFFFFB28A) : const Color(0xFF8B2500),
                        ),
                      ],
                      _buildPillBadge(
                        label: _recipe.category,
                        bgColor: isDark ? const Color(0xFF282828) : const Color(0xFFFFEDE6),
                        textColor: isDark ? Colors.white70 : const Color(0xFF8B2500),
                      ),
                      if (!isDark)
                        _buildPillBadge(
                          label: '⏱ $totalMinutes min total',
                          bgColor: const Color(0xFFEDE8DF),
                          textColor: const Color(0xFF5A544C),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Recipe Title
                  Text(
                    _recipe.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Recipe Description
                  Text(
                    _recipe.description,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.45,
                      color: isDark ? Colors.white70 : const Color(0xFF5A544C),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 4-Column Quick Metrics Card
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF7F5F0),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFECE7DE),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMetricColumn(
                          icon: Icons.timer_outlined,
                          label: 'Prep',
                          value: isDark ? '25m' : '${_recipe.prepTimeMinutes}m',
                          isDark: isDark,
                        ),
                        _buildDivider(isDark),
                        _buildMetricColumn(
                          icon: Icons.outdoor_grill_outlined,
                          label: 'Cook',
                          value: '${_recipe.cookTimeMinutes}m',
                          isDark: isDark,
                        ),
                        _buildDivider(isDark),
                        _buildMetricColumn(
                          icon: Icons.bolt_outlined,
                          label: 'Calories',
                          value: '${_recipe.calories} kcal',
                          isDark: isDark,
                        ),
                        _buildDivider(isDark),
                        _buildMetricColumn(
                          icon: Icons.bar_chart_rounded,
                          label: 'Level',
                          value: 'Medium',
                          isDark: isDark,
                          valueColor: isDark ? const Color(0xFF75E59B) : const Color(0xFF1B6D24),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Ingredients Section Header & Stepper
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          const Text(
                            'Ingredients',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isDark ? '8 royal pantry items' : '${scaledIngredients.length} items',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF4A433D),
                            ),
                          ),
                        ],
                      ),
                      // Servings Stepper
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF421D09) : const Color(0xFFFFEDE6),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDark ? const Color(0xFFEE671C) : const Color(0xFFFFD1BD),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: _servings > 1 ? () => setState(() => _servings--) : null,
                              borderRadius: BorderRadius.circular(14),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                child: Icon(
                                  Icons.remove,
                                  size: 14,
                                  color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                                ),
                              ),
                            ),
                            Text(
                              '$_servings servings',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w800,
                                color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                              ),
                            ),
                            InkWell(
                              onTap: () => setState(() => _servings++),
                              borderRadius: BorderRadius.circular(14),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                child: Icon(
                                  Icons.add,
                                  size: 14,
                                  color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Scaling Notice Callout
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF242424) : const Color(0xFFF7F5F0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isDark ? Icons.bolt_rounded : Icons.info_outline_rounded,
                          size: 14,
                          color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Quantities automatically scale with selected servings (${scaleFactor.toStringAsFixed(1)}x ratio).',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w500,
                              color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF38332E),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Ingredients List (Checkable Tiles)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: scaledIngredients.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 6),
                    itemBuilder: (context, index) {
                      final item = scaledIngredients[index];
                      final isChecked = _checkedIngredients.contains(index);

                      return Material(
                        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (isChecked) {
                                _checkedIngredients.remove(index);
                              } else {
                                _checkedIngredients.add(index);
                              }
                            });
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFECE7DE),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isChecked ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                                  size: 18,
                                  color: isChecked
                                      ? (isDark ? const Color(0xFF50E380) : const Color(0xFF1B6D24))
                                      : (isDark ? const Color(0xFF8A857D) : const Color(0xFF8A8276)),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    item.name,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      decoration: isChecked ? TextDecoration.lineThrough : null,
                                      color: isChecked
                                          ? (isDark ? const Color(0xFF9E9990) : const Color(0xFF6E6860))
                                          : (isDark ? Colors.white : const Color(0xFF141311)),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: isDark ? const Color(0xFF282828) : const Color(0xFFFFEDE6),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    item.displayAmountWithUnit,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF8B2500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // Preparation Steps Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Preparation Steps',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        isDark ? '3 Master Steps' : '● ${_completedSteps.length} of ${_recipe.instructions.length} Done',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white54 : const Color(0xFF1B6D24),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Steps List with in-step Simmer Timer
                  _buildStep1(isDark),
                  const SizedBox(height: 10),
                  _buildStep2WithTimer(isDark),
                  const SizedBox(height: 10),
                  _buildStep3(isDark),
                ],
              ),
            ),
          ],
        ),
      ),

      // Fixed Bottom Action Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF161616) : Colors.white,
          border: Border(
            top: BorderSide(
              color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFECE7DE),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              offset: const Offset(0, -4),
              blurRadius: 10,
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF242424) : const Color(0xFFF2EFE8),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark ? const Color(0xFF333333) : const Color(0xFFE5DFC9),
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.bookmark_border_rounded, size: 20),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Saved ${_recipe.title} to bookmarks!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
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
                      AddToPlanSheet.show(
                        context,
                        recipe: _recipe,
                        onConfirm: widget.onAddToPlan,
                      );
                    },
                    icon: const Icon(Icons.calendar_month_rounded, size: 18),
                    label: const Text(
                      'Add to Weekly Meal Plan',
                      style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep1(bool isDark) {
    final isDone = _completedSteps.contains(0);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF7F5F0),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFECE7DE),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                if (isDone) {
                  _completedSteps.remove(0);
                } else {
                  _completedSteps.add(0);
                }
              });
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isDone && !isDark
                    ? const Color(0xFF1B6D24)
                    : (isDark ? const Color(0xFF282828) : const Color(0xFF8B2500)),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: (isDone && !isDark)
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : Text(
                        '1',
                        style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isDark ? 'Aromatic Tempering' : 'Step 1 • Temper Whole Spices & Ginger',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    decoration: (isDone && !isDark) ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Temper cumin seeds, hing, grated ginger, and slit green chillies in fragrant desi ghee until sizzling.',
                  style: TextStyle(
                    fontSize: 11.5,
                    height: 1.4,
                    decoration: (isDone && !isDark) ? TextDecoration.lineThrough : null,
                    color: isDark ? Colors.white60 : const Color(0xFF6B655D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2WithTimer(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFFFD1BD),
          width: 1.2,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF282828) : const Color(0xFF8B2500),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '2',
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          isDark ? 'Velvety Gravy Simmer' : 'Step 2 • Active',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                        ),
                        if (!isDark) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEDE6),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'In Progress',
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF8B2500),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Pour smooth tomato-cashew puree. Simmer on medium-low heat until ghee separates.',
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.4,
                        color: isDark ? Colors.white70 : const Color(0xFF4A453E),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Active Simmer Timer Card
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF161616) : const Color(0xFF201F1F),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? const Color(0xFF2A2A2A) : Colors.transparent,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEE671C).withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.hourglass_top_rounded, size: 15, color: Color(0xFFEE671C)),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Simmer Stage',
                          style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white60 : Colors.white70,
                          ),
                        ),
                        Text(
                          _formatTimer(_timerSecondsRemaining),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'monospace',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: _toggleTimer,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEE671C),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isTimerRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                          size: 14,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _isTimerRunning ? 'Pause' : 'Start Timer',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep3(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF7F5F0),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFECE7DE),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF282828) : const Color(0xFFE4DFD5),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '3',
                style: TextStyle(
                  color: isDark ? Colors.white70 : const Color(0xFF4A453E),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isDark ? 'Finishing & Cream Fold' : 'Step 3',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 3),
                Text(
                  'Gently fold in fresh paneer cubes, crushed kasuri methi, and dairy cream swirl. Cook 3 mins.',
                  style: TextStyle(
                    fontSize: 11.5,
                    height: 1.4,
                    color: isDark ? Colors.white60 : const Color(0xFF6B655D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillBadge({
    required String label,
    required Color bgColor,
    required Color textColor,
    Color? dotColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dotColor != null) ...[
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricColumn({
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
    Color? valueColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 13,
              color: isDark ? Colors.white54 : const Color(0xFF8A8276),
            ),
            const SizedBox(width: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                color: isDark ? Colors.white54 : const Color(0xFF8A8276),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: valueColor ?? (isDark ? Colors.white : const Color(0xFF201F1F)),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(bool isDark) {
    return Container(
      width: 1,
      height: 24,
      color: isDark ? const Color(0xFF2E2E2E) : const Color(0xFFE5DFC9),
    );
  }
}
