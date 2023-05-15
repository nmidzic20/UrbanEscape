import 'package:flutter/material.dart';
import 'package:urban_escape/classes/Puzzle.dart';
import 'package:urban_escape/Widgets/ScoreCount.dart';

class HintWidget extends StatefulWidget {
  // The Challenge object which contains the hint, global key to access ScoreCounterState
  final Challenge challenge;
  final GlobalKey<ScoreCounterState> scoreCountKey;

  // Default constructor
  HintWidget({
    Challenge? challenge,
    required this.scoreCountKey
  }) : this.challenge = challenge ?? Challenge(
    0, // id
    Text('Default question'), // question
    'Default answer', // answer
    false,
    [], // options
    'Default hint', // hint
    0, // points
        (answer) {}, // handleAnswer
  );

  // Create the mutable state for this widget
  @override
  _HintWidgetState createState() => _HintWidgetState();
}

// The state class that goes along with HintWidget
class _HintWidgetState extends State<HintWidget> {
  // Override the build method to define what UI components to include
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
        // Call the hintUsed method of ScoreCounterState
        widget.scoreCountKey.currentState!.hintUsed();
        // Show a dialog with the hint
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // Use an AlertDialog to display the hint
            return AlertDialog(
              title: Text('Hint: '),
              // The hint is taken from the challenge object
              content: Text(widget.challenge.hint),
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
      // The button displays 'Show Hint'
      child: Text('Show Hint'),
    );
  }
}
