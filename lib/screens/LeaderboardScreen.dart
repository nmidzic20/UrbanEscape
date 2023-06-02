import 'package:flutter/material.dart';
import '../classes/Score.dart';
import '../classes/Puzzle.dart';

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

    scores.sort((a, b) => b.score.compareTo(a.score));
    Score winner = scores.removeAt(0); // remove the winner from the scores list

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Story Scoreboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack( // Stack is used to place the crown icon over the winner avatar
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/solar-system-voyage-poster.jpg', fit: BoxFit.cover), // replace 'assets/winner_background.png' with your image path
                Column(
                  children: [
                    CircleAvatar(child: Text(winner.name[0]), radius: 50), // Increase the avatar size for the winner
                    // Icon(Icons.crown, size: 50, color: Colors.gold), // Add a crown icon. Replace Icons.crown with your icon if you have a different one
                    Text(winner.name, style: const TextStyle(fontSize: 24, color: Colors.black)),
                    Text(winner.score.toString(), style: const TextStyle(fontSize: 20, color: Color(0xFFFC5285))),
                  ],
                ),
              ],
            ),
            Expanded( // Add Expanded so that the ListView takes the remaining space
              child: ListView.builder(
                itemCount: scores.length * 2, // double the itemCount to accommodate dividers
                itemBuilder: (context, index) {
                  if (index.isEven) { // if index is even, return the user tile
                    int userIndex = index ~/ 2; // integer division to get the correct user index
                    return ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min, // To make the row width as small as possible
                        children: [
                          Text('${userIndex + 2}', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)), // start numbering from 2
                          const SizedBox(width: 10),
                          CircleAvatar(child: Text(scores[userIndex].name[0])),
                        ],
                      ),
                      title: Text(scores[userIndex].name, style: const TextStyle(fontSize: 24, color: Colors.black)),
                      subtitle: Text(scores[userIndex].score.toString(), style: const TextStyle(fontSize: 20, color: Color(0xFFFC5285))),
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
