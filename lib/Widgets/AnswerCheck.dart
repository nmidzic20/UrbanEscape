import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String question;
  final String correctAnswer;

  QuestionWidget({required this.question, required this.correctAnswer});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController answerController = TextEditingController();
            return AlertDialog(
              title: Text('Question:'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question),
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
                    bool isCorrect = userAnswer == correctAnswer;
                    Navigator.of(context).pop();

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(isCorrect ? 'Correct!' : 'Incorrect!'),
                          content: Text(isCorrect
                              ? 'Your answer is correct!'
                              : 'Your answer is incorrect.'),
                          actions: [
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
      child: Text('Answer question'),
    );
  }
}
