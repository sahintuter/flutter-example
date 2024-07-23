import 'package:flutter/material.dart';
import 'package:recipes_app/pages/favorites/favorites.dart';
import 'package:recipes_app/pages/randomRecipe/random_recipe_view.dart';
import 'package:recipes_app/pages/recipes/recipes_view.dart';
import 'package:recipes_app/product/constants/string_constants.dart';
import 'package:recipes_app/product/utility/color_utility.dart';
import 'package:recipes_app/product/widgets/appbar/custom_appbar.dart';
import 'package:recipes_app/product/widgets/bottomNavigationBar/custom_bottomnavBar.dart';
import 'package:recipes_app/product/widgets/floatingActionButton/custom_floating_action_button.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  int _currentIndex = 0;

  List<Widget> pages = [
    const RecipesView(),
    const RandomRecipeView(),
  ];

  void _onBottomNavBarTap(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtility.appBgColor,
      appBar: const CustomAppbar(appbarText: StringConstants.appName),
      body: SafeArea(
        child: pages[_currentIndex],
      ),
      floatingActionButton:
          const CustomFloatingActionButton(routePage: Favorites()),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: CustomBottomnavbar(
        currentIndex: _currentIndex,
        onIndexChanged: _onBottomNavBarTap,
      ),
    );
  }
}
