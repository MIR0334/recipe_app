import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/recipe.dart';
import '../data/sample_recipes.dart';

class RecipeProvider extends ChangeNotifier {
  static const _storageKey = 'recipes_v1';

  List<Recipe> _recipes = [];
  bool _isInitialized = false;

  RecipeProvider() {
    _loadRecipes();
  }

  List<Recipe> get recipes => _recipes;

  List<Recipe> get favorites =>
      _recipes.where((recipe) => recipe.isFavorite).toList();

  bool get isInitialized => _isInitialized;

  //  Load recipes from SharedPreferences OR fall back to sample data
  Future<void> _loadRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    if (jsonString == null) {
      // First run: seed with sample recipes and save
      _recipes = List.of(sampleRecipes);
      await _saveRecipes();
    } else {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString) as List<dynamic>;
        _recipes = decoded
            .map((item) => Recipe.fromMap(item as Map<String, dynamic>))
            .toList();
      } catch (e) {
        // If anything goes wrong, fall back to samples
        _recipes = List.of(sampleRecipes);
        await _saveRecipes();
      }
    }

    _isInitialized = true;
    notifyListeners();
  }

  //  Save current recipes list to SharedPreferences as JSON
  Future<void> _saveRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final listMap = _recipes.map((r) => r.toMap()).toList();
    final jsonString = jsonEncode(listMap);
    await prefs.setString(_storageKey, jsonString);
  }

  //  Toggle favourite and persist
  Future<void> toggleFavorite(String id) async {
    final recipe = _recipes.firstWhere((recipe) => recipe.id == id);
    recipe.isFavorite = !recipe.isFavorite;
    await _saveRecipes();
    notifyListeners();
  }

  //  Add recipe and persist
  Future<void> addRecipe(Recipe recipe) async {
    _recipes.add(recipe);
    await _saveRecipes();
    notifyListeners();
  }

  //  Delete recipe and persist
  Future<void> deleteRecipe(String id) async {
    _recipes.removeWhere((recipe) => recipe.id == id);
    await _saveRecipes();
    notifyListeners();
  }
}
