import 'package:flutter/material.dart';
import 'package:urban_escape/Classes/Puzzle.dart';

class ScoreCounter extends StatefulWidget {
  // The initial score and the current Puzzle
  final Puzzle? puzzle;

  // Constructor of ScoreCounter
  const ScoreCounter({this.puzzle, Key? key}): super(key: key);

  // Method to find the closest ScoreCounterState in the widget tree
  static ScoreCounterState? of(BuildContext context) {
    return context.findAncestorStateOfType<ScoreCounterState>();
  }

  // Create the mutable state for this widget
  @override
  ScoreCounterState createState() => ScoreCounterState();
}

class ScoreCounterState extends State<ScoreCounter> {
  late int _score;

  // Initialize the state
  @override
  void initState() {
    super.initState();
    _score = 0; // Set the initial score
  }

  // Decrease the score by one, used for testing
  void scoreTest() {
    setState(() {
      _score--;
    });
    print("This is  score: $_score");
  }

  // Decrease the score by one when a hint is used
  void hintUsed(){
    setState(() {
      _score--;
    });
    print("Hint was used, current score: $_score");
  }

  // Increase the total score by the points value of the challenge
  void increaseScore(Challenge challenge) {
    setState(() {
      _score++;
      // widget.puzzle?.totalScore += challenge.points;
    });
    print("This is the total score: ${widget.puzzle?.totalScore}");
  }

  // Decrease the total score by the answer attempts of the challenge
  void decreaseScore(Challenge challenge) {
    setState(() {
      if (widget.puzzle?.totalScore != null && widget.puzzle!.totalScore > 0) {
        _score--;
        // widget.puzzle!.totalScore -= challenge.answerAttempts;
      }
    });
    print("This is the total score: ${widget.puzzle?.totalScore}");
  }

  // Define the UI of the widget
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFC5285),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 8.0,
          ),
          // Display the current score
          Text(
            'Score: $_score',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
