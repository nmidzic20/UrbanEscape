import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnswerCheck extends StatelessWidget {
  TextEditingController _textFieldController = TextEditingController();
  final String _premadeString = "I WANNA DIE!!!";

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Question'),
                content: TextField(
                  controller: _textFieldController,
                  decoration: InputDecoration(hintText: 'Answer'),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('CANCEL'),
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
