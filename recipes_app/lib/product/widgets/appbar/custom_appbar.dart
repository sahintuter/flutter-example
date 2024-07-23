import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipes_app/product/constants/string_constants.dart';
import 'package:recipes_app/product/utility/color_utility.dart';


class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppbar({super.key, required this.appbarText});

final String appbarText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
              StringConstants.appName,
              style: GoogleFonts.lobster(
        textStyle: Theme.of(context).textTheme.headlineLarge),
            ),
        centerTitle: true,
        backgroundColor: ColorUtility.cream,
      );
  }
  @override
  Size get preferredSize => const Size.fromHeight(100);
  


}