import 'package:drag_and_drop/drag_and_drop.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Drag And Drop',
   
      home:  DragAndDrop(),
    );
  }
}

