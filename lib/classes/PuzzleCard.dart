import 'package:flutter/material.dart';
import 'package:urban_escape/main.dart';

import '../theme/theme_manager.dart';
import 'Puzzle.dart';
import './Puzzles.dart';
import '../screens/PuzzleScreenWelcome.dart';

class PuzzleCard extends StatelessWidget {
  PuzzleCard(this.puzzle, {Key? key}) : super(key: key);

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
                    builder: (context) => PuzzleScreenWelcome(id: puzzle.id),
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
            Text(puzzle.title, style: TextStyle(fontSize: 20, color: (themeManager.themeMode == ThemeMode.dark) ? Colors.white : Colors.black))
          ]),
        ),
      ),
    );
  }
}
