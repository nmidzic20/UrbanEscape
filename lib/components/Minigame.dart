import 'package:flutter/material.dart';
import 'package:maze/maze.dart';
import 'package:urban_escape/classes/Puzzle.dart';

import '../classes/Challenge.dart';
import '../theme/theme_constants.dart';
import 'RadioButton.dart';

class GameScreen extends StatefulWidget {
  GameScreen(this.puzzle, this.onPressed, {super.key}) {
    challenge = puzzle.prompts[puzzle.currentPrompt]
        .challenge!; //puzzle.prompts[1].challenge!;
    options = challenge.options;
    for (int i = 0; i < options.length; i++) {
      Icon ic = options[i] as Icon;
      iconDataList.add(ic.icon!);
    }
  }

  Puzzle puzzle;
  late Challenge challenge;
  late List<Widget> options;
  List<IconData> iconDataList = <IconData>[];
  VoidCallback? onPressed;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  IconData? targetIcon;
  String selectedIconIdentifier = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mini Game'),
        ),
        body: Container(
          decoration: const BoxDecoration(gradient: LINEAR_GRADIENT),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const SizedBox(width: 16.0),
            Draggable<String>(
              data: 'mascot',
              feedback: Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    'assets/images/maskota_small.png',
                    height: 50,
                    width: 50,
                  )),
              childWhenDragging: Image.asset(
                'assets/images/maskota_small.png',
                height: 50,
                width: 50,
                color: Colors.transparent,
              ),
              child: Image.asset(
                'assets/images/maskota_small.png',
                height: 50,
                width: 50,
              ),
            ),
            const SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                DragTarget<String>(
                  builder: (context, candidateData, rejectedData) {
                    return Icon(
                      widget.iconDataList[0],
                      size: 50,
                      color: targetIcon == widget.iconDataList[0]
                          ? Colors.pinkAccent
                          : Colors.grey,
                    );
                  },
                  onWillAccept: (data) {
                    return true;
                  },
                  onAccept: (data) {
                    setState(() {
                      targetIcon = widget.iconDataList[0];
                      selectedIconIdentifier = 'Icon 0';
                      print(selectedIconIdentifier);
                      selectedValue = 0;
                      selectedAnswer = "0";
                      widget.onPressed!();
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                DragTarget<String>(
                  builder: (context, candidateData, rejectedData) {
                    return Icon(
                      widget.iconDataList[1],
                      size: 50,
                      color: targetIcon == widget.iconDataList[1]
                          ? Colors.pinkAccent
                          : Colors.grey,
                    );
                  },
                  onWillAccept: (data) {
                    return true;
                  },
                  onAccept: (data) {
                    setState(() {
                      targetIcon = widget.iconDataList[1];
                      selectedIconIdentifier = 'Icon 1';
                      print(selectedIconIdentifier);
                      selectedValue = 1;
                      selectedAnswer = "1";
                      widget.onPressed!();
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                DragTarget<String>(
                  builder: (context, candidateData, rejectedData) {
                    return Icon(
                      widget.iconDataList[2],
                      size: 50,
                      color: targetIcon == widget.iconDataList[2]
                          ? Colors.pinkAccent
                          : Colors.grey,
                    );
                  },
                  onWillAccept: (data) {
                    return true;
                  },
                  onAccept: (data) {
                    setState(() {
                      targetIcon = widget.iconDataList[2];
                      selectedIconIdentifier = '2';
                      print(selectedIconIdentifier);
                      selectedValue = 2;
                      selectedAnswer = "2";
                      widget.onPressed!();
                    });
                  },
                ),
              ],
            )
          ]),
        ));
  }
}

class MazeScreen extends StatefulWidget {
  const MazeScreen({super.key});

  @override
  _MazeScreenState createState() => _MazeScreenState();
}

class _MazeScreenState extends State<MazeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Maze(
                player: MazeItem(
                    'assets/images/maskota_small.png', ImageType.asset),
                columns: 6,
                rows: 12,
                wallThickness: 4.0,
                wallColor: Theme.of(context).primaryColor,
                checkpoints: [
                  MazeItem('assets/images/maskota_small.png', ImageType.asset),
                  MazeItem('assets/images/maskota_small.png', ImageType.asset),
                  MazeItem('assets/images/maskota_small.png', ImageType.asset),
                ],
                onCheckpoint: (id) => print("CHECK " + id.toString()),
                finish: MazeItem(
                    'assets/images/maskota_small.png', ImageType.asset),
                onFinish: () => print('Hi from finish line!'))));
  }
}
