import 'package:flutter/material.dart';

import 'favorites_screen.dart';
import 'recipe_list_screen.dart';
import '../widgets/category_card.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = <_Category>[
      _Category(
        name: 'Breakfast',
        emoji: '🥐',
        color: const Color(0xFFFFB74D),
      ),
      _Category(
        name: 'Lunch',
        emoji: '🥪',
        color: const Color(0xFF4FC3F7),
      ),
      _Category(
        name: 'Dinner',
        emoji: '🍝',
        color: const Color(0xFFBA68C8),
      ),
      _Category(
        name: 'Work out',
        emoji: '🏋️‍♀️',
        color: const Color(0xFF66BB6A),
      ),
      _Category(
        name: 'Own recipe',
        emoji: '✨',
        color: const Color(0xFFFF8A65),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            tooltip: 'View favourites',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const FavoritesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF8E1),
              Color(0xFFFFF3E0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'What are we cooking today? 👩‍🍳',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Pick a category to explore recipes or add your own creations.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryCard(
                    title: category.name,
                    emoji: category.emoji,
                    color: category.color,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              RecipeListScreen(category: category.name),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Category {
  final String name;
  final String emoji;
  final Color color;

  _Category({
    required this.name,
    required this.emoji,
    required this.color,
  });
}
