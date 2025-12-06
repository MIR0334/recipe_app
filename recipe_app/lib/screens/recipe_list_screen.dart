import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipe_provider.dart';
import '../widgets/recipe_card.dart';
import 'add_recipe_screen.dart';

class RecipeListScreen extends StatelessWidget {
  final String category;

  const RecipeListScreen({
    super.key,
    required this.category,
  });

  Color _categoryColor(String category) {
    switch (category) {
      case 'Breakfast':
        return const Color(0xFFFFB74D);
      case 'Lunch':
        return const Color(0xFF4FC3F7);
      case 'Dinner':
        return const Color(0xFFBA68C8);
      case 'Work out':
        return const Color(0xFF66BB6A);
      case 'Own recipe':
        return const Color(0xFFFF8A65);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecipeProvider>();
    final baseColor = _categoryColor(category);

    // 🔹 Show loading indicator while recipes are being loaded from storage
    if (!provider.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: Text('$category Recipes'),
          backgroundColor: baseColor.withOpacity(0.85),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final allRecipes = provider.recipes;
    final recipes = allRecipes
        .where((recipe) => recipe.category == category)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$category Recipes'),
        backgroundColor: baseColor.withOpacity(0.85),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              baseColor.withOpacity(0.08),
              baseColor.withOpacity(0.02),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: recipes.isEmpty
            ? Center(
                child: Text(
                  'No recipes for "$category" yet.',
                  style: const TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                    recipe: recipes[index],
                    canDeleteCompletely: true,
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddRecipeScreen(category: category),
            ),
          );
        },
        backgroundColor: baseColor.withOpacity(0.9),
        icon: const Text('🍽'),
        label: const Text('Add your recipe'),
      ),
    );
  }
}
