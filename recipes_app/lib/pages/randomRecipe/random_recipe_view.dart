import 'dart:math';

import 'package:flutter/material.dart';
import 'package:recipes_app/product/models/recipesModel.dart';
import 'package:recipes_app/product/services/recipesService.dart';
import 'package:recipes_app/product/utility/color_utility.dart';
import 'package:recipes_app/product/widgets/recipeCard/recipe_card.dart';

class RandomRecipeView extends StatefulWidget {
  const RandomRecipeView({super.key});

  @override
  State<RandomRecipeView> createState() => _RandomRecipeViewState();
}

class _RandomRecipeViewState extends State<RandomRecipeView> {
  late Future<List<Recipe>> _randomRecipesFuture;

  @override
  void initState() {
    super.initState();
    _randomRecipesFuture = _fetchRandomRecipes();
  }

  Future<List<Recipe>> _fetchRandomRecipes() async {
    final allRecipes = await Recipesservice().fetchRecipes();
    final random = Random();
    final randomRecipes = List<Recipe>.from(allRecipes.recipes)
      ..shuffle(random);
    return randomRecipes.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorUtility.appBgColor,
      body: FutureBuilder<List<Recipe>>(
        future: _randomRecipesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }else if (snapshot.hasError){
            return Center(child: Text('Error: ${snapshot.error}'),);
          }else if (snapshot.hasData){
            final recipes = snapshot.data;
            return ListView.builder( itemCount: recipes?.length, itemBuilder: (context,index){
              return RecipeCard(recipe: recipes![index]);
            },
            );
          }
          else{
             return const Center(child: Text('No Data Available'));
          }
        },
      ),
    );
  }
}
