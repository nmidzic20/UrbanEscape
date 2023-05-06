import 'package:flutter/material.dart';
import 'package:urban_escape/Puzzle.dart';

import 'Puzzles.dart';

class StoryStartScreen extends StatelessWidget {
  StoryStartScreen({super.key, required this.puzzleIndex}) {
    this.puzzle = (this.puzzleIndex < 1) ? puzzles[this.puzzleIndex] : puzzles[1];
  }

  final int puzzleIndex;
  late final Puzzle puzzle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(puzzle.title),
      ),
      body: Center(child: Column(children: [])),
    );
  }
}
