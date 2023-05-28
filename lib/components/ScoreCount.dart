import 'package:flutter/material.dart';

import '../classes/Challenge.dart';
import '../classes/Puzzle.dart';

import 'package:flutter/material.dart';

import '../classes/Challenge.dart';
import '../classes/Puzzle.dart';

class ScoreCounter {
  // The initial score and the current Puzzle
  //final Puzzle? puzzle;
  late int score;

  // Constructor of ScoreCounter
  ScoreCounter(/*this.puzzle*/) {
    score = 0; // Set the initial score
  }

  // Decrease the score by one, used for testing
  void scoreTest() {
    score--;
    print("This is  score: $score");
  }

  // Decrease the score by one when a hint is used
  void hintUsed() {
    score--;
    print("Hint was used, current score: $score");
  }

  // Increase the total score by the points value of the challenge
  void increaseScore(/*Challenge challenge*/) {
    score++;
    //puzzle?.totalScore += challenge.points;
    print("This is the total score: $score");
  }

  // Decrease the total score by the answer attempts of the challenge
  void decreaseScore(/*Challenge challenge*/) {
    if (score > 0) {
      score--;
      //puzzle?.totalScore -= challenge.answerAttempts;
    }

    print("This is the total score: $score");
  }
}

class ScoreCounterWidget extends StatefulWidget {
  // The initial score and the current Puzzle
  final Puzzle? puzzle;

  // Constructor of ScoreCounter
  const ScoreCounterWidget({this.puzzle, Key? key}): super(key: key);

  // Method to find the closest ScoreCounterState in the widget tree
  static ScoreCounterWidgetState? of(BuildContext context) {
    return context.findAncestorStateOfType<ScoreCounterWidgetState>();
  }

  // Create the mutable state for this widget
  @override
  ScoreCounterWidgetState createState() => ScoreCounterWidgetState();
}

class ScoreCounterWidgetState extends State<ScoreCounterWidget> {
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
      //widget.puzzle?.totalScore += challenge.points;
    });
    print("This is the total score: $_score");
  }

  // Decrease the total score by the answer attempts of the challenge
  void decreaseScore(Challenge challenge) {
    setState(() {
      if (_score > 0) {
        _score--;
        //widget.puzzle!.totalScore -= challenge.answerAttempts;
      }
    });
    print("This is the total score: $_score");
  }

  // Define the UI of the widget
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFC5285),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 8.0,
          ),
          // Display the current score
          Text(
            'Score: $_score',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
