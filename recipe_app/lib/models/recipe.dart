class Recipe {
  final String id;
  final String title;
  final String description;
  final String category;
  final String time;              // ⏱ total time to make
  final List<String> ingredients;
  final List<String> steps;
  bool isFavorite;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.time,           // ⏱ required
    required this.ingredients,
    required this.steps,
    this.isFavorite = false,
  });
}
