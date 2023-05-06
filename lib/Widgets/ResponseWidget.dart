import 'package:flutter/material.dart';

class ResponseWidget extends StatelessWidget {
  late String input;

  ResponseWidget(String input){
    this.input = input;
  }
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () =>
          showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                AlertDialog(
                  content: const Text('AlertDialog description'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
          ),
      child: const Text('Show Dialog'),
    );
  }
}