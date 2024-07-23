import 'package:flutter/material.dart';
import 'package:recipes_app/pages/homepage/homepage_view.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: 'Recipex',
   debugShowCheckedModeBanner: false,
      home: HomepageView(),
    );
  }
}
