import 'package:flutter/material.dart';
import 'package:urban_escape/main.dart';
import 'package:urban_escape/theme/theme_constants.dart';

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
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PuzzleScreenWelcome(id: puzzle.id),
              ));
        },
        child: Column(
          children: [
            Stack(children: <Widget>[
              Image.asset(
                puzzle.poster_image_url,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  child: Container(
                    width: 70,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 18,
                        ),
                        Text(puzzle.rating,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white))
                      ],
                    ),
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.all(Radius.elliptical(100, 50)),
                    ),
                  ),
                  alignment: Alignment.topRight,
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(puzzle.title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: (themeManager.themeMode == ThemeMode.dark)
                          ? Colors.white
                          : COLOR_PRIMARY_VARIANT)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_sharp,
                        color: Colors.pinkAccent,
                      ),
                      Text(puzzle.city + ", " + puzzle.country,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: (themeManager.themeMode == ThemeMode.dark)
                                  ? Colors.white
                                  : Colors.black)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(puzzle.price.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: (themeManager.themeMode == ThemeMode.dark)
                                  ? Colors.white
                                  : Colors.black)),
                      Image.asset(
                        "assets/images/coinv1.png",
                        width: 40,
                        height: 40,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}
