import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/recipe.dart';
import '../providers/recipe_provider.dart';
import '../screens/recipe_detail_screen.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final bool isInFavoritesScreen;
  final bool canDeleteCompletely;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.isInFavoritesScreen = false,
    this.canDeleteCompletely = false,
  });

  @override
  Widget build(BuildContext context) {
    final recipeProvider = context.read<RecipeProvider>();

    Widget buildAnimatedStarButton() {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: IconButton(
          key: ValueKey<bool>(recipe.isFavorite),
          icon: Icon(
            recipe.isFavorite ? Icons.star : Icons.star_border,
          ),
          tooltip: recipe.isFavorite
              ? 'Remove from favourites'
              : 'Add to favourites',
          onPressed: () {
            recipeProvider.toggleFavorite(recipe.id);
          },
        ),
      );
    }

    Widget? trailing;

    if (isInFavoritesScreen) {
      trailing = IconButton(
        icon: const Icon(Icons.delete),
        tooltip: 'Remove from favourites',
        onPressed: () {
          recipeProvider.toggleFavorite(recipe.id);
        },
      );
    } else if (canDeleteCompletely) {
      trailing = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildAnimatedStarButton(),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete recipe',
            onPressed: () {
              recipeProvider.deleteRecipe(recipe.id);
            },
          ),
        ],
      );
    } else {
      trailing = buildAnimatedStarButton();
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        title: Hero(
          tag: 'recipe-title-${recipe.id}',
          child: Material(
            type: MaterialType.transparency,
            child: Text(
              recipe.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(recipe.description),
            const SizedBox(height: 4),
            Text(
              '⏱ ${recipe.time}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => RecipeDetailScreen(recipe: recipe),
            ),
          );
        },
        trailing: trailing,
      ),
    );
  }
}
