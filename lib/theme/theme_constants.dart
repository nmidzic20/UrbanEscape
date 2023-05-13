import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color.fromRGBO(38, 34, 53, 1); //deep purple
const COLOR_PRIMARY_VARIANT = Color.fromRGBO(46, 49, 146, 1); //deep blue
const COLOR_SECONDARY = Colors.pinkAccent;//Color.fromRGBO(252, 82, 133, 1); //hot pink
const COLOR_BACKGROUND = Color.fromRGBO(76, 86, 107, 1.0); //grey blue
const COLOR_TEXT = Colors.white;

const LINEAR_GRADIENT = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment(0.8, 1),
  colors: <Color>[
    Color(0xff1f005c),
    Color(0xff5b0060),
    Color(0xff870160),
    Color(0xffac255e),
  ],
  tileMode: TileMode.mirror,
);

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.light,
        primary: COLOR_PRIMARY,
        secondary: COLOR_SECONDARY,
        background: COLOR_BACKGROUND),
    textTheme:
    TextTheme(
      headlineLarge: TextStyle(color: COLOR_TEXT),
      headlineMedium: TextStyle(color: COLOR_TEXT),
      headlineSmall: TextStyle(color: COLOR_TEXT),
      bodyLarge: TextStyle(color: COLOR_TEXT),
      bodyMedium: TextStyle(color: COLOR_TEXT),
      bodySmall: TextStyle(color: COLOR_TEXT),
      titleLarge: TextStyle(color: COLOR_TEXT),
      titleMedium: TextStyle(color: COLOR_TEXT),
      titleSmall: TextStyle(color: COLOR_TEXT),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.pinkAccent,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: COLOR_TEXT),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              style: BorderStyle.solid,
              color: COLOR_TEXT
          ),
        )
    ),
    scaffoldBackgroundColor: COLOR_BACKGROUND);

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.dark,
        primary: COLOR_PRIMARY,
        secondary: COLOR_SECONDARY,
        background: COLOR_BACKGROUND),
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: COLOR_TEXT),
      headlineMedium: TextStyle(color: COLOR_TEXT),
      headlineSmall: TextStyle(color: COLOR_TEXT),
      bodyLarge: TextStyle(color: COLOR_TEXT),
      bodyMedium: TextStyle(color: COLOR_TEXT),
      bodySmall: TextStyle(color: COLOR_TEXT),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.pinkAccent,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: COLOR_TEXT),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              style: BorderStyle.solid,
              color: COLOR_TEXT
          ),
        )
    ),
    scaffoldBackgroundColor: COLOR_BACKGROUND);
