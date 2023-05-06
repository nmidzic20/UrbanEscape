import 'dart:async';
import 'package:flutter/material.dart';

class ScoreScreen extends StatefulWidget {
  int initialScore;
  int maxScore;
  Duration countdownDuration;

  ScoreScreen({
    this.initialScore = 100,
    this.maxScore = 0,
    this.countdownDuration = const Duration(seconds: 30)
  });


  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  late int _score;
  late int _timeLeft;
  late Timer _countdownTimer;

  @override
  void initState() {
    super.initState();
    _score = widget.initialScore;
    _timeLeft = _calculateTimeLeft();
    _startCountdown();
  }

  @override
  void dispose() {
    _stopCountdown();
    super.dispose();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_score > widget.maxScore) {
          _score--;
          _timeLeft = _calculateTimeLeft();
        } else {
          _stopCountdown();
        }
      });
    });
  }

  void _stopCountdown() {
    _countdownTimer.cancel();
  }

  int _calculateTimeLeft() {
    int timeLeft = ((widget.countdownDuration.inSeconds * (widget.maxScore - _score)) / (widget.initialScore - widget.maxScore)).ceil();
    return timeLeft;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Score: $_score',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'Time left: $_timeLeft seconds',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          TextButton(
            child: Text('Stop'),
            onPressed: _stopCountdown,
          ),
        ],
      ),
    );
  }
}
