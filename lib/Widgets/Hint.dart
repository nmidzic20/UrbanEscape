import 'package:flutter/material.dart';

class HintWidget extends StatelessWidget {
  final String text;
  // final Function onHintUsed;

  HintWidget({
    required this.text
    // , required this.onHintUsed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hint: '),
              content: Text(text),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    // onHintUsed();
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
      child: Text('Show Hint'),
    );
  }
}
