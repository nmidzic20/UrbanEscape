import './Puzzle.dart';
import 'package:flutter/material.dart';

List<Puzzle> puzzles = [
  Puzzle(
      "Solar System Voyage",
      "assets/images/solar-system-voyage-poster.jpg",
      "Zagreb",
      "Croatia",
      "45 min",
      "9.7",
      "8",
      "Visit the outer space in Zagreb! Make stops across our Solar System and come back home at the end of your journey.",
      "Opatička ul. 22, 10000 Zagreb",
      [
        Prompt(
            1,
            TemplateScreen.FIRST,
            "assets/images/SSV_q1.jpg",
            "LOCATION 1/7",
            false,
            "You are a space traveller and you’re trying to make your way back home. Your initial location is... the stars! \n\n Zvjezdarnica Zagreb is your starting point.",
            null,
            false),
        Prompt(
            2,
            TemplateScreen.FIRST,
            "assets/images/SSV_q1.jpg",
            "QUESTION 1",
            true,
            null,
            Challenge(
                1,
                "There are 2 stars in front of you. They both have the same, strange shape. What is the shape of the 2 stars?",
                "answer",
                [
                  Icon(Icons.star_border, color: Colors.black),
                  Icon(Icons.close, color: Colors.black),
                  Icon(Icons.favorite_border, color: Colors.black)
                ],
                "Look at the walls a bit more carefully...",
                1),
            false),
        Prompt(
            3,
            TemplateScreen.SECOND,
            "assets/images/",
            "DID YOU KNOW?",
            false,
            "The Observatory was founded by the Croatian Society for Natural Sciences. The premises in Popov Toranj were provided by the city government, which gave the funds for the reconstruction and the installation of an astronomic dome and a telescope. The grand opening took place on December 5, 1903. The first manager of the Observatory was Oton Kučera, a major promoter of science in Croatia.",
            null,
            true),
      ],
      10),
  Puzzle("Search for Ivana Brlić-Mažuranić", "assets/images/ivana-brlic.png", "TODO", "TODO", "TODO",
      "TODO", "TODO", "TODO", "TODO", List.empty(), 0),
  Puzzle("True Witch of Grič", "assets/images/gricki-top.png", "TODO", "TODO", "TODO",
      "TODO", "TODO", "TODO", "TODO", List.empty(), 0),
  Puzzle("Nikola Tesla’s Secret Invention", "assets/images/tesla.jpg", "TODO", "TODO", "TODO",
      "TODO", "TODO", "TODO", "TODO", List.empty(), 0),
];
