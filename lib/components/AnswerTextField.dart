import 'package:flutter/material.dart';

import '../shared.dart';
import '../theme/theme_manager.dart';

class AnswerTextField extends StatefulWidget {
  const AnswerTextField(this.correctAnswer, {super.key});

  final String correctAnswer;
  @override
  State<AnswerTextField> createState() => _AnswerTextFieldState();
}


class _AnswerTextFieldState extends State<AnswerTextField> {
  final answerController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    answerController.addListener(() {
      userAnswer = answerController.text;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
          color: Colors.black),
      controller: answerController,
      decoration: InputDecoration(
          filled: true,
          border: const OutlineInputBorder(),
          labelText: 'Answer: ${widget.correctAnswer}',
          labelStyle: const TextStyle(
              color: Colors.grey)),
    );
  }
}
