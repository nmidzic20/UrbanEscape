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
                child: TimerWidget(),
                top: 15,
                right: 15,
              ),

              // Positioned(
              //   child: QuestionWidget(
              //       challenge: Challenge(),
              //     scoreCountKey: key,
              //   ),
              //   bottom: 100,
              //   left: 55,
              //   right: 55,
              // ),

              // Positioned(
                // child: HintWidget(challenge: Challenge(),
                //   scoreCountKey: key,
                // ),
                // bottom: 15.0,
                // right: 15.0,
              // )
            ]
        ),
      ),
    );
  }
}
