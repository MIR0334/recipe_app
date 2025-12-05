import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/recipe.dart';
import '../providers/recipe_provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    final recipeProvider = context.watch<RecipeProvider>();
    final updatedRecipe = recipeProvider.recipes
        .firstWhere((r) => r.id == recipe.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(updatedRecipe.title),
        actions: [
          IconButton(
            icon: Icon(
              updatedRecipe.isFavorite
                  ? Icons.star
                  : Icons.star_border,
            ),
            onPressed: () {
              recipeProvider.toggleFavorite(updatedRecipe.id);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              updatedRecipe.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...updatedRecipe.ingredients.map(
              (item) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.circle, size: 8),
                title: Text(item),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...updatedRecipe.steps.asMap().entries.map(
              (entry) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 10,
                  child: Text('${entry.key + 1}',
                      style: const TextStyle(fontSize: 12)),
                ),
                title: Text(entry.value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
