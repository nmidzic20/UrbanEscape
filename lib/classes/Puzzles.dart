import '../widgets/Alert.dart';
import './Puzzle.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}

List<Puzzle> puzzles = [
  Puzzle(
    1,
      "Solar System Voyage",
      "assets/images/solar-system-voyage-poster.jpg",
      "Zagreb",
      "Croatia",
      "45 min",
      "9.7",
      0,
      "Visit the outer space in Zagreb! Make stops across our Solar System and come back home at the end of your journey.",
      "Opatička ul. 22, 10000 Zagreb",
      [
        Prompt(
            1,
            TemplateScreen.FIRST,
            "assets/images/SSV_q1.jpg",
            "LOCATION 1/7",
            false,
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text:
                          'You are a space traveller and you’re trying to make your way back home. Your initial location is... the stars!\n\n',
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: 'Zvjezdarnica Zagreb',
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _launchInBrowser(
                            Uri.parse("https://zvjezdarnica.hr/"))),
                  TextSpan(
                      text: ' is your starting point.',
                      style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
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
                Text(
                    "There are 2 stars in front of you. They both have the same, strange shape. What is the shape of the 2 stars?", style: TextStyle(color: Colors.black),),
                "1",
                [
                  Icon(Icons.star_border, color: Colors.black),
                  Icon(Icons.close, color: Colors.black),
                  Icon(Icons.favorite_border, color: Colors.black)
                ],
                "Look at the walls a bit more carefully...",
                1, (selectedAnswer, correctAnswer, context) {
              String msg = "";
              if (selectedAnswer == correctAnswer)
                msg = "Correct!";
              else
                msg = "Incorrect :( Try again!";
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Alert("", msg, [
                      ElevatedButton(
                        child: Text("OK",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ]);
                  });
              return selectedAnswer == correctAnswer;
            }),
            false),
        Prompt(
            3,
            TemplateScreen.SECOND,
            "assets/images/",
            "DID YOU KNOW?",
            false,
            Text(
                "The Observatory was founded by the Croatian Society for Natural Sciences. The premises in Popov Toranj were provided by the city government, which gave the funds for the reconstruction and the installation of an astronomic dome and a telescope. The grand opening took place on December 5, 1903. The first manager of the Observatory was Oton Kučera, a major promoter of science in Croatia.", style: TextStyle(color: Colors.black),),
            null,
            true),
      ],
      10),
  Puzzle(2,"Search for Ivana Brlić-Mažuranić", "assets/images/ivana-brlic.png",
      "Ogulin", "Croatia", "60 min", "9.3", 70, "TODO", "Trg Hrvatskih rodoljuba,  47300 Ogulin", List.empty(), 0),
  Puzzle(3,"True Witch of Grič", "assets/images/gricki-top.png", "Zagreb", "Croatia",
      "90 min", "8.9", 70, "TODO", "TODO", List.empty(), 0),
  Puzzle(4,"Nikola Tesla’s Secret Invention", "assets/images/tesla.jpg", "Varaždin",
      "Croatia", "75 min", "9.5", 70, "TODO", "TODO", List.empty(), 0),
];
