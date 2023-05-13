import 'package:flutter/material.dart';
import 'package:urban_escape/Widgets/ScoreCount.dart';

class HintWidget extends StatefulWidget {
  final String text;
  final GlobalKey<ScoreCounterState> scoreCountKey;

  HintWidget({
    required this.text,
    required this.scoreCountKey,
  });

  @override
  _HintWidgetState createState() => _HintWidgetState();
}


class _HintWidgetState extends State<HintWidget> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF3B4FE6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Border radius
        ),
      ),
      onPressed: () {
        widget.scoreCountKey.currentState!.decreaseScore();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hint: '),
              content: Text(widget.text),
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
      child: Text('Show Hint'),
    );
  }
}
