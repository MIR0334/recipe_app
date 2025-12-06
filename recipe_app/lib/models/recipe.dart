class Recipe {
  final String id;
  final String title;
  final String description;
  final String category;
  final String time; // ⏱ total time to make
  final List<String> ingredients;
  final List<String> steps;
  final String? imagePath; 
  bool isFavorite;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.time,
    required this.ingredients,
    required this.steps,
    this.imagePath,          
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'time': time,
      'ingredients': ingredients,
      'steps': steps,
      'imagePath': imagePath,   //  include in JSON
      'isFavorite': isFavorite,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String? ?? '',
      category: map['category'] as String,
      time: map['time'] as String? ?? '',
      ingredients: List<String>.from(map['ingredients'] as List),
      steps: List<String>.from(map['steps'] as List),
      imagePath: map['imagePath'] as String?,      //  safe for old data
      isFavorite: map['isFavorite'] as bool? ?? false,
    );
  }
}
