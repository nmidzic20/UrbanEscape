import 'package:flutter/material.dart';
import 'package:urban_escape/screens/ARScreen.dart';
import 'package:urban_escape/screens/Home.dart';
import 'package:urban_escape/screens/ShopScreen.dart';
import 'package:urban_escape/shared.dart';
import 'package:urban_escape/theme/theme_constants.dart';
import 'package:urban_escape/theme/theme_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:urban_escape/components/MyAppBar.dart';
import 'package:urban_escape/components/NavDrawer.dart';
import 'firebase_options.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';

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
  //WidgetsFlutterBinding.ensureInitialized();

  //Assign publishable key to flutter_stripe
  Stripe.publishableKey =
      "pk_test_51N6u89LsL63viszIF3Ef24meARmKNqReKgeqgWIeLzakqbn92vWvWNFF9MAmh64tpVZJD7cpLW1JqblhYSijMKUY000qq4prRZ";

  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");

  prefs = await SharedPreferences.getInstance();
  setBoolToSharedPrefs("isLoggedIn", false);
  //signOut(); fix


  final List<CameraDescription> _cameras = await availableCameras();
  firstCamera = _cameras.first;

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
      home: const HomeScreen(),
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
    const HomeContent(),
    const ShopContent(),
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
        appBar: const MyAppBar("Home", false),
        drawer: const NavDrawer(),
        body: Container(
            decoration: const BoxDecoration(gradient: LINEAR_GRADIENT),
            child: pages.elementAt(selectedIndex)),
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
          selectedItemColor: Colors.pinkAccent,
          onTap: _onItemTapped,
        ));
  }
}


