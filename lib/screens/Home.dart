import 'package:flutter/material.dart';

import '../classes/Puzzle.dart';
import '../data/puzzles.dart';
import '../components/PuzzleCard.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<Puzzle> puzzles = allPuzzles;
  List<Puzzle> foundPuzzles = [];

  @override
  initState() {
    foundPuzzles = puzzles;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Puzzle> results = [];
    if (enteredKeyword.isEmpty) {
      results = puzzles;
    } else {
      results = puzzles
          .where((puzzle) =>
      puzzle.city
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()) ||
          puzzle.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundPuzzles = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) => _runFilter(value),
            decoration: const InputDecoration(
                labelText: 'Search by city or puzzle',
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: foundPuzzles.isNotEmpty
              ? ListView.builder(
              itemCount: foundPuzzles.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PuzzleCard(foundPuzzles[index],
                        key: ValueKey(foundPuzzles[index].id)));
              })
              : const Text(
            'No results found',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }
}