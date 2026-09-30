import 'package:flutter_test/flutter_test.dart';
import 'package:mealcraft/main.dart';
import 'package:mealcraft/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('MealCraft app loads and renders browse screen with recipe cards', (WidgetTester tester) async {
    // Setup mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
    final storageService = await StorageService.init();

    await tester.pumpWidget(MealCraftApp(storageService: storageService));
    await tester.pumpAndSettle();

    // Verify app brand in app bar
    expect(find.text('MEALCRAFT'), findsOneWidget);

    // Verify bottom navigation bar destinations matching Figma
    expect(find.text('Browse'), findsWidgets);
    expect(find.text('Meal Plan'), findsWidgets);
    expect(find.text('Groceries'), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);

    // Verify at least one recipe card title is rendered (e.g. Shahi Paneer Butter Masala)
    expect(find.text('Shahi Paneer Butter Masala'), findsWidgets);

    // Verify switching to Meal Plan tab
    await tester.tap(find.text('Meal Plan'));
    await tester.pumpAndSettle();

    // Verify Weekly Overview and day cards
    expect(find.text('Weekly Overview'), findsOneWidget);
    expect(find.text('Today'), findsWidgets);
    expect(find.text('Tomorrow'), findsOneWidget);
    expect(find.text('Sunday Prep & Slow Cooking'), findsOneWidget);
  });
}
