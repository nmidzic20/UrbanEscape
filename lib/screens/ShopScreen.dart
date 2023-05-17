import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:urban_escape/components/Alert.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import '../classes/Coin.dart';
import '../data/coins.dart';
import '../data/player.dart';
import '../shared.dart';
import '../theme/theme_constants.dart';
import '../theme/theme_manager.dart';
import '../components/MyAppBar.dart';
import '../components/NavDrawer.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar("Coins", true),
        drawer: const NavDrawer(),
        body: Container(
          decoration: const BoxDecoration(gradient: LINEAR_GRADIENT),
          child: ShopContent(),
        ));
  }
}

class ShopContent extends StatefulWidget {
  const ShopContent({Key? key}) : super(key: key);

  @override
  State<ShopContent> createState() => _ShopContentState();
}

class _ShopContentState extends State<ShopContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent),
                onPressed: () {},
                child: Row(
                  children: [
                    Text("Current amount: ${player.coinsAmount}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: (themeManager.themeMode == ThemeMode.dark)
                                ? Colors.white
                                : Colors.black)),
                    Image.asset(
                      "assets/images/coinv1.png",
                      width: 40,
                      height: 40,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200, childAspectRatio: 3 / 5),
              itemCount: coins.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Image.asset(
                          coins[index].image_url,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "${coins[index].amount} coins",
                          style: const TextStyle(
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pinkAccent),
                            onPressed: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Alert(
                                      "Purchase",
                                      "Purchase ${coins[index].amount} coins for ${coins[index].price} Euros",
                                      [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.pinkAccent),
                                          child: const Text('Make Payment'),
                                          onPressed: () async {
                                            await makePayment(
                                                coins[index], context);
                                          },
                                        ),
                                      ]);
                                }),
                            child: Text(coins[index].price.toString() + "€")),
                      ],
                    ));
              }),
        ),

      ],
    );
  }

  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(Coin coin, BuildContext context) async {
    try {
      paymentIntent = await createPaymentIntent(coin.price, 'EUR');

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Urban Escape'))
          .then((value) {});

      displayPaymentSheet(coin, context);
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet(Coin coin, BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        paymentIntent = null;

        setState(() {
          player.coinsAmount += coin.amount;
        });

        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Payment successful!",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ));
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(int amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(int amount) {
    // Multiplied by 100 so it maintains its value when it is converted to a double by flutter_stripe
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
