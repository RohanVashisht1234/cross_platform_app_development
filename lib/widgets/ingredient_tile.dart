import 'package:flutter/material.dart';
import '../services/ingredient_merger.dart';

/// Renders a single ingredient row with clean typography and interactive check state.
class IngredientTile extends StatelessWidget {
  final MergedIngredient ingredient;
  final ValueChanged<bool?> onToggle;

  const IngredientTile({
    super.key,
    required this.ingredient,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isBought = ingredient.isBought;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onToggle(!isBought),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Checkbox
              Checkbox(
                value: isBought,
                onChanged: onToggle,
                activeColor: theme.colorScheme.secondary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
              const SizedBox(width: 8),

              // Ingredient Name & Recipe Sources
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ingredient.displayName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        decoration: isBought ? TextDecoration.lineThrough : null,
                        color: isBought
                            ? (theme.brightness == Brightness.dark
                                ? const Color(0xFF9E9990)
                                : const Color(0xFF6E6860))
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                    if (ingredient.recipeSources.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Needed for: ${ingredient.recipeSources.join(", ")}',
                        style: TextStyle(
                          fontSize: 11,
                          color: isBought
                              ? (theme.brightness == Brightness.dark
                                  ? const Color(0xFF8A857D)
                                  : const Color(0xFF807A72))
                              : (theme.brightness == Brightness.dark
                                  ? const Color(0xFFEE671C)
                                  : const Color(0xFF8B2500)),
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Quantity Badge
              if (ingredient.displayAmountWithUnit.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isBought
                        ? (theme.brightness == Brightness.dark
                            ? const Color(0xFF282828)
                            : const Color(0xFFEDE8DF))
                        : theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    ingredient.displayAmountWithUnit,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isBought
                          ? (theme.brightness == Brightness.dark
                              ? const Color(0xFF9E9990)
                              : const Color(0xFF6E6860))
                          : theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
