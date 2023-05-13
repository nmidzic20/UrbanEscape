import 'package:flutter/material.dart';
import 'package:urban_escape/classes/Puzzle.dart';
import 'package:urban_escape/main.dart';
import 'package:urban_escape/screens/ShopScreen.dart';
import 'package:urban_escape/theme/theme_constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import '../auth_gate.dart';
import '../shared.dart';
import '../widgets/Alert.dart';
import '../widgets/NavDrawer.dart';
import '/classes/Puzzles.dart';
import 'PurchasePuzzle.dart';
import 'PuzzleScreenPrompt.dart';

class PuzzleScreenWelcome extends StatefulWidget {
  PuzzleScreenWelcome({super.key, required this.id}) {
    this.puzzle = puzzles.where((p) => p.id == id).first;
  }

  final int id;
  late final Puzzle puzzle;

  @override
  State<PuzzleScreenWelcome> createState() => _PuzzleScreenWelcomeState(puzzle);
}

class _PuzzleScreenWelcomeState extends State<PuzzleScreenWelcome> {
  _PuzzleScreenWelcomeState(this.puzzle);

  final Puzzle puzzle;
  late Function updateParentWidget;

  @override
  void initState() {
    super.initState();
    updateParentWidget = () {
      setState(() {
        puzzle.purchased = true;
      });
    };
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
        title: Text(puzzle.title),
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
        child: Container(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FittedBox(
                child: Image.asset(
                  puzzle.poster_image_url,
                  height: 100,
                ),
                fit: BoxFit.fitWidth,
              ),
              Container(
                height: (puzzle.purchased) ? 100 : 180,
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
                        visible: !puzzle.purchased,
                        child: RatingPrice(puzzle: puzzle))
                  ],
                ),
              ),
              (puzzle.purchased)
                  ? StartPuzzle(puzzle: puzzle)
                  : BookNow(updateParentWidget, puzzle: puzzle)
            ],
          ),
        ),
      ),
    );
  }
}

class BookNow extends StatefulWidget {
  BookNow(
    this.updateParentWidget, {
    super.key,
    required this.puzzle,
  });

  final Puzzle puzzle;
  Function updateParentWidget;

  @override
  State<BookNow> createState() => _BookNowState(puzzle);
}

class _BookNowState extends State<BookNow> {
  _BookNowState(this.puzzle);

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
              if (!getBoolValuesFromSharedPrefs("isLoggedIn"))
                showGuestDialog(context);
              else {
                if (puzzle.price <= player.coinsAmount) {
                  setState(() {
                    player.coinsAmount = player.coinsAmount - puzzle.price;
                    widget.updateParentWidget();
                  });
                } else {
                  ElevatedButton goToShopButton = ElevatedButton(
                      child: Text("Go to store"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent),
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopScreen(),
                            ),
                          ));

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Alert(
                          "Insufficient funds :(",
                          "You don't have enough coins! Try purchasing some in the store",
                          [goToShopButton]);
                    },
                  );
                }
              }
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
              if (getBoolValuesFromSharedPrefs("isLoggedIn")) {
                puzzle.started = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PuzzleScreen(puzzle),
                  ),
                );
              } else
                showGuestDialog(context);
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

  final Puzzle puzzle;

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
              Text(puzzle.rating,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black))
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
          puzzle.price.toString() + "€",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ])
    ]);
  }
}

void showGuestDialog(BuildContext context) {
  ElevatedButton registerButton = ElevatedButton(
      child: Text("Sign in"),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
      onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AuthGate(),
            ),
          ));

  ElevatedButton continueAsGuestButton = ElevatedButton(
    child: Text("Continue as a guest"),
    style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
    onPressed: () => Navigator.of(context).pop(),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Alert(
          "Dear guest,",
          "To perform this action you need to sign in or register an account. We would love to have you on here!",
          [registerButton, continueAsGuestButton]);
    },
  );
}
