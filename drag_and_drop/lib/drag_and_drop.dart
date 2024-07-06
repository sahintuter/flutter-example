import 'dart:math';
import 'package:flutter/material.dart';

class DragAndDropView extends StatefulWidget {
  const DragAndDropView({super.key});

  @override
  DragAndDropViewState createState() =>
      DragAndDropViewState();
}

class DragAndDropViewState
    extends State<DragAndDropView> with TickerProviderStateMixin {
  late List<String?> selectedKeyword;

  String exampleSentence = "Bu bir örnek cümle";

  List<String> keywordList = [];


  bool isSelected = false;

  double score = 0;

  @override
  void initState() {
    super.initState();
    keywordList = exampleSentence.split(' ')..shuffle(Random());
    selectedKeyword = List<String?>.filled(keywordList.length, null);
    
  }



  String getSelectedSentence() {
    return selectedKeyword.join(' ');
  }

  bool isSelectedSentenceCorrect() {
    String selectedSentence = getSelectedSentence();
    return selectedSentence.trim().toLowerCase() ==
        exampleSentence.trim().toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 20),
            fillBlankArea(),
            const SizedBox(height: 20),
            keywordArea(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => checkFunction(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Check',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget keywordArea() {
    return Wrap(
      spacing: 10,
      children: keywordList.map(
        (keyword) {
          return DragTarget<String>(
            onAcceptWithDetails: (DragTargetDetails<String> details) {
              setState(() {
                String acceptedKeyword = details.data;
                if (selectedKeyword.length < keywordList.length) {
                  selectedKeyword.add(acceptedKeyword);
                }
              });
            },
            builder: (context, candidateData, rejectedData) {
              return Draggable<String>(
                data: keyword,
                feedback: Material(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.grey, width: 3),
                    ),
                    child: Text(
                      keyword,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                childWhenDragging: Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey, width: 3),
                  ),
                  child: Center(
                    child: Text(
                      keyword,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(color: Colors.grey, width: 3),
                  ),
                  child: Text(
                    keyword,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }

  Widget fillBlankArea() {
    return Wrap(
      spacing: 10,
      children: List.generate(selectedKeyword.length, (index) {
        return SizedBox(
          width: 100,
          height: 60,
          child: DragTarget<String>(
            onAcceptWithDetails: (DragTargetDetails<String> details) {
              setState(() {
                String acceptedKeyword = details.data;
                if (index < selectedKeyword.length) {
                  selectedKeyword[index] = acceptedKeyword;
                } else {
                  selectedKeyword.add(acceptedKeyword);
                }
              });
            },
            builder: (context, candidateData, rejectedData) {
              return Center(
                child: selectedKeyword[index] != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.orange, width: 3),
                        ),
                        child: Text(
                          selectedKeyword[index]!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : const Text(
                        '.............',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                      ),
              );
            },
          ),
        );
      }),
    );
  }

  void checkFunction() {
    setState(() {
      bool isCorrect = isSelectedSentenceCorrect();

      if (isCorrect) {
        checkShowModalBottomSheet(context, isCorrect);
        score = 20;
      } else {
        checkShowModalBottomSheet(context, isCorrect);
      }
      selectedKeyword = List.filled(keywordList.length, null);
      isSelected = !isSelected;
    });
  }

  Future<dynamic> checkShowModalBottomSheet(BuildContext context, bool isCorrect) {
    return showModalBottomSheet(
      barrierColor: Colors.transparent,
      isDismissible: false,
      context: context,
      builder: (context) => Container(
        height: 200,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isCorrect ? 'Correct!' : 'Incorrect!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
