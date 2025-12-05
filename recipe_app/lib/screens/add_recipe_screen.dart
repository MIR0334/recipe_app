import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/recipe.dart';
import '../providers/recipe_provider.dart';

class AddRecipeScreen extends StatefulWidget {
  final String category;

  const AddRecipeScreen({
    super.key,
    required this.category,
  });

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _timeController = TextEditingController();          // ⏱ new
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _timeController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    super.dispose();
  }

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

  String _categoryEmoji(String category) {
    switch (category) {
      case 'Breakfast':
        return '🥐';
      case 'Lunch':
        return '🥪';
      case 'Dinner':
        return '🍝';
      case 'Work out':
        return '🏋️‍♀️';
      case 'Own recipe':
        return '✨';
      default:
        return '🍽';
    }
  }

  void _saveRecipe() {
    if (!_formKey.currentState!.validate()) return;

    final ingredients = _ingredientsController.text
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    final steps = _stepsController.text
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    final newRecipe = Recipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      category: widget.category,
      time: _timeController.text.trim(),            // ⏱ save time
      ingredients: ingredients,
      steps: steps,
    );

    context.read<RecipeProvider>().addRecipe(newRecipe);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = _categoryColor(widget.category);
    final emoji = _categoryEmoji(widget.category);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add ${widget.category} recipe'),
        backgroundColor: baseColor.withOpacity(0.9),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              baseColor.withOpacity(0.10),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 48)),
                  const SizedBox(height: 8),
                  Text(
                    'Create your ${widget.category.toLowerCase()} recipe',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Give it a name, time, ingredients and steps, then save it to your cookbook.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Recipe name',
                            prefixIcon: Icon(Icons.restaurant_menu),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a recipe name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Time
                        TextFormField(
                          controller: _timeController,
                          decoration: const InputDecoration(
                            labelText: 'Time to make (e.g. 20 min)',
                            prefixIcon: Text(
                              '⏱',
                              style: TextStyle(fontSize: 20),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter an approximate time';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Description
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Short description',
                            prefixIcon: Icon(Icons.comment),
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 16),

                        // Ingredients
                        TextFormField(
                          controller: _ingredientsController,
                          decoration: const InputDecoration(
                            labelText: 'Ingredients (one per line)',
                            alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.list),
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 5,
                        ),
                        const SizedBox(height: 16),

                        // Steps
                        TextFormField(
                          controller: _stepsController,
                          decoration: const InputDecoration(
                            labelText: 'Steps (one step per line)',
                            alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.format_list_numbered),
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 6,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter at least one step';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _saveRecipe,
                            icon: const Text('🍽'),
                            label: const Text(
                              'Save recipe',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: baseColor.withOpacity(0.9),
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
