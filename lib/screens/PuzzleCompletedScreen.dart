import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:urban_escape/classes/Puzzle.dart';
import 'package:urban_escape/theme/theme_constants.dart';

import '../classes/Prompt.dart';
import '../components/NavDrawer.dart';
import '../main.dart';
import 'LeaderboardScreen.dart';

class PuzzleCompletedScreen extends StatelessWidget {
  PuzzleCompletedScreen(this.puzzle, {Key? key}) : super(key: key) {
    currentPrompt = puzzle.prompts[puzzle.currentPrompt - 1];
  }

  Puzzle puzzle;
  late Prompt currentPrompt;

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
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      drawer: const NavDrawer(),
      body: Container(
        color: Colors.white,
        width: double.maxFinite,
        child: Column(children: [
          const SizedBox(height: 30),
          const Text("STORY COMPLETED!",
              style: TextStyle(
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 3.0,
                      color: Colors.pink,
                    ),
                  ],
                  color: Colors.pinkAccent,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const ImageIcon(
                          AssetImage("assets/icons/ic_distance.png"),
                          color: COLOR_PRIMARY_VARIANT,
                          size: 50,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Distance\n',
                                  style: TextStyle(
                                    color: COLOR_PRIMARY_VARIANT,
                                  )),
                              TextSpan(
                                text: '2,1 km',
                                style: TextStyle(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
                const Divider(
                    indent: 60, endIndent: 60, color: COLOR_PRIMARY_VARIANT),
                ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const ImageIcon(
                          AssetImage("assets/icons/ic_explored_time.png"),
                          color: COLOR_PRIMARY_VARIANT,
                          size: 50,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: 'Explored time\n',
                                  style: TextStyle(
                                    color: COLOR_PRIMARY_VARIANT,
                                  )),
                              TextSpan(
                                text: '${puzzle.exploredTime}',
                                style: const TextStyle(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
                const Divider(
                    indent: 60, endIndent: 60, color: COLOR_PRIMARY_VARIANT),
                ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const ImageIcon(
                          AssetImage("assets/icons/ic_total_time.png"),
                          color: COLOR_PRIMARY_VARIANT,
                          size: 50,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: 'Total time\n',
                                  style: TextStyle(
                                    color: COLOR_PRIMARY_VARIANT,
                                  )),
                              TextSpan(
                                text: '${puzzle.exploredTime}',
                                style: const TextStyle(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
                const Divider(
                    indent: 60, endIndent: 60, color: COLOR_PRIMARY_VARIANT),
                ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const ImageIcon(
                          AssetImage("assets/icons/ic_score.png"),
                          color: COLOR_PRIMARY_VARIANT,
                          size: 50,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: 'Score\n',
                                  style: TextStyle(
                                    color: COLOR_PRIMARY_VARIANT,
                                  )),
                              TextSpan(
                                text: puzzle.scoreCounter.score.toString(),
                                style: const TextStyle(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
                const Divider(
                    indent: 60, endIndent: 60, color: COLOR_PRIMARY_VARIANT),
                const SizedBox(
                  height: 50,
                ),
                RawMaterialButton(
                  padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(maxWidth: 200),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Leaderboard(),
                      ),
                    );
                  },
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
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
