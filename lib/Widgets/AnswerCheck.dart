import 'package:flutter/material.dart';
import 'package:urban_escape/Classes/Puzzle.dart';
import 'ScoreCount.dart';

class AnswerCheckWidget extends StatelessWidget {
  final Challenge challenge;
  final GlobalKey<ScoreCounterState> scoreCountKey;

  // Default constructor
  AnswerCheckWidget({
    Challenge? challenge,
    required this.scoreCountKey
  }) : this.challenge = challenge ?? Challenge(
    0, // id
    Text('Default question'), // question
    'Default answer', // answer
    [], // options
    'Default hint', // hint
    0, // points
        (answer) {}, // handleAnswer
    answerAttempts: 0,
  );

  @override
  Widget build(BuildContext context) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFFFC5285),
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
                      decoration: InputDecoration(labelText: 'Your answer'),
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
                        challenge.answerAttempts++;
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
