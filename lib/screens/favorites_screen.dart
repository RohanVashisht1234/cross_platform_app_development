import 'package:flutter/material.dart';
import '../models/day_of_week.dart';
import '../models/meal_slot.dart';
import '../models/recipe.dart';
import '../widgets/add_to_plan_sheet.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart';

/// Screen showcasing favorite and custom user recipes.
class FavoritesScreen extends StatefulWidget {
  final List<Recipe> recipes;
  final Function(String recipeId) onToggleFavorite;
  final Function(DayOfWeek day, MealSlot slot, Recipe recipe) onAddToPlan;
  final VoidCallback onAddNewRecipe;

  const FavoritesScreen({
    super.key,
    required this.recipes,
    required this.onToggleFavorite,
    required this.onAddToPlan,
    required this.onAddNewRecipe,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _selectedFilterIndex = 0; // 0 = Favorites, 1 = My Custom Recipes

  @override
  Widget build(BuildContext context) {
    final favoriteRecipes = widget.recipes.where((r) => r.isFavorite).toList();
    final customRecipes = widget.recipes.where((r) => r.isCustom).toList();

    final activeList = _selectedFilterIndex == 0 ? favoriteRecipes : customRecipes;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Filter Segment
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: SegmentedButton<int>(
                      segments: [
                        ButtonSegment(
                          value: 0,
                          label: Text('Favorites (${favoriteRecipes.length})'),
                          icon: const Icon(Icons.favorite_rounded, size: 16),
                        ),
                        ButtonSegment(
                          value: 1,
                          label: Text('Custom (${customRecipes.length})'),
                          icon: const Icon(Icons.edit_note_rounded, size: 16),
                        ),
                      ],
                      selected: {_selectedFilterIndex},
                      onSelectionChanged: (set) {
                        setState(() => _selectedFilterIndex = set.first);
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Content Grid
            Expanded(
              child: activeList.isNotEmpty
                  ? GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.68,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: activeList.length,
                      itemBuilder: (context, index) {
                        final recipe = activeList[index];
                        return RecipeCard(
                          recipe: recipe,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RecipeDetailScreen(
                                  recipe: recipe,
                                  onToggleFavorite: () => widget.onToggleFavorite(recipe.id),
                                  onAddToPlan: widget.onAddToPlan,
                                ),
                              ),
                            );
                          },
                          onToggleFavorite: () => widget.onToggleFavorite(recipe.id),
                          onAddToPlan: () {
                            AddToPlanSheet.show(
                              context,
                              recipe: recipe,
                              onConfirm: widget.onAddToPlan,
                            );
                          },
                        );
                      },
                    )
                  : EmptyStateView(
                      icon: _selectedFilterIndex == 0
                          ? Icons.favorite_border_rounded
                          : Icons.menu_book_rounded,
                      title: _selectedFilterIndex == 0
                          ? 'No Favorites Yet'
                          : 'No Custom Recipes Created',
                      subtitle: _selectedFilterIndex == 0
                          ? 'Tap the heart icon on any recipe card to save it here for fast meal planning.'
                          : 'Create your own signature dishes and save them directly to your device storage!',
                      actionLabel: _selectedFilterIndex == 1 ? 'Add New Recipe' : null,
                      onAction: _selectedFilterIndex == 1 ? widget.onAddNewRecipe : null,
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: _selectedFilterIndex == 1
          ? FloatingActionButton.extended(
              onPressed: widget.onAddNewRecipe,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add Recipe'),
            )
          : null,
    );
  }
}
