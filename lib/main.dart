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
          title: Text('Test'),
        ),
        body: Stack(
            children: [
              // Background color
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE3E7FF),
                ),
              ),

              // ScoreCounter at top left
              Positioned(
                child: ScoreCounter(initialScore: 15000),
                top: 15,
                left: 15,
              ),

              // TimerWidget at top right
              Positioned(
                child: TimerWidget(),
                top: 15,
                right: 15,
              ),

              // QuestionWidget in the center
              Positioned(
                child: QuestionWidget(
                    question: "What's the meaning of life?",
                    correctAnswer: "42"
                ),
                bottom: 100,
                left: 55,
                right: 55,
              ),

              // HintWidget at bottom right
              Positioned(
                child: HintWidget(text: "This is a hint",),
                bottom: 15.0,
                right: 15.0,
              )
            ]
        ),
      ),
    );
  }
}
