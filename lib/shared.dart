import 'package:shared_preferences/shared_preferences.dart';

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