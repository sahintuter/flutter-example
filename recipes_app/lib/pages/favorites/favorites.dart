import 'package:flutter/material.dart';
import 'package:recipes_app/product/constants/string_constants.dart';
import 'package:recipes_app/product/utility/color_utility.dart';
import 'package:recipes_app/product/widgets/appbar/custom_appbar.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorUtility.appBgColor,
      appBar: CustomAppbar(appbarText: StringConstants.favoriler),
      body: Center(
        child: Text("Favorites"),
      ),
    );
  }
}
