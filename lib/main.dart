import 'package:flutter/material.dart';
import 'package:urban_escape/classes/PuzzleCard.dart';
import 'package:urban_escape/classes/Puzzles.dart';
import 'package:urban_escape/shared.dart';
import 'package:urban_escape/theme/theme_constants.dart';
import 'package:urban_escape/theme/theme_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:urban_escape/widgets/MyAppBar.dart';
import 'package:urban_escape/widgets/NavDrawer.dart';
import 'auth_gate.dart';
import 'firebase_options.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';

const clientId =
    '708215483312-dk8kfdeqc4iku979eid6mle2eoohau7j.apps.googleusercontent.com';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterFireUIAuth.configureProviders([
    const EmailProviderConfiguration(),
    const GoogleProviderConfiguration(clientId: clientId),
  ]);

  //Initialize Flutter Binding
  WidgetsFlutterBinding.ensureInitialized();

  //Assign publishable key to flutter_stripe
  Stripe.publishableKey =
      "pk_test_51N6u89LsL63viszIF3Ef24meARmKNqReKgeqgWIeLzakqbn92vWvWNFF9MAmh64tpVZJD7cpLW1JqblhYSijMKUY000qq4prRZ";

  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");

  prefs = await SharedPreferences.getInstance();
  setBoolToSharedPrefs("isLoggedIn", false);
  //signOut(); fix

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    themeManager.addListener(themeListener);
    super.initState();
  }

  void themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urban Escape',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar("Home", false),
        drawer: NavDrawer(),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Available stories in ZAGREB",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: COLOR_TEXT),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: ListView.builder(
                    itemCount: puzzles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new PuzzleCard(index));
                    }),
              ),
            ),
          ],
        ));
  }
}



