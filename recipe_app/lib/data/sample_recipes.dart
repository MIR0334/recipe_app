import '../models/recipe.dart';

final List<Recipe> sampleRecipes = [
  //  BREAKFAST
  Recipe(
    id: 'b1',
    title: 'Fluffy Pancakes',
    description: 'Soft, fluffy pancakes perfect for a quick breakfast.',
    category: 'Breakfast',
    time: '20 min',
    ingredients: [
      '1 cup all-purpose flour',
      '1 tbsp sugar',
      '1 tsp baking powder',
      'Pinch of salt',
      '1 egg',
      '1 cup milk',
      '1 tbsp melted butter',
    ],
    steps: [
      'In a bowl, whisk together flour, sugar, baking powder and salt (1–2 min).',
      'In another bowl, whisk egg, milk and melted butter until smooth (1–2 min).',
      'Pour wet ingredients into dry and mix gently until just combined (do not overmix).',
      'Heat a lightly oiled pan on medium heat for 2–3 min.',
      'Pour about ¼ cup of batter per pancake and cook 2–3 min per side, until golden and cooked through.',
    ],
  ),
  Recipe(
    id: 'b2',
    title: 'Avocado Toast',
    description: 'Creamy avocado on crunchy toast.',
    category: 'Breakfast',
    time: '10 min',
    ingredients: [
      '2 slices bread',
      '1 ripe avocado',
      'Salt and pepper to taste',
      'Chili flakes (optional)',
      'Drizzle of olive oil (optional)',
    ],
    steps: [
      'Toast bread slices in a toaster or pan until golden (3–4 min).',
      'Cut avocado, remove the pit and scoop flesh into a bowl.',
      'Mash avocado with a fork and season with salt, pepper and optional olive oil.',
      'Spread avocado evenly on warm toast and sprinkle chili flakes if desired.',
    ],
  ),

  //  LUNCH
  Recipe(
    id: 'l1',
    title: 'Chicken Wrap',
    description: 'Healthy chicken wrap with fresh veggies.',
    category: 'Lunch',
    time: '25 min',
    ingredients: [
      '1 large tortilla wrap',
      '120 g cooked chicken breast, sliced',
      '½ cup shredded lettuce',
      '¼ cup diced tomatoes',
      '2 tbsp mayo or yogurt sauce',
    ],
    steps: [
      'Warm the tortilla in a dry pan over low heat for 30–60 seconds.',
      'Spread mayo or yogurt sauce down the center of the wrap.',
      'Layer sliced chicken, lettuce and tomatoes evenly.',
      'Fold in the sides and roll tightly from the bottom up.',
      'Slice the wrap in half on a diagonal and serve immediately.',
    ],
  ),
  Recipe(
    id: 'l2',
    title: 'Grilled Cheese Sandwich',
    description: 'Crispy golden bread with melted cheese.',
    category: 'Lunch',
    time: '15 min',
    ingredients: [
      '2 slices sandwich bread',
      '2 slices cheddar or cheese of choice',
      '1 tbsp butter, softened',
    ],
    steps: [
      'Butter one side of each bread slice evenly.',
      'Heat a non-stick pan over medium heat for 1–2 min.',
      'Place one slice of bread butter-side down, add cheese slices on top.',
      'Place second bread slice on top, butter-side up.',
      'Cook 3–4 min per side until bread is golden and cheese is fully melted.',
    ],
  ),

  //  DINNER
  Recipe(
    id: 'd1',
    title: 'Spaghetti Bolognese',
    description: 'Classic spaghetti with rich meat sauce.',
    category: 'Dinner',
    time: '35 min',
    ingredients: [
      '200 g spaghetti',
      '200 g ground beef',
      '1 cup tomato sauce',
      '1 small onion, chopped',
      '1 clove garlic, minced',
      '1 tbsp olive oil',
      'Salt and pepper to taste',
    ],
    steps: [
      'Boil a pot of salted water and cook spaghetti according to package (8–10 min).',
      'Heat olive oil in a pan on medium heat (1–2 min).',
      'Add onion and garlic, sauté until soft and fragrant (3–4 min).',
      'Add ground beef and cook until browned, breaking it up (5–7 min).',
      'Pour in tomato sauce, season with salt and pepper, and simmer on low heat for 10–12 min.',
      'Drain spaghetti and toss with the sauce or serve sauce on top.',
    ],
  ),
  Recipe(
    id: 'd2',
    title: 'Rice & Chicken Stir Fry',
    description: 'Quick stir-fry with chicken, veggies and rice.',
    category: 'Dinner',
    time: '25 min',
    ingredients: [
      '1 cup cooked rice (leftover rice works best)',
      '150 g chicken pieces',
      '1 cup mixed vegetables (frozen or fresh)',
      '2 tbsp soy sauce',
      '1 clove garlic, minced',
      '1 tbsp oil',
    ],
    steps: [
      'Heat oil in a large pan or wok over medium-high heat (1–2 min).',
      'Add chicken pieces and cook until no longer pink (5–7 min).',
      'Add garlic and mixed veggies, stir-fry until vegetables are tender (3–4 min).',
      'Add cooked rice and soy sauce, stir and fry everything together for 3–4 min.',
    ],
  ),

  //  WORK OUT
  Recipe(
    id: 'w1',
    title: 'Protein Oats Bowl',
    description: 'High-protein oatmeal for muscle recovery.',
    category: 'Work out',
    time: '10 min',
    ingredients: [
      '½ cup oats',
      '1 cup almond milk or water',
      '1 scoop protein powder',
      '1 banana, sliced',
      '1 tbsp peanut butter (optional)',
    ],
    steps: [
      'Add oats and almond milk to a small pot and bring to a gentle boil.',
      'Reduce heat and cook 3–4 min, stirring until thick and creamy.',
      'Remove from heat and stir in protein powder until smooth.',
      'Transfer to a bowl and top with banana slices and peanut butter.',
    ],
  ),
  Recipe(
    id: 'w2',
    title: 'Grilled Chicken & Broccoli',
    description: 'Lean, high-protein meal for workout days.',
    category: 'Work out',
    time: '30 min',
    ingredients: [
      '1 chicken breast',
      '1 cup broccoli florets',
      '1 tbsp olive oil',
      'Salt, pepper and seasoning to taste',
    ],
    steps: [
      'Season chicken breast with salt, pepper and your favourite spices.',
      'Heat a grill pan or regular pan with olive oil on medium heat (1–2 min).',
      'Cook chicken 6–8 min per side until fully cooked through.',
      'Steam or boil broccoli for 4–5 min until bright green and tender.',
      'Slice chicken and serve with broccoli on the side.',
    ],
  ),

  //  OWN RECIPE
  Recipe(
    id: 'o1',
    title: 'Your Signature Dish',
    description: 'A placeholder recipe you can edit or replace.',
    category: 'Own recipe',
    time: 'Varies',
    ingredients: [
      'Your ingredients here',
    ],
    steps: [
      'Write your ingredients and steps to create your own signature dish.',
    ],
  ),
];
