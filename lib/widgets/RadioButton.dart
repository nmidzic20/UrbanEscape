import 'package:flutter/material.dart';

int? selectedValue = 0;
String? selectedAnswer = "";

class RadioButton extends StatefulWidget {
  RadioButton(this.options, {super.key});

  late List<Widget> options;

  @override
  State<RadioButton> createState() => _RadioButtonState(options);
}

class _RadioButtonState extends State<RadioButton> {

  _RadioButtonState(this.options);

  late List<Widget> options;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: SizedBox(
            height: 200,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: options[index],
                leading: Radio<int>(
                  value: index,
                  groupValue: selectedValue,
                  onChanged: (int? value) {
                    setState(() {
                      selectedValue = value;
                      selectedAnswer = value.toString(); //in Puzzles, correct answers are given as string values of index
                    });
                  },
                ),
              );
            }),
      ))
    ]);
  }
}
