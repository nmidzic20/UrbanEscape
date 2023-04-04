import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color.fromRGBO(38, 34, 53, 1); //deep purple
const COLOR = Color.fromRGBO(46, 49, 146, 1); //deep blue
const COLOR_SECONDARY = Color.fromRGBO(252, 82, 133, 1); //hot pink
const COLOR_BACKGROUND = Color.fromRGBO(72, 83, 122, 1); //grey blue

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.light,
        primary: COLOR_PRIMARY,
        secondary: COLOR_SECONDARY,
        background: COLOR_BACKGROUND),
    scaffoldBackgroundColor: COLOR_BACKGROUND);

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.dark,
        primary: COLOR_PRIMARY,
        secondary: COLOR_SECONDARY,
        background: COLOR_BACKGROUND),
    scaffoldBackgroundColor: COLOR_BACKGROUND);
/*
ThemeData lightTime1 = ThemeData(
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Colors.black12, brightness: Brightness.dark),
  textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white)),
  primaryColor: Colors.black,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black12,
  ),
  backgroundColor: Colors.grey,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.black12),
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(backgroundColor: Colors.black12),
  secondaryHeaderColor: Colors.white10,
);
*/