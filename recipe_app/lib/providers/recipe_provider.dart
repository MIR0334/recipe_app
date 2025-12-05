import 'package:flutter/foundation.dart';

import '../models/recipe.dart';
import '../data/sample_recipes.dart';

class RecipeProvider extends ChangeNotifier {
  final List<Recipe> _recipes = sampleRecipes;

  List<Recipe> get recipes => _recipes;

  List<Recipe> get favorites =>
      _recipes.where((recipe) => recipe.isFavorite).toList();

  void toggleFavorite(String id) {
    final recipe = _recipes.firstWhere((recipe) => recipe.id == id);
    recipe.isFavorite = !recipe.isFavorite;
    notifyListeners();
  }
}
