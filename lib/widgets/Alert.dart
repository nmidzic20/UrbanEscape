import 'package:flutter/material.dart';
import 'package:urban_escape/theme/theme_constants.dart';

class Alert extends StatelessWidget {
  Alert(this.title, this.message, this.buttons, {Key? key}) : super(key: key);

  late final String title;
  late final String message;
  late final List<ElevatedButton> buttons;

  @override
  Widget build(BuildContext context) {
    return showAlertDialog(context);
  }

  showAlertDialog(BuildContext context) {


    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      backgroundColor: COLOR_BACKGROUND,//Color.fromRGBO(230, 230, 250, 1),
      content: Text(message),
      actions: buttons,
    );

    return alert;
  }
}