import '../models/recipe.dart';

final List<Recipe> sampleRecipes = [
  Recipe(
    id: '1',
    title: 'Spaghetti Carbonara',
    description: 'A quick and creamy Italian pasta dish.',
    ingredients: [
      '200g spaghetti',
      '2 eggs',
      '100g pancetta',
      '50g parmesan cheese',
      'Salt & pepper',
    ],
    steps: [
      'Boil the pasta.',
      'Cook the pancetta until crispy.',
      'Whisk eggs and parmesan together.',
      'Combine pasta, egg mixture, and pancetta.',
      'Serve with pepper.',
    ],
    category: 'Dinner',
  ),
  Recipe(
    id: '2',
    title: 'Chicken Salad',
    description: 'Healthy and refreshing salad.',
    ingredients: [
      '1 chicken breast',
      'Lettuce',
      'Tomatoes',
      'Cucumber',
      'Olive oil',
    ],
    steps: [
      'Cook the chicken.',
      'Chop the vegetables.',
      'Mix together with olive oil.',
    ],
    category: 'Lunch',
  ),
];
