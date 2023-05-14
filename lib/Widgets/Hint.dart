import 'package:flutter/material.dart';
import 'package:urban_escape/Classes/Puzzle.dart';
import 'ScoreCount.dart';

class QuestionWidget extends StatelessWidget {
  // The Challenge object which contains the question and answer
  final Challenge challenge;

  // Global key to access ScoreCounterState
  final GlobalKey<ScoreCounterState> scoreCountKey;

  // Constructor of QuestionWidget, takes challenge and scoreCountKey as parameters
  QuestionWidget({
    required this.challenge,
    required this.scoreCountKey
  });

  // Override the build method to define what UI components to include
  @override
  Widget build(BuildContext context) {
    // Use an ElevatedButton which shows the question upon being pressed
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFFFC5285),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      // Define what happens when the button is pressed
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // Define a TextEditingController to retrieve the user's answer
            TextEditingController answerController = TextEditingController();
            // Use an AlertDialog to display the question and get the user's answer
            return AlertDialog(
              title: Text('Question:'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // The question is taken from the challenge object
                  Text(challenge.question.toString()),
                  // The user's answer is entered in a TextField
                  TextField(
                    controller: answerController,
                    decoration: InputDecoration(labelText: 'Your answer'),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    String userAnswer = answerController.text;
                    // Check if the user's answer is correct
                    bool isCorrect = userAnswer == challenge.answer;
                    // Close the AlertDialog
                    Navigator.of(context).pop();

                    // If the answer is correct, increase the score, otherwise decrease it
                    if (isCorrect) {
                      ScoreCounter.of(context)?.increaseScore(challenge);
                    } else {
                      challenge.answerAttempts++;
                      ScoreCounter.of(context)?.decreaseScore(challenge);
                    }

                    // Show a dialog to inform the user if their answer is correct
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(isCorrect ? 'Correct!' : 'Incorrect!'),
                          content: Text(isCorrect
                              ? 'Your answer is correct!'
                              : 'Your answer is incorrect.'),
                          actions: [
                            // Include an 'OK' button to close the dialog
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Submit'),
                ),
              ],
            );
          },
        );
      },
      // The button displays 'Answer question'
      child: Text('Answer question'),
    );
  }
}
