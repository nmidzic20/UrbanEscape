import 'package:flutter/material.dart';


class RadioButton extends StatefulWidget {
  RadioButton(this.options, {super.key});

  late List<Widget> options;

  @override
  State<RadioButton> createState() => _RadioButtonState(options);
}

class _RadioButtonState extends State<RadioButton> {

  _RadioButtonState(this.options);

  int? selectedValue = 0;

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
                    });
                  },
                ),
              );
            }),
      ))
    ]);
  }
}
