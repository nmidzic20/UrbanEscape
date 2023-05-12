import 'package:flutter/material.dart';
import 'package:urban_escape/classes/Puzzle.dart';
import 'package:urban_escape/main.dart';
import 'package:urban_escape/theme/theme_constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import '../auth_gate.dart';
import '../widgets/Alert.dart';
import '/classes/Puzzles.dart';
import 'BookingScreen.dart';
import 'PuzzleScreenPrompt.dart';

class PuzzleScreenWelcome extends StatefulWidget {
  PuzzleScreenWelcome({super.key, required this.puzzleIndex}) {
    this.puzzle = puzzles[this.puzzleIndex];
  }

  final int puzzleIndex;
  late final Puzzle puzzle;

  @override
  State<PuzzleScreenWelcome> createState() => _PuzzleScreenWelcomeState();
}

class _PuzzleScreenWelcomeState extends State<PuzzleScreenWelcome> {
  @override
  void initState() {
    super.initState();
  }

  final Map<String, double> dataMap = {
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
        title: Text(widget.puzzle.title),
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
        child: Container(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FittedBox(
                child: Image.asset(
                  widget.puzzle.poster_image_url,
                  height: 100,
                ),
                fit: BoxFit.fitWidth,
              ),
              Container(
                height: 180,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
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
                            Text("AVG. TIME",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pinkAccent)),
                            Text(widget.puzzle.avg_time),
                          ],
                        ),
                        CircularPercentIndicator(
                          radius: 20.0,
                          lineWidth: 8.0,
                          percent: 0.25,
                          center: new Text("1"),
                          progressColor: Colors.pink,
                        ),
                        Text(
                          "LEVEL",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.pinkAccent),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(5.0)),
                    Visibility(
                        visible: !widget.puzzle.purchased,
                        child: RatingPrice(puzzle: widget))
                  ],
                ),
              ),
              (widget.puzzle.purchased)
                  ? StartPuzzle(puzzle: widget.puzzle)
                  : PurchasePuzzle(puzzle: widget.puzzle)
            ],
          ),
        ),
      ),
    );
  }
}

class PurchasePuzzle extends StatelessWidget {
  const PurchasePuzzle({
    super.key,
    required this.puzzle,
  });

  final Puzzle puzzle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: COLOR_BACKGROUND,
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: 250,
              child: Text(
                puzzle.description,
                style: TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: Colors.blueAccent,
              ),
              Text(
                puzzle.start_location,
                style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    fontSize: 16),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(10)),
          RawMaterialButton(
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(maxWidth: 200),
            onPressed: () {},
            elevation: 2.0,
            fillColor: Colors.blueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bar_chart,
                  color: Colors.white,
                ),
                Text("Leaderboard",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white))
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          ElevatedButton(
            child: Text("BOOK NOW",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
            onPressed: () {
              ElevatedButton registerButton = ElevatedButton(
                  child: Text("Register"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthGate(),
                        ),
                      ));

              ElevatedButton continueAsGuestButton = ElevatedButton(
                child: Text("Continue as a guest"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent),
                onPressed: () => Navigator.of(context).pop(),
              );

              (!getBoolValuesFromSharedPrefs("isLoggedIn"))
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
                        builder: (context) => BookingScreen(puzzle),
                      ),
                    );
            },
          )
        ],
      ),
    );
  }
}

class StartPuzzle extends StatefulWidget {
  StartPuzzle({
    super.key,
    required this.puzzle,
  });

  final Puzzle puzzle;

  @override
  State<StartPuzzle> createState() => _StartPuzzleState(puzzle);
}

class _StartPuzzleState extends State<StartPuzzle> {
  late final String buttonTitle;
  late final Puzzle puzzle;

  _StartPuzzleState(this.puzzle);

  @override
  void initState() {
    super.initState();
    buttonTitle = puzzle.started ? "Continue" : "Start";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.deepPurple, COLOR_BACKGROUND],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: 250,
              child: Text(
                puzzle.description,
                style: TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          ElevatedButton(
            child: Text(buttonTitle,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
            onPressed: () {
              puzzle.started = true;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PuzzleScreen(puzzle),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class RatingPrice extends StatelessWidget {
  const RatingPrice({
    super.key,
    required this.puzzle,
  });

  final PuzzleScreenWelcome puzzle;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          "RATING",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent),
        ),
        RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.pinkAccent,
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.white,
              ),
              Text(puzzle.puzzle.rating,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
            ],
          ),
          padding: EdgeInsets.all(10.0),
          shape: OvalBorder(),
        ),
      ]),
      Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          "PRICE",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent),
        ),
        Text(
          puzzle.puzzle.price + "€",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ])
    ]);
  }
}
