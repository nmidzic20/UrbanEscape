import 'package:flutter/material.dart';
import 'package:urban_escape/classes/Puzzle.dart';
import 'package:urban_escape/components/Alert.dart';
import 'package:urban_escape/components/Camera.dart';
import 'package:urban_escape/components/Timer.dart';
import 'package:urban_escape/screens/PuzzleCompletedScreen.dart';

import '../classes/Prompt.dart';
import '../main.dart';
import '../shared.dart';
import '../theme/theme_constants.dart';
import '../components/NavDrawer.dart';
import '../components/RadioButton.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen(this.puzzle, {Key? key}) : super(key: key);

  final Puzzle puzzle;

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
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
      onPressed: () {
        if (puzzle.currentPrompt == puzzle.promptsTotal - 1) {
          //puzzle.currentPrompt = 0;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PuzzleCompletedScreen(puzzle),
            ),
          );

          return;
        }

        setState(() {
          if (currentPrompt.isChallenge) {
            String? givenAnswer = (currentPrompt.challenge!.optionsRadioButtons)
                ? selectedAnswer
                : userAnswer;

            bool isCorrectAnswer = handleAnswer(givenAnswer!, puzzle, context);
            if (isCorrectAnswer) {
              puzzle.currentPrompt++;
              currentPrompt = puzzle.prompts[puzzle.currentPrompt];

              // Reset the radio button values for the next question with radio buttons
              selectedValue = 0;
              selectedAnswer = "";
            }
          } else {
            puzzle.currentPrompt++;
            currentPrompt = puzzle.prompts[puzzle.currentPrompt];
          }
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [Text('Next'), Icon(Icons.arrow_forward_rounded)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            color: (puzzle.currentPrompt == 0 ||
                    !puzzle.prompts[puzzle.currentPrompt - 1].isChallenge)
                ? Colors.white
                : Colors.grey,
            onPressed: () {
              if (puzzle.currentPrompt == 0) {
                Navigator.of(context).pop();
              } else {
                setState(() {
                  if (puzzle.currentPrompt != 0 &&
                      !puzzle.prompts[puzzle.currentPrompt - 1].isChallenge) {
                    puzzle.currentPrompt--;
                    currentPrompt = puzzle.prompts[puzzle.currentPrompt];
                  }
                });
              }
            },
          );
        }),
        title: Center(
          child: Image.asset(
            "assets/logo_spin.gif",
            height: 50.0,
            width: 50.0,
          ).animate().fade().scale(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(
                Icons.home_filled,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      drawer: const NavDrawer(),
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
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: (currentPrompt.timerPaused)
                        ? MaterialStateProperty.all<Color>(Colors.blueAccent)
                        : MaterialStateProperty.all<Color>(Colors.pinkAccent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () {},
                child: TimerWidget(
                  puzzle: puzzle,
                )),
            const SizedBox(width: 30),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraWidget(),
                    ),
                  );
                },
                child: const Icon(Icons.camera))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.lightbulb_outline),
          backgroundColor:
              (currentPrompt.isChallenge) ? Colors.pinkAccent : Colors.grey,
          label: const Text('Hint'),
          onPressed: (currentPrompt.isChallenge)
              ? () {
                  puzzle.scoreCounter.hintUsed();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Alert("Hint", currentPrompt.challenge!.hint, [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pinkAccent),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          )
                        ]);
                      });
                }
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
      SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.asset(
            currentPrompt.image_path,
            fit: BoxFit.cover,
          ).animate().fade().scale()),
      const SizedBox(height: 10),
      Text(
        currentPrompt.title,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ).animate().fade().scale(),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: currentPrompt.isChallenge
            ? currentPrompt.challenge!.question.animate().fade().scale()
            : currentPrompt.content!.animate().fade().scale(),
      ),
      currentPrompt.isChallenge
          ? (currentPrompt.challenge!.optionsRadioButtons)
              ? RadioButton(currentPrompt.challenge!.options)
                  .animate()
                  .fade()
                  .scale()
              : currentPrompt.challenge!.options!.first.animate().fade().scale()
          : const Text(""),
      nextButton,
      const SizedBox(
        height: 80,
      )
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
              const SizedBox(height: 10),
              Text(
                currentPrompt.title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset(currentPrompt.image_path)
                      .animate()
                      .fade()
                      .scale(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: currentPrompt.isChallenge
                    ? currentPrompt.challenge!.question.animate().fade().scale()
                    : currentPrompt.content!.animate().fade().scale(),
              ),
              nextButton,
              const SizedBox(
                height: 50,
              )
            ])));
  }
}
