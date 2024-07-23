class RecipiesModel {
  RecipiesModel({
    required this.recipes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  final List<Recipe> recipes;
  final int? total;
  final int? skip;
  final int? limit;

  factory RecipiesModel.fromJson(Map<String, dynamic> json) {
    return RecipiesModel(
      recipes: json["recipes"] == null ? [] : List<Recipe>.from(json["recipes"]!.map((x) => Recipe.fromJson(x))),
      total: json["total"],
      skip: json["skip"],
      limit: json["limit"],
    );
  }
}

class Recipe {
  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.tags,
    required this.userId,
    required this.image,
    required this.rating,
    required this.reviewCount,
    required this.mealType,
  });

  final int? id;
  final String? name;
  final List<String> ingredients;
  final List<String> instructions;
  final int? prepTimeMinutes;
  final int? cookTimeMinutes;
  final int? servings;
  final String? difficulty;
  final String? cuisine;
  final int? caloriesPerServing;
  final List<String> tags;
  final int? userId;
  final String? image;
  final double? rating; // Değiştirildi: double
  final int? reviewCount;
  final List<String> mealType;

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json["id"],
      name: json["name"],
      ingredients: json["ingredients"] == null ? [] : List<String>.from(json["ingredients"]!.map((x) => x)),
      instructions: json["instructions"] == null ? [] : List<String>.from(json["instructions"]!.map((x) => x)),
      prepTimeMinutes: json["prepTimeMinutes"],
      cookTimeMinutes: json["cookTimeMinutes"],
      servings: json["servings"],
      difficulty: json["difficulty"],
      cuisine: json["cuisine"],
      caloriesPerServing: json["caloriesPerServing"],
      tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
      userId: json["userId"],
      image: json["image"],
      rating: (json["rating"] is int) ? (json["rating"] as int).toDouble() : json["rating"], // Güncelleme: int ise double'a çevir
      reviewCount: json["reviewCount"],
      mealType: json["mealType"] == null ? [] : List<String>.from(json["mealType"]!.map((x) => x)),
    );
  }
}
