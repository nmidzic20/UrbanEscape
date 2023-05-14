import 'package:flutter/material.dart';
import 'package:urban_escape/classes/Puzzle.dart';
import 'package:urban_escape/widgets/Alert.dart';

import '../main.dart';
import '../shared.dart';
import '../theme/theme_constants.dart';
import '../theme/theme_manager.dart';
import '../widgets/NavDrawer.dart';
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
  late Prompt currentPrompt;
  late ElevatedButton nextButton;

  @override
  void initState() {
    super.initState();

    currentPrompt = puzzle.prompts[puzzle.currentPrompt];

    nextButton = ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [Text('Next'), Icon(Icons.arrow_forward_rounded)],
      ),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
      onPressed: () {

        if (puzzle.currentPrompt == puzzle.promptsTotal-1)
          {
            puzzle.currentPrompt = 0;
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Alert("Congratulations", "Story completed!", [
                    ElevatedButton(
                      child: Text("OK",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      },
                    )
                  ]);
                });
          }

        setState(() {
          if (currentPrompt.isChallenge) {

            String? givenAnswer = (currentPrompt.challenge!.optionsRadioButtons) ? selectedAnswer : userAnswer;

            bool result = currentPrompt.challenge!.handleAnswer(
                givenAnswer, currentPrompt.challenge!.answer, context);
            if (result) {
              puzzle.currentPrompt++;
              currentPrompt = puzzle.prompts[puzzle.currentPrompt];
            }
          } else {
            puzzle.currentPrompt++;
            currentPrompt = puzzle.prompts[puzzle.currentPrompt];
          }
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
            color: (puzzle.currentPrompt == 0 ||
                    !puzzle.prompts[puzzle.currentPrompt - 1].isChallenge)
                ? Colors.white
                : Colors.grey,
            onPressed: () {
              if (puzzle.currentPrompt == 0)
                Navigator.of(context).pop();
              else
                setState(() {
                  if (puzzle.currentPrompt != 0 &&
                      !puzzle.prompts[puzzle.currentPrompt - 1].isChallenge) {
                    puzzle.currentPrompt--;
                    currentPrompt = puzzle.prompts[puzzle.currentPrompt];
                  }
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
      drawer: NavDrawer(),
      body: SingleChildScrollView(
          child: (currentPrompt.templateScreen == TemplateScreen.FIRST)
              ? TemplateFirst(
                  puzzle: puzzle,
                  currentPrompt: currentPrompt,
                  nextButton: nextButton)
              : TemplateSecond(
                  puzzle: puzzle,
                  currentPrompt: currentPrompt,
                  nextButton: nextButton)),
      bottomNavigationBar: BottomAppBar(
        color: COLOR_PRIMARY,
        child: Row(
          children: [
            RawMaterialButton(
              onPressed: () {},
              elevation: 2.0,
              fillColor: (currentPrompt.timerPaused)
                  ? Colors.blueAccent
                  : Colors.pinkAccent,
              child: Icon(
                (currentPrompt.timerPaused) ? Icons.pause : Icons.timer,
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
          backgroundColor:
              (currentPrompt.isChallenge) ? Colors.pinkAccent : Colors.grey,
          label: Text('Hint'),
          onPressed: (currentPrompt.isChallenge)
              ? () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Alert("Hint", currentPrompt.challenge!.hint, [
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
    required this.currentPrompt,
    required this.nextButton,
  });

  final Puzzle puzzle;
  final Prompt currentPrompt;
  final ElevatedButton nextButton;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      SizedBox( width: double.infinity, height: 200, child: Image.asset(currentPrompt.image_path, fit: BoxFit.cover,)),
      SizedBox(height: 10),
      Text(
        currentPrompt.title,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: currentPrompt.isChallenge
            ? currentPrompt.challenge!.question
            : currentPrompt.content!,
      ),
      currentPrompt.isChallenge
          ? (currentPrompt.challenge!.optionsRadioButtons) ? RadioButton(currentPrompt.challenge!.options) : currentPrompt.challenge!.options!.first
          : Text(""),
      nextButton,
    ]);
  }

}

class TemplateSecond extends StatelessWidget {
  const TemplateSecond({
    super.key,
    required this.puzzle,
    required this.currentPrompt,
    required this.nextButton,
  });

  final Puzzle puzzle;
  final Prompt currentPrompt;
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
                currentPrompt.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset(currentPrompt.image_path),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: currentPrompt.isChallenge
                    ? currentPrompt.challenge!.question
                    : currentPrompt.content!,
              ),
              nextButton,
            ])));
  }
}
