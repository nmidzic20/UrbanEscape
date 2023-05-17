import 'package:flutter/material.dart';

class AnswerCheck extends StatelessWidget {
  final TextEditingController _textFieldController = TextEditingController();
  final String _premadeString = "I WANNA DIE!!!";

  AnswerCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Question'),
                content: TextField(
                  controller: _textFieldController,
                  decoration: const InputDecoration(hintText: 'Answer'),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      String userInput = _textFieldController.text;
                      String result = '';
                      if (userInput == _premadeString) {
                        print("Correct answer: $userInput");
                        result = 'Correct answer!';
                      } else {
                        print(
                            "Wrong answer, the correct answer is: $_premadeString");
                        result = 'Wrong answer.';
                      }

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Answer Check'),
                            content: Text(result),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Text('User Input'));
  }
}
