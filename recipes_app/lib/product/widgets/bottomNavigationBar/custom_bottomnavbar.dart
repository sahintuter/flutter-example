import 'package:flutter/material.dart';
import 'package:recipes_app/product/constants/string_constants.dart';
import 'package:recipes_app/product/utility/border_radius_utility.dart';
import 'package:recipes_app/product/utility/color_utility.dart';

class CustomBottomnavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onIndexChanged;

  const CustomBottomnavbar({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: BorderRadiusUtility.radiusSmallx,
          topRight: BorderRadiusUtility.radiusSmallx),
      child: BottomNavigationBar(
        selectedItemColor: ColorUtility.coolGrey,
        backgroundColor: ColorUtility.cream,
        currentIndex: currentIndex,
        onTap: (int newIndex) {
          onIndexChanged(newIndex);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu_outlined),
              label: StringConstants.tarifler),
          BottomNavigationBarItem(
              icon: Icon(Icons.autorenew),
              label: StringConstants.rastgeleYemek),
        ],
      ),
    );
  }
}
