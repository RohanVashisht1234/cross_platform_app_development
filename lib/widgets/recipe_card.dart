import 'package:flutter/material.dart';
import '../models/difficulty.dart';
import '../models/recipe.dart';
import 'app_recipe_image.dart';

/// Recipe Browse Card showcasing the recipe photo, category badge, prep time,
/// difficulty, dietary tags, and plan action button,
/// meticulously recreated to match the Figma Recipe Browse specifications in Light and Dark mode.
class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;
  final VoidCallback? onAddToPlan;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
    required this.onToggleFavorite,
    this.onAddToPlan,
  });

  String _getCategoryTag() {
    if (recipe.id == 'rec_shahi_paneer') return 'North Indian';
    if (recipe.id == 'rec_palak_paneer') return 'Healthy Green';
    if (recipe.id == 'rec_dal_makhani') return 'Comfort Dal';
    if (recipe.id == 'rec_vegetable_biryani') return 'Royal Rice';
    return recipe.category;
  }

  String _getDarkTag() {
    if (!recipe.isVegetarian) return '🍗 Non-Veg';
    if (recipe.id == 'rec_shahi_paneer') return '🍃 Sattvic';
    if (recipe.id == 'rec_palak_paneer') return '🍃 Iron Rich';
    if (recipe.id == 'rec_dal_makhani') return '🍲 Slow Simmer';
    if (recipe.id == 'rec_vegetable_biryani') return '📍 Signature';
    return '🍃 Pure Veg';
  }

  Widget _buildFoodTypeIndicator(bool isVeg) {
    final color = isVeg ? const Color(0xFF155A1D) : const Color(0xFF8B1A1A);

    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: color, width: 1.2),
        borderRadius: BorderRadius.circular(2.5),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildDifficultyBadge(bool isDark) {
    Color bg;
    Color text;
    String label;
    IconData icon;

    switch (recipe.difficulty) {
      case Difficulty.easy:
        bg = isDark ? const Color(0xFF0F5132) : const Color(0xFFD1E7DD);
        text = isDark ? const Color(0xFF75E59B) : const Color(0xFF0F5132);
        label = 'Easy';
        icon = Icons.eco_rounded;
        break;
      case Difficulty.medium:
        bg = isDark ? const Color(0xFFEE671C) : const Color(0xFFF2EFE8);
        text = isDark ? Colors.white : const Color(0xFF4A453E);
        label = 'Medium';
        icon = Icons.tune_rounded;
        break;
      case Difficulty.hard:
        bg = isDark ? const Color(0xFF8B1A1A) : const Color(0xFFFFD8D8);
        text = isDark ? const Color(0xFFFFB4AB) : const Color(0xFF8B1A1A);
        label = 'Hard';
        icon = Icons.local_fire_department_rounded;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: text),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              color: text,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFECE7DE),
          width: 1.0,
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Recipe Image with Overlays
            Expanded(
              flex: 11,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    child: AppRecipeImage(
                      imageUrl: recipe.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Top Category Tag (North Indian / Healthy Green / Comfort Dal / Royal Rice)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.black.withValues(alpha: 0.7)
                            : Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildFoodTypeIndicator(recipe.isVegetarian),
                          const SizedBox(width: 4),
                          Text(
                            _getCategoryTag(),
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : const Color(0xFF201F1F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Favorite Button Circle (Top Right)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: onToggleFavorite,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark
                              ? const Color(0xFF262626).withValues(alpha: 0.85)
                              : Colors.white.withValues(alpha: 0.9),
                        ),
                        child: Center(
                          child: Icon(
                            recipe.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            size: 15,
                            color: recipe.isFavorite
                                ? const Color(0xFFD32F2F)
                                : (isDark ? Colors.white70 : const Color(0xFF5A544C)),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Difficulty Badge (Bottom Left)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: _buildDifficultyBadge(isDark),
                  ),
                ],
              ),
            ),

            // Bottom Content Section
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        size: 11,
                        color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF4A433D),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${recipe.prepTimeMinutes}m prep',
                        style: TextStyle(
                          fontSize: 10,
                          color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF4A433D),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '•',
                        style: TextStyle(
                          fontSize: 10,
                          color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF4A433D),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        isDark ? '${recipe.servings} servings' : '🍽️ ${recipe.servings} serv',
                        style: TextStyle(
                          fontSize: 10,
                          color: isDark ? const Color(0xFFDDD9D2) : const Color(0xFF4A433D),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Bottom Action Button / Tag Row
                  if (isDark)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getDarkTag(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF75E59B),
                          ),
                        ),
                        InkWell(
                          onTap: onAddToPlan,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF282828),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFF383838)),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.add, size: 11, color: Colors.white70),
                                SizedBox(width: 2),
                                Text(
                                  'Plan',
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      height: 28,
                      child: FilledButton.tonal(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFFFFEDE6),
                          foregroundColor: const Color(0xFF8B2500),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: onAddToPlan,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_month_rounded, size: 12),
                            SizedBox(width: 4),
                            Text(
                              'Plan',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
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
      ),
    );
  }
}
