import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'classes/Coin.dart';
import 'classes/Player.dart';
import 'classes/Prompt.dart';
import 'classes/Puzzle.dart';
import 'components/Alert.dart';
import 'package:camera/camera.dart';

late CameraDescription firstCamera;

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
  boolValue ??= false;
  return boolValue;
}

String userAnswer = "";

handleAnswer(String selectedAnswer, Puzzle puzzle, context) {
  Prompt currentPrompt = puzzle.prompts[puzzle.currentPrompt];
  print("Selected answer: ${selectedAnswer} Correct answer: ${currentPrompt.challenge!.answer}");

  String message = "";

  if (selectedAnswer == currentPrompt.challenge!.answer) {
    message = "Correct!";

    puzzle.scoreCounter.increaseScore();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text(message),
    ));
  } else {
    message = "Incorrect :( Try again!";

    puzzle.scoreCounter.decreaseScore();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Alert("", message, [
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            )
          ]);
        });
  }

  return selectedAnswer == currentPrompt.challenge!.answer;
}


