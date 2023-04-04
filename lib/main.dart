import 'package:flutter/material.dart';
import 'package:urban_escape/theme/theme_constants.dart';
import 'package:urban_escape/theme/theme_manager.dart';
import 'package:flutter/material.dart';

void main() {
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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
            padding: EdgeInsets.symmetric(horizontal: 16),
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
            Switch(
                value: false,
                onChanged: (newValue) {
                  //Navigator.pop(context); too fast, need to see the switch changed
                }),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
