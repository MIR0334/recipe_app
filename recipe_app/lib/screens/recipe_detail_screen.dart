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
    final isFavorite = recipe.isFavorite;

    Color categoryColor(String category) {
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

    final headerColor = categoryColor(recipe.category);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: headerColor.withOpacity(0.9),
        title: Hero(
          tag: 'recipe-title-${recipe.id}',
          child: Material(
            type: MaterialType.transparency,
            child: Text(
              recipe.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        actions: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: IconButton(
              key: ValueKey<bool>(isFavorite),
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
              ),
              tooltip:
                  isFavorite ? 'Remove from favourites' : 'Add to favourites',
              onPressed: () {
                recipeProvider.toggleFavorite(recipe.id);
              },
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              headerColor.withOpacity(0.07),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            // Time
            Row(
              children: [
                const Text(
                  '⏱ ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  recipe.time,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Description
            if (recipe.description.isNotEmpty) ...[
              Text(
                recipe.description,
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Ingredients
            const Text(
              'Ingredients',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...recipe.ingredients.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Steps
            const Text(
              'Steps',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...recipe.steps.asMap().entries.map(
              (entry) {
                final stepIndex = entry.key + 1;
                final stepText = entry.value;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$stepIndex. ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          stepText,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
