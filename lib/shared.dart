import 'package:shared_preferences/shared_preferences.dart';

import 'classes/Coin.dart';
import 'classes/Player.dart';

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


