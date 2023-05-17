import 'package:flutter/material.dart';
import 'package:urban_escape/classes/Puzzle.dart';
import 'package:urban_escape/main.dart';
import 'package:urban_escape/screens/ShopScreen.dart';
import 'package:urban_escape/theme/theme_constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import '../auth_gate.dart';
import '../data/player.dart';
import '../shared.dart';
import '../components/Alert.dart';
import '../components/NavDrawer.dart';
import '../data/puzzles.dart';
import 'PuzzlePromptScreen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PuzzleScreenWelcome extends StatefulWidget {
  PuzzleScreenWelcome({super.key, required this.id}) {
    puzzle = allPuzzles.where((p) => p.id == id).first;
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
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          );
        }),
        title: Text(puzzle.title),
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
                fit: BoxFit.fitWidth,
                child: Image.asset(
                  puzzle.poster_image_url,
                  height: 60,
                ).animate().fade().scale(),
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
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: false,
                            showChartValues: false,
                          ),
                          initialAngleInDegree: -180,
                          baseChartColor: Colors.grey,
                        ),
                        Column(
                          children: [
                            const Text("AVG. TIME",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pinkAccent)),
                            Text(puzzle.avg_time,
                                style: TextStyle(color: Colors.pinkAccent)),
                          ],
                        ),
                        CircularPercentIndicator(
                          radius: 20.0,
                          lineWidth: 8.0,
                          percent: 0.25,
                          center: const Text("1",
                              style: TextStyle(color: Colors.pinkAccent)),
                          progressColor: Colors.pink,
                        ),
                        const Text(
                          "LEVEL",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.pinkAccent),
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(5.0)),
                    Visibility(
                        visible: !puzzle.purchased,
                        child: RatingPrice(puzzle: puzzle))
                  ],
                ),
              ),
              (puzzle.purchased)
                  ? StartPuzzle(updateParentWidget, puzzle: puzzle)
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
      decoration: const BoxDecoration(gradient: LINEAR_GRADIENT),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: 250,
              child: Text(
                puzzle.description,
                style: const TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.blueAccent,
              ),
              Text(
                puzzle.start_location,
                style: const TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    fontSize: 16),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.all(10)),
          RawMaterialButton(
            padding: const EdgeInsets.all(10),
            constraints: const BoxConstraints(maxWidth: 200),
            onPressed: () {},
            elevation: 2.0,
            fillColor: Colors.blueAccent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
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
          ),
          const Padding(padding: EdgeInsets.all(10)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
            onPressed: () {
              if (!getBoolValuesFromSharedPrefs("isLoggedIn")) {
                showGuestDialog(context, widget.updateParentWidget, puzzle);
              } else {
                if (puzzle.price <= player.coinsAmount) {
                  setState(() {
                    player.coinsAmount = player.coinsAmount - puzzle.price;
                    widget.updateParentWidget();
                  });
                } else {
                  handleInsufficientFunds(context);
                }
              }
            },
            child: const Text("BOOK NOW",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          const Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }

  void handleInsufficientFunds(BuildContext context) {
    ElevatedButton goToShopButton = ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShopScreen(),
              ),
            ),
        child: const Text("Go to store"));

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

class StartPuzzle extends StatefulWidget {
  StartPuzzle(
    this.updateParentWidget, {
    super.key,
    required this.puzzle,
  });

  final Puzzle puzzle;
  Function updateParentWidget;

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
      decoration: const BoxDecoration(
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
            child: Text(buttonTitle,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          //SizedBox(height: 40,),
          Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                  width: MediaQuery.of(context)!.size.width / 2,
                  child: Image.asset('assets/images/maskota2.png',
                          fit: BoxFit.cover)
                      .animate()
                      .fade()
                      .scale()))
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
        const Text(
          "RATING",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent),
        ),
        RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.pinkAccent,
          padding: const EdgeInsets.all(10.0),
          shape: const OvalBorder(),
          child: Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.white,
              ),
              Text(puzzle.rating,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black))
            ],
          ),
        ),
      ]),
      Column(mainAxisSize: MainAxisSize.min, children: [
        const Text(
          "PRICE",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent),
        ),
        Row(
          children: [
            Text(puzzle.price.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black)),
            Image.asset(
              "assets/images/coinv1.png",
              width: 40,
              height: 40,
            ).animate().fade().scale()
          ],
        ),
      ])
    ]);
  }
}

void showGuestDialog(
    BuildContext context, Function updateParentWidget, Puzzle puzzle) {
  ElevatedButton registerButton = ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
      onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AuthGate(),
            ),
          ),
      child: const Text("Sign in"));

  allowPlayingFreePuzzlesAsGuest() {
    updateParentWidget();
  }

  ElevatedButton continueAsGuestButton = ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
      onPressed: () {
        if (puzzle.price == 0) {
          allowPlayingFreePuzzlesAsGuest();
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: const Text("Continue as a guest"));
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Alert(
          "Dear guest,",
          "To perform this action you need to sign in or register an account. We would love to have you on here!"
              "\nNote that you can still play free puzzles as a guest!",
          [registerButton, continueAsGuestButton]);
    },
  );
}
