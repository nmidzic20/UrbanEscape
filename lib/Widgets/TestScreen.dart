import 'dart:async';
import 'package:flutter/material.dart';
import 'package:urban_escape/Widgets/AnswerCheck.dart';
import 'package:urban_escape/Widgets/Hint.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('Screen'),
          ),
          body: Center(
            child: Column(
              children: [
                HintWidget(),
              AnswerCheck(),
        ])

          ),
        );
  }
}
