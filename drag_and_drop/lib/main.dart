
import 'package:flutter/material.dart';
import 'package:drag_and_drop/drag_and_drop.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Drag And Drop',
   
      home:  DragAndDropView(),
    );
  }
}

