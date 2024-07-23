import 'package:flutter/material.dart';
import 'package:recipes_app/product/models/recipesModel.dart';
import 'package:recipes_app/product/services/recipesService.dart';
import 'package:recipes_app/product/utility/color_utility.dart';
import 'package:recipes_app/product/widgets/recipeCard/recipe_card.dart';


class RecipesView extends StatefulWidget {
  const RecipesView({super.key});

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
   late Future<RecipiesModel> _recipesFuture;

  @override
  void initState() {
    super.initState();
    _recipesFuture = Recipesservice().fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.appBgColor,
      body: FutureBuilder<RecipiesModel>(
        future: _recipesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          
           else if (snapshot.hasData) {
            final recipes = snapshot.data!.recipes;
            if (recipes.isEmpty) {
              return const Center(child: Text('No Recipes Found'));
            }
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return RecipeCard(recipe: recipes[index]);
              },
            );
          } else {
            return const Center(child: Text('No Data Available'));
          }
        },
      ),
    );
  }
}
