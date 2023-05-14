import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

// Define the state associated with TimerWidget
class _TimerWidgetState extends State<TimerWidget> {
  // Stopwatch instance to track the elapsed time
  Stopwatch _stopwatch = Stopwatch();

  // Timer instance to periodically update the UI
  late Timer _timer;

  // Returns the formatted time in hours and minutes
  String get _formattedTime {
    final hours = (_stopwatch.elapsed.inSeconds / 3600)
        .floor()
        .toString()
        .padLeft(2, '0');
    final minutes = ((_stopwatch.elapsed.inSeconds % 3600) / 60)
        .floor()
        .toString()
        .padLeft(2, '0');
    return "$hours:$minutes";
  }

  // Returns the full formatted time in hours, minutes, and seconds
  String get _formattedFullTime {
    final hours = (_stopwatch.elapsed.inSeconds / 3600)
        .floor()
        .toString()
        .padLeft(2, '0');
    final minutes = ((_stopwatch.elapsed.inSeconds % 3600) / 60)
        .floor()
        .toString()
        .padLeft(2, '0');
    final seconds =
    (_stopwatch.elapsed.inSeconds % 60).floor().toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  // Starts the stopwatch and sets up a timer to update the UI every second
  void _startStopwatch() {
    _stopwatch.start();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  // Stops the stopwatch and cancels the timer
  void _stopStopwatch() {
    _stopwatch.stop();
    _timer.cancel();
  }

  // Returns the short formatted time (hours and minutes)
  String getShortTime() {
    return _formattedTime;
  }

  // Returns the full formatted time (hours, minutes, and seconds)
  String getFullTime() {
    return _formattedFullTime;
  }

  @override
  void initState() {
    super.initState();
    _startStopwatch(); // Start the stopwatch as soon as the widget is loaded
  }

  // Cancels the timer when the widget is removed from the tree to prevent memory leaks
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Define the UI of the widget
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF262235), // Set the background color of the TimerWidget
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display the current time
          Text(
            'Timer: \n $_formattedFullTime',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.white), // Set the text color to white
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Start button - disabled if the stopwatch is already running
              ElevatedButton(
                onPressed: _stopwatch.isRunning ? null : _startStopwatch,
                child: Text('Start',
                    style: TextStyle(
                        color: Colors.white)), // Set the text color to white
              ),
              SizedBox(width: 10),
              // Stop button - disabled if the stopwatch is not running
              ElevatedButton(
                onPressed: _stopwatch.isRunning ? _stopStopwatch : null,
                child: Text('Stop', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
