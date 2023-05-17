import 'package:flutter/material.dart';

import 'Prompt.dart';

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
      this.promptsTotal);
}





