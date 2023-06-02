import 'package:flutter/material.dart';

import '../classes/Puzzle.dart';
import '../classes/Score.dart';

class Leaderboard extends StatelessWidget {
  final Puzzle puzzle;

  const Leaderboard({Key? key, required this.puzzle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Score> scores = [
      Score('Ivana Horvat', 25431),
      Score('Zdravko Dren', 21843),
      Score('Marko Markić', 19752),
      Score('Barbara Barić', 18177),
      Score('Petra Petrić', 16894),
      Score('Fran Franić', 15929),
    ];
    List<String> images = [
      "assets/images/Faces/faceWinner.png",
      "assets/images/Faces/face1.png",
      "assets/images/Faces/face2.png",
      "assets/images/Faces/face3.png",
      "assets/images/Faces/face4.png",
      "assets/images/Faces/face4.png"
    ];

    scores.sort((a, b) => b.score.compareTo(a.score));
    Score winner = scores.removeAt(0); // remove the winner from the scores list
    String winnerPic = images.removeAt(0); // remove the winner photo from the images list

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Story Scoreboard',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              // Stack is used to place the crown icon over the winner avatar
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/solar-system-voyage-poster.jpg',
                    fit: BoxFit.cover),
                // replace 'assets/winner_background.png' with your image path
                Column(
                  children: [
                    CircleAvatar(
                        radius: 50,
                        child:
                            Image.asset(winnerPic)),
                    // Increase the avatar size for the winner
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      // Add some padding around the text
                      margin: const EdgeInsets.all(4.0),
                      // Add some margin around the box
                      child: Column(
                        children: [
                          Text(winner.name,
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.black)),
                          Text(winner.score.toString(),
                              style: const TextStyle(
                                  fontSize: 20, color: Color(0xFFFC5285))),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: scores.length * 2, // double the itemCount to accommodate dividers
                itemBuilder: (context, index) {
                  if (index.isEven) { // if index is even, return the user tile
                    int userIndex = index ~/ 2; // integer division to get the correct user index
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0), // Add vertical space between each row
                      child: ListTile(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min, // To make the row width as small as possible
                          children: [
                            Text('${userIndex}',
                                style: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 10),
                            CircleAvatar(radius: 50,child: Image.asset(images[userIndex]),),
                          ],
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(scores[userIndex].name,
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.black)),
                            Text(scores[userIndex].score.toString(),
                                style: const TextStyle(
                                    fontSize: 20, color: Color(0xFFFC5285))),
                          ],
                        ),
                      ),
                    );
                  } else { // if index is odd, return a divider
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 75), // Change the value as per your need
                      child: Divider(color: Colors.black),
                    );
                  }
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
