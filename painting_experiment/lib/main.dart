import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrawingBoard(),
    );
  }
}

class DrawingBoard extends StatefulWidget {
  const DrawingBoard({super.key});

  @override
  DrawingBoardState createState() => DrawingBoardState();
}

class DrawingBoardState extends State<DrawingBoard> {
  Color selectedColor = Colors.black;
  double strokeWidth = 5;
  List<DrawingPoint?> drawingPoints = [];
  bool isPainting = true;
  int currentIndex = 0;

  List<String> images = [
    'images/car.png',
    'images/flower.png',
    'images/house.png',
  ];

  List<Color> colors = [
    Colors.pink,
    Colors.red,
    Colors.black,
    Colors.yellow,
    Colors.amberAccent,
    Colors.purple,
    Colors.green,
  ];

  void togglePainting(bool status) {
    setState(() {
      isPainting = status;
    });
  }

  void nextImage() {
    setState(() {
      currentIndex = (currentIndex + 1) % images.length;
      drawingPoints = []; // Yeni resme geçildiğinde boyamaları temizler
    });
  }

  void previousImage() {
    setState(() {
      currentIndex = (currentIndex - 1 + images.length) % images.length;
      drawingPoints = []; // Yeni resme geçildiğinde boyamaları temizler
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                images[currentIndex], // Listeden resim çekiliyor
                fit: BoxFit.contain,
              ),
            ),
          ),
          GestureDetector(
            onPanStart: (details) {
              if (isPainting) {
                setState(() {
                  drawingPoints.add(
                    DrawingPoint(
                      details.localPosition,
                      Paint()
                        ..color = selectedColor
                        ..isAntiAlias = true
                        ..strokeWidth = strokeWidth
                        ..strokeCap = StrokeCap.round,
                    ),
                  );
                });
              }
            },
            onPanUpdate: (details) {
              if (isPainting) {
                setState(() {
                  drawingPoints.add(
                    DrawingPoint(
                      details.localPosition,
                      Paint()
                        ..color = selectedColor
                        ..isAntiAlias = true
                        ..strokeWidth = strokeWidth
                        ..strokeCap = StrokeCap.round,
                    ),
                  );
                });
              }
            },
            onPanEnd: (details) {
              if (isPainting) {
                setState(() {
                  drawingPoints.add(null);
                });
              }
            },
            child: CustomPaint(
              painter: _DrawingPainter(drawingPoints),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 30,
            child: Row(
              children: [
                Slider(
                  min: 0,
                  max: 40,
                  value: strokeWidth,
                  onChanged: (val) => setState(() => strokeWidth = val),
                ),
                ElevatedButton.icon(
                  onPressed: () => setState(() => drawingPoints = []),
                  icon: const Icon(Icons.clear),
                  label: const Text("Clear Board"),
                )
              ],
            ),
          ),
          Positioned(
            top: 100,
            right: 30,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    togglePainting(false);
                    previousImage();
                    Future.delayed(const Duration(milliseconds: 500), () {
                      togglePainting(true);
                    });
                  },
                  child: const Icon(Icons.arrow_back),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    togglePainting(false);
                    nextImage();
                    Future.delayed(const Duration(milliseconds: 500), () {
                      togglePainting(true);
                    });
                  },
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              colors.length,
              (index) => _buildColorChose(colors[index]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorChose(Color color) {
    bool isSelected = selectedColor == color;
    return GestureDetector(
      onTap: () => setState(() => selectedColor = color),
      child: Container(
        height: isSelected ? 47 : 40,
        width: isSelected ? 47 : 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
        ),
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> drawingPoints;

  _DrawingPainter(this.drawingPoints);

  List<Offset> offsetsList = [];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < drawingPoints.length; i++) {
      if (drawingPoints[i] != null && drawingPoints[i + 1] != null) {
        canvas.drawLine(drawingPoints[i]!.offset, drawingPoints[i + 1]!.offset,
            drawingPoints[i]!.paint);
      } else if (drawingPoints[i] != null && drawingPoints[i + 1] == null) {
        offsetsList.clear();
        offsetsList.add(drawingPoints[i]!.offset);

        canvas.drawPoints(
            PointMode.points, offsetsList, drawingPoints[i]!.paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DrawingPoint {
  Offset offset;
  Paint paint;

  DrawingPoint(this.offset, this.paint);
}
