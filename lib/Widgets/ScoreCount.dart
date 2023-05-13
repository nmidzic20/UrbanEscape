import 'package:flutter/material.dart';

class ScoreCounter extends StatefulWidget {
  final int initialScore;

  const ScoreCounter({required this.initialScore, Key? key}): super(key: key);

  static ScoreCounterState? of(BuildContext context) {
    return context.findAncestorStateOfType<ScoreCounterState>();
  }

  @override
  ScoreCounterState createState() => ScoreCounterState();
}

class ScoreCounterState extends State<ScoreCounter> {
  late int _score;

  @override
  void initState() {
    super.initState();
    _score = widget.initialScore;
  }

  void decreaseScore() {
    setState(() {
      _score--;
      });
    print("This is  score: $_score");
  }
  
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
