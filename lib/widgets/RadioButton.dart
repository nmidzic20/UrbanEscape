import 'package:flutter/material.dart';

enum SingingCharacter { lafayette, jefferson }

class RadioButton extends StatefulWidget {
  RadioButton(this.options, {super.key});

  late List<Widget> options;

  @override
  State<RadioButton> createState() => _RadioButtonState(options);
}

class _RadioButtonState extends State<RadioButton> {

  _RadioButtonState(this.options);

  int? _character = 0;

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
                  value: index,//SingingCharacter.lafayette,
                  groupValue: _character,
                  onChanged: (int? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              );
            }),
      ))
    ]);
    /*children: <Widget>[
        ListTile(
          title: const Text('Lafayette'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.lafayette,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Thomas Jefferson'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.jefferson,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );*/
  }
}
