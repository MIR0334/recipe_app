import 'package:flutter/foundation.dart';

import '../models/recipe.dart';
import '../data/sample_recipes.dart';

class RecipeProvider extends ChangeNotifier {
  final List<Recipe> _recipes = List.of(sampleRecipes);

  List<Recipe> get recipes => _recipes;

  List<Recipe> get favorites =>
      _recipes.where((recipe) => recipe.isFavorite).toList();

  void toggleFavorite(String id) {
    final recipe = _recipes.firstWhere((recipe) => recipe.id == id);
    recipe.isFavorite = !recipe.isFavorite;
    notifyListeners();
  }

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }

  void deleteRecipe(String id) {
    _recipes.removeWhere((recipe) => recipe.id == id);
    notifyListeners();
  }
}
