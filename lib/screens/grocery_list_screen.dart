import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/ingredient.dart';
import '../models/recipe.dart';
import '../services/ingredient_merger.dart';

/// Screen displaying the consolidated supermarket grocery shopping list,
/// generated automatically by merging duplicate ingredients across all scheduled recipes via a Map.
///
/// Implements the problem statement requirements:
/// - "Dart Logic: merge multiple recipes' ingredients using a Map for the weekly list."
/// - "The app auto-generates a combined ingredient list, merging duplicate ingredients via a Map."
/// - "Appetizing Material 3 recipe theme."
class GroceryListScreen extends StatefulWidget {
  final List<Recipe> plannedRecipes;
  final Set<String> initialCheckedKeys;
  final Function(Set<String> updatedKeys) onCheckedKeysChanged;

  const GroceryListScreen({
    super.key,
    required this.plannedRecipes,
    required this.initialCheckedKeys,
    required this.onCheckedKeysChanged,
  });

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  late Set<String> _checkedKeys;
  final List<MergedIngredient> _customItems = [];
  String _activeFilter = 'All'; // 'All', 'To Buy', 'Purchased'

  @override
  void initState() {
    super.initState();
    _checkedKeys = Set.from(widget.initialCheckedKeys);
  }

  List<MergedIngredient> _getAllMergedIngredients() {
    // Generate real, dynamic ingredients directly from the scheduled recipes
    final dynamicIngredients = IngredientMerger.mergeRecipes(
      widget.plannedRecipes,
      checkedKeys: _checkedKeys,
    );

    // Merge with any custom items added by the user
    return [...dynamicIngredients, ..._customItems];
  }

  void _toggleItem(String key) {
    setState(() {
      if (_checkedKeys.contains(key)) {
        _checkedKeys.remove(key);
      } else {
        _checkedKeys.add(key);
      }
    });
    widget.onCheckedKeysChanged(_checkedKeys);
  }

  void _addCustomItemDialog() {
    final nameCtrl = TextEditingController();
    final amountCtrl = TextEditingController();
    final unitCtrl = TextEditingController(text: 'g');
    IngredientCategory selectedCat = IngredientCategory.produce;

    showDialog(
      context: context,
      builder: (dialogCtx) {
        final theme = Theme.of(dialogCtx);
        final isDark = theme.brightness == Brightness.dark;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              title: const Text(
                'Add Grocery Item',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameCtrl,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Item Name (e.g. Cardamom, Fresh Mint)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: amountCtrl,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'Quantity',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: unitCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Unit (g, ml, tbsp, bunch)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<IngredientCategory>(
                      initialValue: selectedCat,
                      decoration: const InputDecoration(
                        labelText: 'Supermarket Aisle',
                        border: OutlineInputBorder(),
                      ),
                      items: IngredientCategory.values.map((cat) {
                        return DropdownMenuItem(
                          value: cat,
                          child: Text(cat.label, style: const TextStyle(fontSize: 12)),
                        );
                      }).toList(),
                      onChanged: (cat) {
                        if (cat != null) setDialogState(() => selectedCat = cat);
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogCtx).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                  ),
                  onPressed: () {
                    final name = nameCtrl.text.trim();
                    if (name.isEmpty) return;

                    final amount = double.tryParse(amountCtrl.text.trim()) ?? 1.0;
                    final unit = unitCtrl.text.trim();
                    final key = 'custom_${name.toLowerCase()}_$unit';

                    setState(() {
                      _customItems.add(
                        MergedIngredient(
                          key: key,
                          displayName: name,
                          totalAmount: amount,
                          unit: unit,
                          category: selectedCat,
                          recipeSources: ['Custom Item'],
                          isBought: false,
                        ),
                      );
                    });

                    Navigator.of(dialogCtx).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added $name to your grocery list!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: const Text('Add to List'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _copyToClipboard(List<MergedIngredient> allItems) {
    final buffer = StringBuffer();
    buffer.writeln('🛒 MealCraft Consolidated Grocery Shopping List');
    buffer.writeln('100% Pure Sattvic Vegetarian');
    buffer.writeln('==================================================');

    final grouped = <IngredientCategory, List<MergedIngredient>>{};
    for (final item in allItems) {
      grouped.putIfAbsent(item.category, () => []).add(item);
    }

    for (final entry in grouped.entries) {
      buffer.writeln('\n[${entry.key.label.toUpperCase()}]');
      for (final item in entry.value) {
        final status = _checkedKeys.contains(item.key) ? '[x]' : '[ ]';
        final sources = item.recipeSources.join(', ');
        buffer.writeln('$status ${item.displayName} — ${item.displayAmountWithUnit} ($sources)');
      }
    }

    Clipboard.setData(ClipboardData(text: buffer.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Shopping list copied to clipboard formatted for Notes & WhatsApp!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final allItems = _getAllMergedIngredients();
    final totalItems = allItems.length;
    final collectedCount = allItems.where((i) => _checkedKeys.contains(i.key)).length;
    final progressFraction = totalItems > 0 ? (collectedCount / totalItems) : 0.0;
    final percent = (progressFraction * 100).round();

    // Filter items based on active tab
    final displayItems = allItems.where((item) {
      final isChecked = _checkedKeys.contains(item.key);
      if (_activeFilter == 'To Buy') return !isChecked;
      if (_activeFilter == 'Purchased') return isChecked;
      return true;
    }).toList();

    // Group filtered items by category
    final groupedByCategory = <IngredientCategory, List<MergedIngredient>>{};
    for (final item in displayItems) {
      groupedByCategory.putIfAbsent(item.category, () => []).add(item);
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'add_grocery_item_fab',
        onPressed: _addCustomItemDialog,
        backgroundColor: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded, size: 20),
        label: const Text(
          'Add Item',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Sub-Header Row: Icon + "Combined Grocery List" + Subtitle + Action Icons
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF421D09) : const Color(0xFFFFEDE6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.checklist_rounded,
                      size: 18,
                      color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Combined Grocery List',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '100% Pure Sattvic Vegetarian',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10.5,
                            color: isDark ? const Color(0xFF50E380) : const Color(0xFF1B6D24),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.copy_rounded, size: 18),
                        tooltip: 'Copy Checklist',
                        onPressed: () => _copyToClipboard(allItems),
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert_rounded, size: 20),
                        onSelected: (val) {
                          if (val == 'toggle_all') {
                            setState(() {
                              if (_checkedKeys.length >= allItems.length && allItems.isNotEmpty) {
                                _checkedKeys.clear();
                              } else {
                                _checkedKeys.addAll(allItems.map((e) => e.key));
                              }
                            });
                            widget.onCheckedKeysChanged(_checkedKeys);
                          } else if (val == 'clear_checked') {
                            setState(() {
                              _checkedKeys.clear();
                            });
                            widget.onCheckedKeysChanged(_checkedKeys);
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'toggle_all',
                            child: Text(
                              collectedCount == totalItems && totalItems > 0
                                  ? 'Uncheck All'
                                  : 'Select All to Buy',
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'clear_checked',
                            child: Text('Clear All Checked'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Shopping Progress Card
              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFECE7DE),
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
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 16,
                              color: isDark ? const Color(0xFF50E380) : const Color(0xFF1B6D24),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Shopping Progress',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        Text(
                          '$collectedCount of $totalItems collected ($percent%)',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: isDark ? const Color(0xFF50E380) : const Color(0xFF1B6D24),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Green Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: progressFraction.clamp(0.0, 1.0),
                        minHeight: 7,
                        backgroundColor: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE5DFC9),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isDark ? const Color(0xFF50E380) : const Color(0xFF1B6D24),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Summary Callout
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF2A1C16) : const Color(0xFFFFEDE6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.bolt_rounded,
                            size: 15,
                            color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              totalItems > 0
                                  ? '$totalItems ingredients synthesized across ${widget.plannedRecipes.length} scheduled meals. Duplicates automatically consolidated.'
                                  : 'No meals scheduled yet. Add recipes to your meal plan to synthesize your grocery list.',
                              style: TextStyle(
                                fontSize: 10.5,
                                height: 1.35,
                                color: isDark ? Colors.white70 : const Color(0xFF5A301E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Filter Chips: All, To Buy, Purchased
              Row(
                children: [
                  _buildFilterChip('All', allItems.length, isDark),
                  const SizedBox(width: 8),
                  _buildFilterChip('To Buy', totalItems - collectedCount, isDark),
                  const SizedBox(width: 8),
                  _buildFilterChip('Purchased', collectedCount, isDark),
                ],
              ),
              const SizedBox(height: 14),

              // If no items match
              if (displayItems.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFECE7DE),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _activeFilter == 'Purchased'
                            ? Icons.check_circle_outline_rounded
                            : Icons.shopping_basket_outlined,
                        size: 40,
                        color: isDark ? const Color(0xFF8A8276) : const Color(0xFFB0A99E),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _activeFilter == 'Purchased'
                            ? 'No purchased items yet. Check off items as you shop!'
                            : 'No ingredients in this view.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                    ],
                  ),
                ),

              // Categories List
              ...groupedByCategory.entries.map((entry) {
                final category = entry.key;
                final items = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _buildCategorySection(
                    title: category.label.toUpperCase(),
                    items: items,
                    headerBgColor: isDark
                        ? const Color(0xFF282828)
                        : category.color.withValues(alpha: 0.12),
                    headerTextColor: isDark ? Colors.white : category.color,
                    icon: category.icon,
                    isDark: isDark,
                  ),
                );
              }),

              // Bottom Action Button: Copy Formatted List
              if (allItems.isNotEmpty) ...[
                const SizedBox(height: 4),
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
                    onPressed: () => _copyToClipboard(allItems),
                    icon: const Icon(Icons.share_outlined, size: 18),
                    label: const Text(
                      'Copy Formatted List to Notes / WhatsApp',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, int count, bool isDark) {
    final isSelected = _activeFilter == label;
    return InkWell(
      onTap: () => setState(() => _activeFilter = label),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500))
              : (isDark ? const Color(0xFF1E1E1E) : const Color(0xFFECE7DE)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: isSelected ? Colors.white : (isDark ? Colors.white70 : const Color(0xFF4A433D)),
              ),
            ),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.25)
                    : (isDark ? const Color(0xFF2E2E2E) : Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: isSelected ? Colors.white : (isDark ? Colors.white70 : const Color(0xFF4A433D)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection({
    required String title,
    required List<MergedIngredient> items,
    required Color headerBgColor,
    required Color headerTextColor,
    required IconData icon,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFECE7DE),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Header Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            color: headerBgColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 14, color: headerTextColor),
                    const SizedBox(width: 6),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                        color: headerTextColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: (isDark ? Colors.black : Colors.white).withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    isDark ? '${items.length}' : '${items.length} items',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: headerTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Items in Category
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: isDark ? const Color(0xFF262626) : const Color(0xFFECE7DE),
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              final isChecked = _checkedKeys.contains(item.key);

              final sourceSubtitle = item.recipeSources.length > 1
                  ? 'Merged: ${item.recipeSources.join(" + ")}'
                  : 'Needed for: ${item.recipeSources.isNotEmpty ? item.recipeSources.first : "Kitchen Recipe"}';

              return InkWell(
                onTap: () => _toggleItem(item.key),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Icon(
                          isChecked ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                          size: 18,
                          color: isChecked
                              ? (isDark ? const Color(0xFF50E380) : const Color(0xFF1B6D24))
                              : (isDark ? Colors.white38 : const Color(0xFFB0A99E)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.displayName,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w700,
                                      decoration: isChecked ? TextDecoration.lineThrough : null,
                                      color: isChecked
                                          ? (isDark ? const Color(0xFF9E9990) : const Color(0xFF6E6860))
                                          : (isDark ? Colors.white : const Color(0xFF141311)),
                                    ),
                                  ),
                                ),
                                Text(
                                  item.displayAmountWithUnit,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: isChecked
                                        ? (isDark ? const Color(0xFF9E9990) : const Color(0xFF6E6860))
                                        : (isDark ? const Color(0xFFDDD9D2) : const Color(0xFF2E2A25)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              sourceSubtitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.5,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                color: isDark ? const Color(0xFFC8C4BC) : const Color(0xFF4A433D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
