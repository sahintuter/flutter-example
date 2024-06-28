import 'package:flutter/material.dart';


class DragAndDrop extends StatefulWidget {
  @override
  _DragAndDropState createState() => _DragAndDropState();
}

class _DragAndDropState extends State<DragAndDrop> {
  List<String?> selectedAnimals = [null, null, null];
  List<String> animalNames = ["Duck", "Bird", "Dog", "Elephant", "Cat"];
  double rowValue = 2;
  late bool isClicked = false;
  static late double _maxHeight;

  late bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return DragTarget<String>(
                  onAccept: (animal) {
                    setState(() {
                      selectedAnimals[index] = animal;
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      width: 100,
                      height: 50,
                      child: Center(
                        child: selectedAnimals[index] != null
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                    // color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: Colors.grey, width: 3)),
                                child: Text(selectedAnimals[index]!,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              )
                            : Text('......................',
                                style: TextStyle(fontSize: 18)),
                      ),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: animalNames.map((animal) {
                return Draggable<String>(
                  data: animal,
                  feedback: Material(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        //color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.grey, width: 3),
                      ),
                      child: Text(animal,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                  ),
                  childWhenDragging: Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.grey, width: 2),
                    ),
                    child: Center(
                      child: Text(animal,
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      animal,
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      side: BorderSide(color: Colors.grey, width: 2),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedAnimals = [null, null, null];
                  isSelected = !isSelected;
                });
              },
              child: Text(
                "KONTROL ET",
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[600],
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40),
                backgroundColor: isSelected ? Colors.orange : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                side: BorderSide(color: Colors.grey, width: 4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
