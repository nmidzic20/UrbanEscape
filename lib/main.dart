import 'package:flutter/material.dart';
import 'package:urban_escape/classes/PuzzleCard.dart';
import 'package:urban_escape/classes/Puzzles.dart';
import 'package:urban_escape/screens/ShopScreen.dart';
import 'package:urban_escape/shared.dart';
import 'package:urban_escape/theme/theme_constants.dart';
import 'package:urban_escape/theme/theme_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:urban_escape/widgets/MyAppBar.dart';
import 'package:urban_escape/widgets/NavDrawer.dart';
import 'classes/Puzzle.dart';
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

  List<Widget> pages = <Widget>[
    HomeContent(),
    ShopContent(),
  ];

  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Home", false),
      drawer: NavDrawer(),
      body: pages.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopify),
            label: 'Shop',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      )
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<Puzzle> allPuzzles = puzzles;
  List<Puzzle> foundPuzzles = [];

  @override
  initState() {
    foundPuzzles = allPuzzles;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Puzzle> results = [];
    if (enteredKeyword.isEmpty) {
      results = allPuzzles;
    } else {
      results = allPuzzles
          .where((puzzle) =>
      puzzle.city
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()) ||
          puzzle.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundPuzzles = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) => _runFilter(value),
            decoration: const InputDecoration(
                labelText: 'Search by city or puzzle',
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Available puzzles",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: COLOR_TEXT),
            ),
          ),
        ),
        Expanded(
          child: foundPuzzles.isNotEmpty
              ? ListView.builder(
              itemCount: foundPuzzles.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new PuzzleCard(foundPuzzles[index],
                        key: ValueKey(foundPuzzles[index].id)));
              })
              : const Text(
            'No results found',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }
}

