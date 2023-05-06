import 'package:flutter/material.dart';

class AnswerCheck extends StatelessWidget {
  TextEditingController _textFieldController = TextEditingController();
  final String _premadeString = "yes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Answer Check'),
      ),
      body: Center(
        child: ElevatedButton(
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
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                AlertDialog(
                                  content: const Text('Correct Answer'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                  ],
                                ),
                          );
                        } else {
                          print("Wrong answer, the correct answer is: $_premadeString");
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  AlertDialog(
                                    content: const Text('Wrong Answer'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                    ],
                                  )
                          );
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
          child: const Text('User Input'),
        ),
      ),
    );
  }
}
