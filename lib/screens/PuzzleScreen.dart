import 'package:flutter/material.dart';
import 'package:urban_escape/classes/Puzzle.dart';
import 'package:urban_escape/widgets/Alert.dart';

import '../main.dart';
import '../theme/theme_constants.dart';
import '../widgets/RadioButton.dart';

class PuzzleScreen extends StatefulWidget {
  PuzzleScreen(this.puzzle, {Key? key}) : super(key: key);

  late final Puzzle puzzle;

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState(puzzle);
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  _PuzzleScreenState(this.puzzle);

  late final Puzzle puzzle;
  late ElevatedButton nextButton;

  @override
  void initState() {
    super.initState();
    nextButton = ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [Text('Next'), Icon(Icons.arrow_forward_rounded)],
      ),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
      onPressed: () {
        setState(() {
          puzzle.currentPrompt++;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (puzzle.currentPrompt == 0)
                Navigator.of(context).pop();
              else
                setState(() {
                  puzzle.currentPrompt--;
                });
            },
          );
        }),
        title: Center(
          child: Image.asset(
            "assets/logo_spin.gif",
            height: 50.0,
            width: 50.0,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.home_filled,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: (puzzle.prompts[puzzle.currentPrompt].templateScreen ==
                  TemplateScreen.FIRST)
              ? TemplateFirst(puzzle: puzzle, nextButton: nextButton)
              : TemplateSecond(puzzle: puzzle, nextButton: nextButton)),
      bottomNavigationBar: BottomAppBar(
        color: COLOR_PRIMARY,
        child: Row(
          children: [
            RawMaterialButton(
              onPressed: () {},
              elevation: 2.0,
              fillColor: (puzzle.prompts[puzzle.currentPrompt].timerPaused)
                  ? Colors.blueAccent
                  : Colors.pinkAccent,
              child: Icon(
                (puzzle.prompts[puzzle.currentPrompt].timerPaused)
                    ? Icons.pause
                    : Icons.timer,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10.0),
              shape: CircleBorder(),
            ),
            Text(
              "14:05",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.lightbulb_outline),
          backgroundColor: (puzzle.prompts[puzzle.currentPrompt].isChallenge)
              ? Colors.pinkAccent
              : Colors.grey,
          label: Text('Hint'),
          onPressed: (puzzle.prompts[puzzle.currentPrompt].isChallenge)
              ? () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Alert("Hint",
                        puzzle.prompts[puzzle.currentPrompt].challenge!.hint, [
                      ElevatedButton(
                        child: Text("OK",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ]);
                  })
              : null),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class TemplateFirst extends StatelessWidget {
  const TemplateFirst({
    super.key,
    required this.puzzle,
    required this.nextButton,
  });

  final Puzzle puzzle;
  final ElevatedButton nextButton;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Image.asset(puzzle.prompts[puzzle.currentPrompt].image_path),
      SizedBox(height: 10),
      Text(
        puzzle.prompts[puzzle.currentPrompt].title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child:
          puzzle.prompts[puzzle.currentPrompt].isChallenge
              ? puzzle.prompts[puzzle.currentPrompt].challenge!.question
              : puzzle.prompts[puzzle.currentPrompt].content!,
      ),
      puzzle.prompts[puzzle.currentPrompt].isChallenge
          ? RadioButton(puzzle.prompts[puzzle.currentPrompt].challenge!.options)
          : Text(""),
      nextButton,
    ]);
  }
}

class TemplateSecond extends StatelessWidget {
  const TemplateSecond({
    super.key,
    required this.puzzle,
    required this.nextButton,
  });

  final Puzzle puzzle;
  final ElevatedButton nextButton;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: double.maxFinite,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              SizedBox(height: 10),
              Text(
                puzzle.prompts[puzzle.currentPrompt].title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset(puzzle.poster_image_url),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child:
                  puzzle.prompts[puzzle.currentPrompt].isChallenge
                      ? puzzle.prompts[puzzle.currentPrompt].challenge!.question
                      : puzzle.prompts[puzzle.currentPrompt].content!,
              ),
              nextButton,
            ])));
  }
}
