import 'package:flutter/material.dart';
import 'dart:async';

import 'package:urban_escape/classes/Prompt.dart';

import '../classes/Puzzle.dart';

class TimerWidget extends StatefulWidget {
  Puzzle puzzle;
  late Prompt currentPrompt;
  late bool isFunFactScreen;

  TimerWidget({super.key, required this.puzzle}) {
    currentPrompt = puzzle.prompts[puzzle.currentPrompt];
    isFunFactScreen = currentPrompt.templateScreen == TemplateScreen.SECOND;
  }

  @override
  TimerWidgetState createState() => TimerWidgetState();
}

// Define the state associated with TimerWidget
class TimerWidgetState extends State<TimerWidget> {
  // Stopwatch instance to track the elapsed time
  final Stopwatch _stopwatch = Stopwatch();

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
    //widget.currentPrompt.timerPaused = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  // Stops the stopwatch and cancels the timer
  void _stopStopwatch() {
    _stopwatch.stop();
    _timer.cancel();
    //widget.currentPrompt.timerPaused = true;
    setState(() {});
  }

  // Returns the short formatted time (hours and minutes)
  String getShortTime() {
    return _formattedTime;
  }

  // Returns the full formatted time (hours, minutes, and seconds)
  String getFullTime() {
    return _formattedFullTime;
  }

  //didUpdateWidget runs each time when parent widget (TimerWidget) runs, i.e. with each new prompt screen
  @override
  void didUpdateWidget(covariant TimerWidget oldWidget) {
    // Change detected when prompt changes from or to Fun fact template
    if (oldWidget.isFunFactScreen != widget.isFunFactScreen) {
      // if current prompt is fun fact screen, pause timer
      if (widget.isFunFactScreen) {
        _stopStopwatch();
      } else {
        _startStopwatch();
      }
    }

    //if this is the final puzzle screen, save total time to the puzzle data
    if (widget.puzzle.currentPrompt == widget.puzzle.promptsTotal - 1) {
      widget.puzzle.exploredTime = getFullTime();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

    _startStopwatch(); // Start timer when widget is loaded (this initState runs only once)
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          (widget.currentPrompt.timerPaused) ? Icons.pause : Icons.timer,
          color: Colors.white,
        ),
        const SizedBox(width: 10,),
        // Display the current time
        Text(
          _formattedFullTime,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: Colors.white),
        ),
        /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Start button - disabled if the stopwatch is already running
              Visibility(
                visible: widget.isChallenge,
                child: ElevatedButton(
                  onPressed: _stopwatch.isRunning ? null : _startStopwatch,
                  child: const Text('Start',
                      style: TextStyle(
                          color: Colors.white)), // Set the text color to white
                ),
              ),
              const SizedBox(width: 10),
              // Stop button - disabled if the stopwatch is not running
              Visibility(
                visible: widget.isChallenge,
                child: ElevatedButton(
                  onPressed: _stopwatch.isRunning ? _stopStopwatch : null,
                  child: const Text('Stop', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),*/
      ],
    );
  }
}
