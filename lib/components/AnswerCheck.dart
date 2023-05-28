import 'package:flutter/material.dart';

import '../classes/Challenge.dart';
import 'ScoreCount.dart';

class AnswerCheckWidget extends StatelessWidget {
  final Challenge challenge;
  final GlobalKey<ScoreCounterWidgetState> scoreCountKey;

  // Default constructor
  AnswerCheckWidget({super.key,
    Challenge? challenge,
    required this.scoreCountKey
  }) : challenge = challenge ?? Challenge(
    0, // id
    const Text('Default question'), // question
    'Default answer', // answer
    false,
    [], // options
    'Default hint', // hint
    0, // points
        //(answer) {}, // handleAnswer

  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFFC5285),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController answerController = TextEditingController();
            return AlertDialog(
              // title: Text('Question:'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(challenge.question.toString()),
                  TextField(
                    controller: answerController,
                    decoration: const InputDecoration(labelText: 'Your answer'),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    String userAnswer = answerController.text;
                    bool isCorrect = userAnswer == challenge.answer;
                    Navigator.of(context).pop();

                    if (isCorrect) {
                      scoreCountKey.currentState!.increaseScore(challenge);
                    } else {
                      // challenge.answerAttempts++;
                      scoreCountKey.currentState!.decreaseScore(challenge);
                    }

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
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        );
      },
      child: const Text('Answer question'),
    );
  }
}