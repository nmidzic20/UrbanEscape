import 'package:flutter/material.dart';
import 'package:urban_escape/Story.dart';

import 'Stories.dart';

class StoryStartScreen extends StatelessWidget {
  StoryStartScreen({super.key, required this.storyIndex}) {
    this.story = stories[this.storyIndex];
  }

  final int storyIndex;
  late final Story story;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(story.title),
      ),
      body: Center(child: Column(children: [])),
    );
  }
}
