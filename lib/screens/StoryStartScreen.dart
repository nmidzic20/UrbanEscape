import 'package:flutter/material.dart';
import 'package:urban_escape/classes/Puzzle.dart';
import 'package:urban_escape/main.dart';
import 'package:urban_escape/theme/theme_constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';

import '/classes/Puzzles.dart';

class StoryStartScreen extends StatelessWidget {
  StoryStartScreen({super.key, required this.puzzleIndex}) {
    this.puzzle =
        (this.puzzleIndex < 1) ? puzzles[this.puzzleIndex] : puzzles[1];
  }

  final int puzzleIndex;
  late final Puzzle puzzle;

  Map<String, double> dataMap = {
    "percentage": 1,
    "hour": 3,
  };

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
        width: double.maxFinite,
        child: Column(
          children: [
            FittedBox(
              child: Image.asset(puzzle.poster_image_url),
              fit: BoxFit.fill,
            ),
            Container(
              height: 100,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Text(
                    puzzle.title,
                    style: TextStyle(color: Colors.pink),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PieChart(
                        dataMap: dataMap,
                        chartRadius: MediaQuery.of(context).size.width / 6,
                        legendOptions: LegendOptions(showLegends: false),
                        chartValuesOptions: ChartValuesOptions(
                          showChartValueBackground: false,
                          showChartValues: false,
                        ),
                        initialAngleInDegree: -180,
                        baseChartColor: Colors.grey,
                      ),
                      Column(
                        children: [
                          Text("AVG. TIME"),
                          Text(puzzle.avg_time),
                        ],
                      ),
                      CircularPercentIndicator(
                        radius: 20.0,
                        lineWidth: 8.0,
                        percent: 0.25,
                        center: new Text("1"),
                        progressColor: Colors.pink,
                      ),
                      Text("LEVEL")
                    ],
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [COLOR_BACKGROUND, Colors.deepPurple],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    puzzle.description,
                    style: TextStyle(color: Colors.white),
                  ),
                  ElevatedButton(
                    child: Text("Start"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent),
                    onPressed: () {
                      print("Start puzzle");
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
