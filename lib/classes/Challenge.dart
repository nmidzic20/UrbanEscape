import 'package:flutter/material.dart';

class Challenge {
  late int id;
  late Widget question;
  late String answer;
  late bool optionsRadioButtons;
  late List<Widget> options;
  late String hint;
  late int points;
  late Function handleAnswer;

  Challenge(
      this.id,
      this.question,
      this.answer,
      this.optionsRadioButtons,
      this.options,
      this.hint,
      this.points,
      this.handleAnswer);
}