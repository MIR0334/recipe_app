import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/screens/recipe_list_screen.dart';
import 'package:recipe_app/screens/recipe_detail_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    // Make sure SharedPreferences starts empty for each test
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets(
    'RecipeListScreen shows breakfast recipes from provider',
    (WidgetTester tester) async {
      // Arrange
      final provider = RecipeProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider<RecipeProvider>.value(
          value: provider,
          child: const MaterialApp(
            home: RecipeListScreen(category: 'Breakfast'),
          ),
        ),
      );

      // Let async _loadRecipes() complete and rebuild UI
      await tester.pumpAndSettle();

      // Assert: default breakfast recipes from sample_recipes.dart appear
      expect(find.text('Fluffy Pancakes'), findsOneWidget);
      expect(find.text('Avocado Toast'), findsOneWidget);
    },
  );

  testWidgets(
    'Tapping a recipe card navigates to RecipeDetailScreen',
    (WidgetTester tester) async {
      // Arrange
      final provider = RecipeProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider<RecipeProvider>.value(
          value: provider,
          child: MaterialApp(
            home: const RecipeListScreen(category: 'Breakfast'),
            // We add routes just in case, but we use MaterialPageRoute in the app
            onGenerateRoute: (settings) {
              // Fallback; in this app navigation is handled inside RecipeCard
              return MaterialPageRoute(
                builder: (_) => const Scaffold(
                  body: Center(child: Text('Unknown route')),
                ),
              );
            },
          ),
        ),
      );

      // Wait for recipes to load
      await tester.pumpAndSettle();

      // Act: tap on one of the breakfast recipes
      final pancakesFinder = find.text('Fluffy Pancakes');
      expect(pancakesFinder, findsOneWidget);

      await tester.tap(pancakesFinder);
      await tester.pumpAndSettle();

      // Assert: now we should be on the detail screen
      // We know detail screen shows "Ingredients" and the recipe description
      expect(find.byType(RecipeDetailScreen), findsOneWidget);
      expect(find.text('Ingredients'), findsOneWidget);
      // Title still visible in the AppBar
      expect(find.text('Fluffy Pancakes'), findsWidgets);
    },
  );
}
