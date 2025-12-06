import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:recipe_app/providers/recipe_provider.dart';
import 'package:recipe_app/models/recipe.dart';

void main() {
  // Needed for SharedPreferences in tests
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    // Start each test with empty mock storage
    SharedPreferences.setMockInitialValues({});
  });

  test('addRecipe adds a recipe to the list', () async {
    final provider = RecipeProvider();

    // wait a moment for _loadRecipes() to finish
    await Future.delayed(const Duration(milliseconds: 50));

    final initialLength = provider.recipes.length;

    final newRecipe = Recipe(
      id: 'test1',
      title: 'Test Recipe',
      description: 'A test recipe',
      category: 'Breakfast',
      time: '10 min',
      ingredients: ['1 test ingredient'],
      steps: ['Do the test step'],
    );

    await provider.addRecipe(newRecipe);

    expect(provider.recipes.length, initialLength + 1);
    expect(
      provider.recipes.any((r) => r.id == 'test1'),
      true,
      reason: 'New recipe with id test1 should be in the list',
    );
  });

  test('toggleFavorite toggles isFavorite on a recipe', () async {
    final provider = RecipeProvider();
    await Future.delayed(const Duration(milliseconds: 50));

    final recipe = provider.recipes.first;
    final id = recipe.id;
    final initialFavorite = recipe.isFavorite;

    await provider.toggleFavorite(id);
    expect(
      provider.recipes.firstWhere((r) => r.id == id).isFavorite,
      !initialFavorite,
      reason: 'First toggle should invert initial favourite state',
    );

    await provider.toggleFavorite(id);
    expect(
      provider.recipes.firstWhere((r) => r.id == id).isFavorite,
      initialFavorite,
      reason: 'Second toggle should restore original favourite state',
    );
  });

  test('deleteRecipe removes a recipe from the list', () async {
    final provider = RecipeProvider();
    await Future.delayed(const Duration(milliseconds: 50));

    final initialLength = provider.recipes.length;
    final idToDelete = provider.recipes.first.id;

    await provider.deleteRecipe(idToDelete);

    expect(
      provider.recipes.length,
      initialLength - 1,
      reason: 'Length should decrease by 1 after delete',
    );
    expect(
      provider.recipes.any((r) => r.id == idToDelete),
      false,
      reason: 'Deleted recipe should not be in the list',
    );
  });
}
