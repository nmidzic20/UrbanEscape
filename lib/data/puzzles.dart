import '../components/Alert.dart';
import '../components/AnswerTextField.dart';
import '../classes/Puzzle.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

import '../classes/Challenge.dart';
import '../classes/Prompt.dart';

Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}

handleAnswer(selectedAnswer, correctAnswer, context) {

  print("Selected answer: " + selectedAnswer + " Correct answer: " + correctAnswer);
  String msg = "";
  if (selectedAnswer == correctAnswer) {
    msg = "Correct!";
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text(msg),
    ));
  } else {
    msg = "Incorrect :( Try again!";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Alert("", msg, [
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            )
          ]);
        });
  }

  return selectedAnswer == correctAnswer;
}

List<Puzzle> allPuzzles = [
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
            "assets/images/ssv1.jpg",
            "LOCATION 1/5",
            false,
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text:
                          'You are a space traveller and you’re trying to make your way back home. Your initial location is... the stars!\n\n',
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: 'Zvjezdarnica Zagreb',
                      style: const TextStyle(
                        color: Colors.pinkAccent,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _launchInBrowser(
                            Uri.parse("https://zvjezdarnica.hr/"))),
                  const TextSpan(
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
                const Text(
                  "There are 2 stars in front of you. They both have the same, strange shape. What is the shape of the 2 stars?",
                  style: TextStyle(color: Colors.black),
                ),
                "1",
                true,
                [
                  const Icon(Icons.star_border, color: Colors.black),
                  const Icon(Icons.close, color: Colors.black),
                  const Icon(Icons.favorite_border, color: Colors.black)
                ],
                "Look at the walls a bit more carefully...",
                1,
                handleAnswer),
            false),
        Prompt(
            3,
            TemplateScreen.SECOND,
            "assets/images/observatory.png",
            "DID YOU KNOW?",
            false,
            const Text(
              "The Observatory was founded by the Croatian Society for Natural Sciences. The premises in Popov Toranj were provided by the city government, which gave the funds for the reconstruction and the installation of an astronomic dome and a telescope. The grand opening took place on December 5, 1903. The first manager of the Observatory was Oton Kučera, a major promoter of science in Croatia.",
              style: TextStyle(color: Colors.black),
            ),
            null,
            true),
        Prompt(
            4,
            TemplateScreen.FIRST,
            "assets/images/ssv3.jpg",
            "LOCATION 2/5",
            false,
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                      text:
                          'Your next location is a planet named after the Roman god of war. The best way to find it is to locate the ',
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: '“Bloody Bridge”',
                      style: const TextStyle(
                        color: Colors.pinkAccent,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _launchInBrowser(Uri.parse(
                            "https://croatia2go.com/bloody-bridge-the-street-in-zagreb/"))),
                  const TextSpan(
                      text: ' first.', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            null,
            false),
        Prompt(
            5,
            TemplateScreen.FIRST,
            "assets/images/ssv4.jpg",
            "QUESTION 2",
            true,
            null,
            Challenge(
                1,
                const Text(
                  "What is the Diameter of this planet?",
                  style: TextStyle(color: Colors.black),
                ),
                "6.786",
                false,
                [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                    Expanded(
                      child: SizedBox(
                          height: 20,
                          width: 300,
                          child: AnswerTextField("6.786")),
                    ),
                    Expanded(
                      child: Text(
                        "km",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]),
                ],
                "A small plaque for a small planet... look for it and it shall tell you all you need to know.",
                1,
                handleAnswer),
            false),
        Prompt(
            6,
            TemplateScreen.SECOND,
            "assets/images/ssv5.jpg",
            "DID YOU KNOW?",
            false,
            const Text(
              "At the turn of the 20th century, prostitution was legal. In Zagreb it was advertised as a tourist attraction and contributed to the city's economy. Tkalčićeva Street was the main centre for brothels. At one stage every other building was a bordello. To open a brothel, the owner had to register at the town hall and received a licence. The licence required the brothel to be well run and provide a quality service. The women working in the brothels had to have a twice weekly medical examination. Brothels were not allowed to advertise their presence, but a discrete, uncommonly coloured lantern was allowed to be placed outside.",
              style: TextStyle(color: Colors.black),
            ),
            null,
            true),
        Prompt(
            7,
            TemplateScreen.FIRST,
            "assets/images/ssv6.jpg",
            "LOCATION 3/5",
            false,
            RichText(
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text:
                          'After visiting Mars, you decide your next location would be the namesake of the Roman Goddess of love. You heard that there is a ',
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                    text: 'market',
                    style: TextStyle(
                      color: Colors.pinkAccent,
                    ),
                  ),
                  TextSpan(
                      text: ' there! And something... about a ',
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                    text: 'column?',
                    style: TextStyle(
                      color: Colors.pinkAccent,
                    ),
                  ),
                ],
              ),
            ),
            null,
            false),
        Prompt(
            8,
            TemplateScreen.FIRST,
            "assets/images/ssv7.jpg",
            "QUESTION 3",
            true,
            null,
            Challenge(
                1,
                const Text(
                  "What is the Diameter of this planet?",
                  style: TextStyle(color: Colors.black),
                ),
                "12.103",
                false,
                [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                    Expanded(
                      child: SizedBox(
                          height: 20,
                          width: 300,
                          child: AnswerTextField("12.103")),
                    ),
                    Expanded(
                      child: Text(
                        "km",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]),
                ],
                "There are several columns around, look carefully...",
                1,
                handleAnswer),
            false),
        Prompt(
            9,
            TemplateScreen.SECOND,
            "assets/images/ssv8.JPG",
            "DID YOU KNOW?",
            false,
            const Text(
              "Dolac, the daily market, on a raised square a set of stairs up from Jelačić, has been the city’s major trading place since 1930. Farmers from surrounding villages come to sell their home-made foodstuffs and very fresh fruit and vegetables. In the covered market downstairs are butchers, fishmongers and old ladies selling the local speciality sir i vrhnje (cheese and cream). Flowers and lace are also widely available. Alongside, the renovated fish market, ribarnica, sells fresh produce every day but Monday.",
              style: TextStyle(color: Colors.black),
            ),
            null,
            true),
        Prompt(
            10,
            TemplateScreen.FIRST,
            "assets/images/ssv9.png",
            "LOCATION 4/5",
            false,
            RichText(
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text:
                          'Don’t fly too close to the next location, because it is very ',
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                    text: 'hot!',
                    style: TextStyle(
                      color: Colors.pinkAccent,
                    ),
                  ),
                  TextSpan(
                      text:
                          ' The locals don’t mind the temperatures because they are ',
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                    text: 'enjoying drinks.',
                    style: TextStyle(
                      color: Colors.pinkAccent,
                    ),
                  ),
                ],
              ),
            ),
            null,
            false),
        Prompt(
            11,
            TemplateScreen.FIRST,
            "assets/images/ssv10.png",
            "QUESTION 4",
            true,
            null,
            Challenge(
                1,
                const Text(
                  "What is the original color of this celestial body?",
                  style: TextStyle(color: Colors.black),
                ),
                "1",
                true,
                [
                  const Text(
                    "BROWN",
                    style: TextStyle(color: Colors.brown),
                  ),
                  const Text(
                    "GOLD",
                    style: TextStyle(color: Colors.yellow),
                  ),
                  const Text(
                    "ORANGE",
                    style: TextStyle(color: Colors.orange),
                  ),
                ],
                "At least, this is the one celestial body you can't miss :)",
                1,
                handleAnswer),
            false),
        Prompt(
            12,
            TemplateScreen.SECOND,
            "assets/images/ssv11.png",
            "DID YOU KNOW?",
            false,
            const Text(
              "Nine Views (Croatian: Devet pogleda) is an ambiental installation which, together with the sculpture Prizemljeno Sunce (The Grounded Sun), comprises a scale model of the Solar System. Prizemljeno Sunce by Ivan Kožarić was first displayed in 1971 by the building of the Croatian National Theatre, and since then changed location a few times. Since 1994, it has been situated in Bogovićeva Street. It is a bronze sphere around 2 metres in diameter. In 2004, artist Davor Preis had a two-week exhibition in the Josip Račić Exhibition Hall in Margaretska Street in Zagreb, and afterwards, he placed 9 models of the planets of the Solar System around Zagreb, to complete a model of the entire solar system. The models' sizes as well as their distances from the Prizemljeno Sunce are all in the same scale as the Prizemljeno Sunce itself.",
              style: TextStyle(color: Colors.black),
            ),
            null,
            true),
        Prompt(
            13,
            TemplateScreen.FIRST,
            "assets/images/ssv12.jpg",
            "LOCATION 5/5",
            false,
            RichText(
              text: const TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text:
                          'It’s been a nice journey. Now it’s time to go home. You should probably go to an ',
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                    text: 'ATM',
                    style: TextStyle(
                      color: Colors.pinkAccent,
                    ),
                  ),
                  TextSpan(
                      text:
                          ' so you can have enough money for the spaceship ride. ',
                      style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            null,
            false),
        Prompt(
            14,
            TemplateScreen.FIRST,
            "assets/images/ssv13.jpg",
            "QUESTION 5",
            true,
            null,
            Challenge(
                1,
                const Text(
                  "What is the Diameter of home?",
                  style: TextStyle(color: Colors.black),
                ),
                "12.756",
                false,
                [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                    Expanded(
                      child: SizedBox(
                          height: 20,
                          width: 300,
                          child: AnswerTextField("12.756")),
                    ),
                    Expanded(
                      child: Text(
                        "km",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]),
                ],
                "Almost there...",
                1,
                handleAnswer),
            false),
        Prompt(
            15,
            TemplateScreen.SECOND,
            "assets/images/ssv14.jpg",
            "DID YOU KNOW?",
            false,
            const Text(
              "Ivan Kožarić (10 June 1921, Petrinja – 15 November 2020, Zagreb) was a Croatian artist who worked primarily with sculpture but also in a wide variety of media, including: permanent and temporary sculptures, assemblages, proclamations, photographs, paintings, and installations. He lived and worked in Zagreb, Croatia. His works are characterized by a sense of mischief, spontaneity and by his nonchalant approach to life. He was one of the founding members of the Gorgona Group, whose active members between 1959 and 1966 were Miljenko Horvat, Julije Knifer, Marijan Jevšovar, Dimitrije Bašičević (who also works under the name Mangelos), Matko Meštrović, Radoslav Putar, Đuro Seder and Josip Vaništa. During his period in Gorgona, his sculptures reduced in form, which would become the main characteristic of his later sculptural project consisting of numerous sculptures entitled the Feeling of Wholeness.",
              style: TextStyle(color: Colors.black),
            ),
            null,
            true),
      ],
      15),
  Puzzle(
      2,
      "Search for Ivana Brlić-Mažuranić",
      "assets/images/ivana-brlic.png",
      "Ogulin",
      "Croatia",
      "60 min",
      "9.3",
      70,
      "TODO",
      "Trg Hrvatskih rodoljuba,  47300 Ogulin",
      List.empty(),
      0),
  Puzzle(3, "True Witch of Grič", "assets/images/gricki-top.png", "Zagreb",
      "Croatia", "90 min", "8.9", 70, "TODO", "TODO", List.empty(), 0),
  Puzzle(
      4,
      "Nikola Tesla’s Secret Invention",
      "assets/images/tesla.jpg",
      "Varaždin",
      "Croatia",
      "75 min",
      "9.5",
      70,
      "TODO",
      "TODO",
      List.empty(),
      0),
];
