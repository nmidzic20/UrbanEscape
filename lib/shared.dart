import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_escape/theme/theme_manager.dart';

late SharedPreferences prefs;
bool themeChanged = false;
bool loggedInFirstTime = false;
bool firstPassAuthGate = true;

int loggedInCount = 0;
int currentPassAuthGate = 0;
int requiredPassesAuthGate = 2;

void setBoolToSharedPrefs(String key, bool value) {
  prefs.setBool(key, value);
}

bool getBoolValuesFromSharedPrefs(String key) {
  bool? boolValue = prefs.getBool(key);
  if (boolValue == null) boolValue = false;
  return boolValue;
}

class Player {
  Player(this.coinsAmount);

  int coinsAmount;
}

Player player = Player(0);

class AnswerTextField extends StatefulWidget {
  const AnswerTextField(this.correctAnswer, {super.key});

  final String correctAnswer;
  @override
  State<AnswerTextField> createState() => _AnswerTextFieldState();
}

String userAnswer = "";

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
      style: TextStyle(
          color: (themeManager.themeMode == ThemeMode.dark)
              ? Colors.white
              : Colors.black),
      controller: answerController,
      decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(),
          labelText: 'Answer: ' + widget.correctAnswer,
          labelStyle: TextStyle(
              color: Colors.grey)),
    );
  }
}
