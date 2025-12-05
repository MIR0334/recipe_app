import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipe_provider.dart';
import '../widgets/recipe_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<RecipeProvider>().favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text('You have no favourite recipes yet.'),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return RecipeCard(
                  recipe: favorites[index],

                  
                  isInFavoritesScreen: true,
                );
              },
            ),
    );
  }
}
