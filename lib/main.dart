import 'package:flutter/material.dart';
import 'package:urban_escape/classes/PuzzleCard.dart';
import 'package:urban_escape/classes/Puzzles.dart';
import 'package:urban_escape/theme/theme_constants.dart';
import 'package:urban_escape/theme/theme_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:urban_escape/widgets/MyAppBar.dart';
import 'firebase_options.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';

const clientId =
    '708215483312-dk8kfdeqc4iku979eid6mle2eoohau7j.apps.googleusercontent.com';

late SharedPreferences prefs;
bool themeChanged = false;
bool loggedInFirstTime = false;
bool firstPassAuthGate = true;

int loggedInCount = 0;
int currentPassAuthGate = 0;
int requiredPassesAuthGate = 2;

void setBoolToSharedPrefs(String key, bool value) {
  prefs.setBool(key, value);
}

bool getBoolValuesFromSharedPrefs(String key) {
  bool? boolValue = prefs.getBool(key);
  if (boolValue == null) boolValue = false;
  return boolValue;
}

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
  if (getBoolValuesFromSharedPrefs("isLoggedIn") != false)
  setBoolToSharedPrefs("isLoggedIn", false);

  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
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
      themeMode: _themeManager.themeMode,
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
  List<String> list = <String>['English', 'Croatian'];
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = list.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar("Home"),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Settings",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(_themeManager.themeMode == ThemeMode.dark
                        ? "Dark mode"
                        : "Light mode"),
                    Switch(
                        value: _themeManager.themeMode == ThemeMode.dark,
                        onChanged: (newValue) {
                          _themeManager.toggleTheme(newValue);
                          setState(() {});
                          if (loggedInFirstTime) themeChanged = true;
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Language"),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: getBoolValuesFromSharedPrefs("isLoggedIn"),
                child: Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Center(
                    child: ElevatedButton(
                      child: Text("Log out",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent),
                      onPressed: () {
                        setBoolToSharedPrefs("isLoggedIn", false);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
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
