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
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, //#3B4FE6
        backgroundColor: Color(0xFF3B4FE6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Border radius
        ),
      ),
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
