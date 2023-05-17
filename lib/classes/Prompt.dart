import 'package:flutter/material.dart';

import 'Challenge.dart';

class Prompt {
  late int id;
  late TemplateScreen templateScreen;
  late String image_path;
  late String title;
  late bool isChallenge;
  late Widget? content;
  late Challenge? challenge;
  late bool timerPaused;

  Prompt(
      this.id,
      this.templateScreen,
      this.image_path,
      this.title,
      this.isChallenge,
      this.content,
      this.challenge,
      this.timerPaused
      );
}

enum TemplateScreen {
  FIRST,
  SECOND
}
