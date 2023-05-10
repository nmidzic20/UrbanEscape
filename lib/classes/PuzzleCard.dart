import 'package:flutter/material.dart';
import 'package:urban_escape/widgets/Alert.dart';

import '../Auth.dart';
import 'Puzzle.dart';
import './Puzzles.dart';
import '../screens/StartPuzzleScreen.dart';

class PuzzleCard extends StatelessWidget {
  PuzzleCard(this.index, {Key? key}) : super(key: key) {
    this.puzzle = (this.index < 1) ? puzzles[this.index] : puzzles[1];
  }

  late final int index;
  late final Puzzle puzzle;

  ElevatedButton registerButton = ElevatedButton(
    child: Text("Register"),
    style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
    onPressed: () {
      print("Register");
    },
  );

  ElevatedButton continueAsGuestButton = ElevatedButton(
    child: Text("Continue as a guest"),
    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
    onPressed: () {
      print("Continue as a guest");
    },
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          (!isLoggedIn)
              ? showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Alert(
                        "Dear guest,",
                        "To perform this action you need to register an account. We would love to have you on here!",
                        [registerButton, continueAsGuestButton]);
                  },
                )
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoryStartScreen(puzzleIndex: index),
                  ),
                );
        },
        child: SizedBox(
          width: 300,
          height: 200,
          child: Column(children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  puzzle.poster_image_url,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                ),
              ),
            ),
            Text(puzzle.title, style: TextStyle(fontSize: 20))
          ]),
        ),
      ),
    );
  }
}
