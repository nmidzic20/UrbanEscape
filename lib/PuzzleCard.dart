import 'package:flutter/material.dart';

import 'Puzzle.dart';
import 'Puzzles.dart';
import 'StoryStartScreen.dart';

class PuzzleCard extends StatelessWidget {
  PuzzleCard(this.index, {Key? key}) : super(key: key) {
    this.puzzle = (this.index < 1) ? puzzles[this.index] : puzzles[1];
  }

  late final int index;
  late final Puzzle puzzle;

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
          Navigator.push(
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
