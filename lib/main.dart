import 'package:flutter/material.dart';
import 'package:urban_escape/auth_gate.dart';
import 'package:urban_escape/PuzzleCard.dart';
import 'package:urban_escape/theme/theme_constants.dart';
import 'package:urban_escape/theme/theme_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'package:flutterfire_ui/auth.dart';

const clientId =
    '708215483312-dk8kfdeqc4iku979eid6mle2eoohau7j.apps.googleusercontent.com';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterFireUIAuth.configureProviders([
    const EmailProviderConfiguration(),
    const GoogleProviderConfiguration(clientId: clientId),
  ]);

  //runApp(const MyApp());
  runApp(MaterialApp(home: const AuthGate()));
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Necessary to put leading: Builder(...) { return IconButton(...)} instead of leading: IconButton(...)
          // in order to be able to call context for Scaffold.of (to open the drawer on clicking the icon)
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          }),
          title: Text('Home'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_themeManager.themeMode == ThemeMode.dark
                      ? "Dark mode"
                      : "Light mode"),
                  Switch(
                      value: _themeManager.themeMode == ThemeMode.dark,
                      onChanged: (newValue) {
                        _themeManager.toggleTheme(newValue);
                        setState(() {});
                      }),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            Icon(Icons.account_circle),
          ],
        ),
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
                    Text(_themeManager.themeMode == ThemeMode.dark
                        ? "Dark mode"
                        : "Light mode"),
                    Switch(
                        value: _themeManager.themeMode == ThemeMode.dark,
                        onChanged: (newValue) {
                          _themeManager.toggleTheme(newValue);
                          setState(() {});
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: new ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new PuzzleCard(index));
            })
    );
  }
}
