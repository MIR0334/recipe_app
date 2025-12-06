import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipe_provider.dart';
import '../widgets/recipe_card.dart';
import 'add_recipe_screen.dart';

enum RecipeSort {
  none,
  titleAsc,
  titleDesc,
}

class RecipeListScreen extends StatefulWidget {
  final String category;

  const RecipeListScreen({
    super.key,
    required this.category,
  });

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  String _searchQuery = '';
  RecipeSort _sort = RecipeSort.none;

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

  List _applySearchAndSort(List recipes) {
    // Filter by search
    var filtered = recipes;
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      filtered = filtered
          .where((r) => r.title.toLowerCase().contains(q))
          .toList();
    }

    // Sort
    switch (_sort) {
      case RecipeSort.titleAsc:
        filtered.sort((a, b) =>
            a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      case RecipeSort.titleDesc:
        filtered.sort((a, b) =>
            b.title.toLowerCase().compareTo(a.title.toLowerCase()));
        break;
      case RecipeSort.none:
        // leave as is
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RecipeProvider>();
    final baseColor = _categoryColor(widget.category);

    // Loading state while SharedPreferences is initializing
    if (!provider.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: Text('${widget.category} Recipes'),
          backgroundColor: baseColor.withOpacity(0.85),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final allRecipes = provider.recipes;
    final categoryRecipes = allRecipes
        .where((recipe) => recipe.category == widget.category)
        .toList();

    final recipes = _applySearchAndSort(categoryRecipes);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Recipes'),
        backgroundColor: baseColor.withOpacity(0.85),
        actions: [
          PopupMenuButton<RecipeSort>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              setState(() {
                _sort = value;
              });
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: RecipeSort.none,
                child: Text('Default order'),
              ),
              PopupMenuItem(
                value: RecipeSort.titleAsc,
                child: Text('Title A–Z'),
              ),
              PopupMenuItem(
                value: RecipeSort.titleDesc,
                child: Text('Title Z–A'),
              ),
            ],
          ),
        ],
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
        child: Column(
          children: [
            // 🔍 Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search recipes...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.95),
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 8),

            // List / empty message
            Expanded(
              child: recipes.isEmpty
                  ? Center(
                      child: Text(
                        _searchQuery.isEmpty
                            ? 'No recipes for "${widget.category}" yet.'
                            : 'No recipes match your search.',
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddRecipeScreen(category: widget.category),
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
