import 'package:flutter/material.dart';
import 'Widgets/AnswerCheck.dart';
import 'Widgets/ResponseWidget.dart';
import 'Widgets/Hint.dart';
import 'Widgets/ScoreCount.dart';
import 'Widgets/Timer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Widgets',
      home: Scaffold(
        appBar: AppBar(
          title: Text('I AM SUFFERING'),
        ),
        body: Stack(children: [
          Positioned(child: Row(
            children: [
              Positioned(child: ScoreCounter(initialScore: 15000),
                right: 0,
              ),
              Positioned(
                child: CountdownTimer(hours: 0, minutes: 1, seconds: 30),
              )
            ],
          ),
            top: 15,
          ),

          Positioned(
            child: QuestionWidget(
                question: "What's the meaning of life?",
                correctAnswer: "42"
            ),
            bottom: 100,
            left: 55,
            right: 55,
          ),
          Positioned(
              child: HintWidget(text: "THIS IS A CRY FOR HELP",),
              bottom: 15.0,
              right: 15.0,
          )
      ])
    ));
  }
}
