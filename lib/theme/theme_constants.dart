import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color.fromRGBO(38, 34, 53, 1); //deep purple
const COLOR = Color.fromRGBO(46, 49, 146, 1); //deep blue
const COLOR_SECONDARY = Color.fromRGBO(252, 82, 133, 1); //hot pink
const COLOR_BACKGROUND = Color.fromRGBO(72, 83, 122, 1); //grey blue
const COLOR_TEXT = Colors.white;

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
