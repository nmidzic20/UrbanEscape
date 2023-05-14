import 'package:flutter/material.dart';

class Puzzle {
  late int id;
  late String title;
  late String poster_image_url;
  late String city;
  late String country;
  late String avg_time;
  late String rating;
  late int price;
  late String description;
  late String start_location;
  late List<Prompt> prompts;
  late int promptsTotal;
  int currentPrompt = 0;
  late int totalScore;

  bool started = false;
  bool purchased = false;

  Puzzle(
      this.id,
      this.title,
      this.poster_image_url,
      this.city,
      this.country,
      this.avg_time,
      this.rating,
      this.price,
      this.description,
      this.start_location,
      this.prompts,
      this.promptsTotal,
      {
        this.totalScore = 0,
      });
}

class Challenge {
  late int id;
  late Widget question;
  late String answer;
  late List<Widget> options;
  late String hint;
  late int points;
  late Function handleAnswer;
  late int answerAttempts;

  Challenge(
      this.id,
      this.question,
      this.answer,
      this.options,
      this.hint,
      this.points,
      this.handleAnswer,
      {
        this.answerAttempts = 0,
      });
}

enum TemplateScreen {
  FIRST,
  SECOND
}

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
