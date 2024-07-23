import 'package:flutter/material.dart';
import 'package:recipes_app/product/models/recipesModel.dart';
import 'package:recipes_app/product/utility/color_utility.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorUtility.recipeCardBg,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRecipeImage(),
          _buildRecipeDetails(),
        ],
      ),
    );
  }

  Widget _buildRecipeImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
      child: recipe.image != null
          ? Image.network(
              recipe.image!,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            )
          : Container(
              color: Colors.grey[300],
              height: 150,
              width: double.infinity,
            ),
    );
  }

  Widget _buildRecipeDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRecipeName(),
          const SizedBox(height: 10),
          _buildDifficultyAndRating(),
          const SizedBox(height: 10),
          _buildCookingTime(),
        ],
      ),
    );
  }

  Widget _buildRecipeName() {
    return Text(
      recipe.name ?? 'No Name',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildDifficultyAndRating() {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.yellow),
        const SizedBox(width: 4.0),
        Text(
          recipe.rating != null ? recipe.rating!.toString() : 'No Rating',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        Text(
          recipe.difficulty ?? 'Unknown',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildCookingTime() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Text(
        recipe.cookTimeMinutes != null ? '${recipe.cookTimeMinutes} min' : 'No Time Info',
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}
