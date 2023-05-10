import 'package:flutter/material.dart';
import 'dart:async';

class Timer extends StatefulWidget {
  final int hours;
  final int minutes;
  final int seconds;

  Timer({required this.hours, required this.minutes, required this.seconds});

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  late int _timeRemaining;
  bool _isRunning = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timeRemaining = widget.hours * 3600 + widget.minutes * 60 + widget.seconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          _stopTimer();
        }
      });
    });
  }

  void _stopTimer() {
    _timer.cancel();
    _isRunning = false;
  }

  @override
  void dispose() {
    if (_isRunning) {
      _stopTimer();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int hours = _timeRemaining ~/ 3600;
    int minutes = (_timeRemaining % 3600) ~/ 60;
    int seconds = _timeRemaining % 60;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
