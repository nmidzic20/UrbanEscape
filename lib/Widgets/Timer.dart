import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;

  String get _formattedTime {
    final hours = (_stopwatch.elapsed.inSeconds / 3600).floor().toString().padLeft(2, '0');
    final minutes = ((_stopwatch.elapsed.inSeconds % 3600) / 60).floor().toString().padLeft(2, '0');
    return "$hours:$minutes";
  }
  String get _formattedFullTime {
    final hours = (_stopwatch.elapsed.inSeconds / 3600).floor().toString().padLeft(2, '0');
    final minutes = ((_stopwatch.elapsed.inSeconds % 3600) / 60).floor().toString().padLeft(2, '0');
    final seconds = (_stopwatch.elapsed.inSeconds % 60).floor().toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  void _startStopwatch() {
    _stopwatch.start();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  void _stopStopwatch() {
    _stopwatch.stop();
    _timer.cancel();
  }

  String getShortTime() {
    return _formattedTime;
  }

  String getFullTime(){
    return _formattedFullTime;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _formattedTime,
          style: TextStyle(fontSize: 16.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _stopwatch.isRunning ? null : _startStopwatch,
              child: Text('Start'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: _stopwatch.isRunning ? _stopStopwatch : null,
              child: Text('Stop'),
            ),
          ],
        ),
      ],
    );
  }
}
