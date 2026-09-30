import 'package:flutter/material.dart';
import '../models/difficulty.dart';
import '../models/ingredient.dart';
import '../models/recipe.dart';

/// Form screen allowing the user to compose and store custom recipes locally.
class AddRecipeScreen extends StatefulWidget {
  final Function(Recipe newRecipe) onSaveRecipe;

  const AddRecipeScreen({super.key, required this.onSaveRecipe});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _prepTimeController = TextEditingController(text: '15');
  final _cookTimeController = TextEditingController(text: '20');
  final _servingsController = TextEditingController(text: '4');
  final _caloriesController = TextEditingController(text: '450');

  String _selectedCategory = 'Healthy';
  Difficulty _selectedDifficulty = Difficulty.medium;

  final List<String> _categories = [
    'Healthy',
    'Italian',
    'Mexican',
    'Asian',
    'Quick & Easy',
    'Breakfast',
    'Desserts',
    'General',
  ];

  // Dynamic ingredient rows
  final List<_IngredientRow> _ingredientRows = [
    _IngredientRow(
      nameController: TextEditingController(text: 'Olive Oil'),
      amountController: TextEditingController(text: '2'),
      unitController: TextEditingController(text: 'tbsp'),
      category: IngredientCategory.pantry,
    ),
    _IngredientRow(
      nameController: TextEditingController(text: 'Fresh Ginger'),
      amountController: TextEditingController(text: '1'),
      unitController: TextEditingController(text: 'tbsp'),
      category: IngredientCategory.produce,
    ),
  ];

  // Dynamic instruction rows
  final List<TextEditingController> _instructionControllers = [
    TextEditingController(text: 'Prepare and chop all fresh ingredients.'),
    TextEditingController(text: 'Cook over medium heat until golden and serve fresh.'),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _prepTimeController.dispose();
    _cookTimeController.dispose();
    _servingsController.dispose();
    _caloriesController.dispose();
    for (final row in _ingredientRows) {
      row.nameController.dispose();
      row.amountController.dispose();
      row.unitController.dispose();
    }
    for (final c in _instructionControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addIngredientRow() {
    setState(() {
      _ingredientRows.add(
        _IngredientRow(
          nameController: TextEditingController(),
          amountController: TextEditingController(text: '1'),
          unitController: TextEditingController(text: 'cups'),
          category: IngredientCategory.produce,
        ),
      );
    });
  }

  void _removeIngredientRow(int index) {
    if (_ingredientRows.length > 1) {
      setState(() {
        _ingredientRows.removeAt(index);
      });
    }
  }

  void _addInstructionStep() {
    setState(() {
      _instructionControllers.add(TextEditingController());
    });
  }

  void _removeInstructionStep(int index) {
    if (_instructionControllers.length > 1) {
      setState(() {
        _instructionControllers.removeAt(index);
      });
    }
  }

  void _saveForm() {
    if (!_formKey.currentState!.validate()) return;

    final ingredients = _ingredientRows.map((row) {
      final name = row.nameController.text.trim();
      final amount = double.tryParse(row.amountController.text.trim()) ?? 1.0;
      final unit = row.unitController.text.trim();
      return Ingredient(
        name: name,
        amount: amount,
        unit: unit,
        category: row.category,
      );
    }).where((i) => i.name.isNotEmpty).toList();

    final instructions = _instructionControllers
        .map((c) => c.text.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final newRecipe = Recipe(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
      imageUrl: _imageUrlController.text.trim().isNotEmpty
          ? _imageUrlController.text.trim()
          : 'https://images.unsplash.com/photo-1498837167922-ddd27525d352?auto=format&fit=crop&w=800&q=80',
      prepTimeMinutes: int.tryParse(_prepTimeController.text.trim()) ?? 15,
      cookTimeMinutes: int.tryParse(_cookTimeController.text.trim()) ?? 20,
      difficulty: _selectedDifficulty,
      servings: int.tryParse(_servingsController.text.trim()) ?? 4,
      calories: int.tryParse(_caloriesController.text.trim()) ?? 450,
      ingredients: ingredients,
      instructions: instructions,
      tags: ['Home Cooked', _selectedCategory],
      isCustom: true,
    );

    widget.onSaveRecipe(newRecipe);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Created and saved "${newRecipe.title}" locally!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Custom Recipe'),
        actions: [
          TextButton.icon(
            onPressed: _saveForm,
            icon: const Icon(Icons.check_rounded),
            label: const Text('Save'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
          children: [
            // Recipe Basics Section
            Text('Basic Information', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Recipe Title *',
                hintText: 'e.g. Grandma\'s Secret Minestrone Soup',
                border: OutlineInputBorder(),
              ),
              validator: (val) => val == null || val.trim().isEmpty ? 'Title is required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descriptionController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Brief summary of flavors and character...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _imageUrlController,
              decoration: const InputDecoration(
                labelText: 'Image URL (optional)',
                hintText: 'https://...',
                prefixIcon: Icon(Icons.image_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Category & Difficulty Row
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _selectedCategory,
                    decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
                    items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (val) => setState(() => _selectedCategory = val ?? 'Healthy'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<Difficulty>(
                    initialValue: _selectedDifficulty,
                    decoration: const InputDecoration(labelText: 'Difficulty', border: OutlineInputBorder()),
                    items: Difficulty.values
                        .map((d) => DropdownMenuItem(value: d, child: Text(d.label)))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedDifficulty = val ?? Difficulty.medium),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Timing & Servings Row
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _prepTimeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Prep (mins)', border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _cookTimeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Cook (mins)', border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _servingsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Servings', border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
            const Divider(height: 36),

            // Ingredients Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ingredients List', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                TextButton.icon(
                  onPressed: _addIngredientRow,
                  icon: const Icon(Icons.add_rounded, size: 16),
                  label: const Text('Add Item'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ...List.generate(_ingredientRows.length, (index) {
              final row = _ingredientRows[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextFormField(
                        controller: row.nameController,
                        decoration: InputDecoration(
                          hintText: 'Ingredient (e.g. Tomatoes)',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: row.amountController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          hintText: 'Qty',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: row.unitController,
                        decoration: InputDecoration(
                          hintText: 'Unit',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => _removeIngredientRow(index),
                    ),
                  ],
                ),
              );
            }),
            const Divider(height: 36),

            // Instructions Steps Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cooking Instructions', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                TextButton.icon(
                  onPressed: _addInstructionStep,
                  icon: const Icon(Icons.add_rounded, size: 16),
                  label: const Text('Add Step'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ...List.generate(_instructionControllers.length, (index) {
              final c = _instructionControllers[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: c,
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: 'Step ${index + 1} instruction...',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => _removeInstructionStep(index),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),

            FilledButton(
              onPressed: _saveForm,
              child: const Text('Save Recipe to Local Device'),
            ),
          ],
        ),
      ),
    );
  }
}

class _IngredientRow {
  final TextEditingController nameController;
  final TextEditingController amountController;
  final TextEditingController unitController;
  IngredientCategory category;

  _IngredientRow({
    required this.nameController,
    required this.amountController,
    required this.unitController,
    required this.category,
  });
}
