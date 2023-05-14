import 'package:flutter/material.dart';
import 'Widgets/AnswerCheck.dart';
import 'Widgets/Hint.dart';
import 'Widgets/ScoreCount.dart';
import 'Widgets/Timer.dart';
import 'Classes/Puzzle.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var scoreCounter = ScoreCounter(
        initialScore: 1500,
        key: GlobalKey<ScoreCounterState>()
    );
    GlobalKey<ScoreCounterState> key = scoreCounter.key as GlobalKey<ScoreCounterState>;

    return MaterialApp(
      title: 'Flutter Widgets',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE3E7FF),
                ),
              ),

              Positioned(
                child: scoreCounter,
                top: 15,
                left: 15,
              ),

              Positioned(
                  child: AnswerCheckWidget(
                    scoreCountKey: key,
                  ),
                  bottom: 120,
                  left: 35,
                  right: 35
              ),

              Positioned(
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  color: Color(0xFF262235),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TimerWidget(),
                      HintWidget(scoreCountKey: key),
                    ],
                  ),
                ),
                bottom: 0,
                left: 0,
                right: 0,
              ),
            ]
        ),
      ),
    );
  }
}
