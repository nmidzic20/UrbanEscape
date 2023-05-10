import 'package:flutter/material.dart';
import 'package:urban_escape/classes/Puzzle.dart';

import '../main.dart';
import '../theme/theme_constants.dart';

class PuzzleScreen extends StatefulWidget {
  PuzzleScreen(this.puzzle, {Key? key}) : super(key: key);

  late final Puzzle puzzle;

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState(puzzle);
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  _PuzzleScreenState(this.puzzle);

  late final Puzzle puzzle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          );
        }),
        title: Text("Start"),
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
      body: Container(
          color: Colors.white,
          width: double.maxFinite,
          child: Column(children: [
            FittedBox(
              child: Image.asset(puzzle.poster_image_url),
              fit: BoxFit.fill,
            ),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    "LOCATION 1/7",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ))
          ])),
      bottomNavigationBar: BottomAppBar(
        color: COLOR_PRIMARY,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.timer), color: Colors.white, onPressed: () {}),
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
          label: Text('Hint'),
          onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
