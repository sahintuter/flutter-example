import 'package:flutter/material.dart';

import 'package:recipes_app/product/utility/color_utility.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key, required this.routePage});

  final Widget routePage;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => routePage));
      },
      backgroundColor: ColorUtility.cream,
      child: const Icon(Icons.favorite_border_outlined),
    );
  }
}
