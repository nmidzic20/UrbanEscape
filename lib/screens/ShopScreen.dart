import 'package:flutter/material.dart';
import 'package:urban_escape/main.dart';
import 'package:urban_escape/screens/PuzzleScreenWelcome.dart';
import 'package:urban_escape/theme/theme_constants.dart';

import '../widgets/MyAppBar.dart';
import '../widgets/NavDrawer.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Coins", true),
      drawer: NavDrawer(),
      body: ShopContent(),
    );
  }
}

class ShopContent extends StatelessWidget {
  ShopContent({Key? key}) : super(key: key);

  List<Map<String, dynamic>> coins = [
    {
      "id": 1,
      "amount": 300,
      "price": 7.99,
      "image_url": "assets/images/coinv1.png"
    },
    {
      "id": 2,
      "amount": 700,
      "price": 22.99,
      "image_url": "assets/images/coinv2.png"
    },
    {
      "id": 3,
      "amount": 1100,
      "price": 45.99,
      "image_url": "assets/images/coinv3.png"
    },
    {
      "id": 4,
      "amount": 2100,
      "price": 79.99,
      "image_url": "assets/images/coinv4.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 4),
        itemCount: coins.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20.0),

              child: Column(
                children: [
                  /*Expanded(
                      child: Container(
                          height: 200,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                              coins[index]["image_url"],
                            ),
                            fit: BoxFit.cover,
                          )))),*/
                  Image.asset(
                    coins[index]["image_url"],
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    coins[index]["amount"].toString() + " coins",
                    style: TextStyle(
                        color: Colors.pinkAccent, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                      child: Text(coins[index]["price"].toString() + "€"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent),
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          )),
                ],
              ));
        });
  }
}
