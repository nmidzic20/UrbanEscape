import 'package:flutter/material.dart';

import '../auth_gate.dart';
import '../main.dart';
import '../shared.dart';
import '../theme/theme_manager.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  List<String> list = <String>['English', 'Croatian'];
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = list.first;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: (themeManager.themeMode == ThemeMode.dark)
                          ? Colors.white
                          : Colors.black),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  themeManager.themeMode == ThemeMode.dark
                      ? "Dark mode"
                      : "Light mode",
                  style: TextStyle(
                      color: (themeManager.themeMode == ThemeMode.dark)
                          ? Colors.white
                          : Colors.black),
                ),
                Switch(
                    value: themeManager.themeMode == ThemeMode.dark,
                    onChanged: (newValue) {
                      themeManager.toggleTheme(newValue);
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
                Text(
                  "Language",
                  style: TextStyle(
                      color: (themeManager.themeMode == ThemeMode.dark)
                          ? Colors.white
                          : Colors.black),
                ),
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
                      child: Text(value,
                          style: TextStyle(
                              color: (themeManager.themeMode == ThemeMode.dark)
                                  ? Colors.white
                                  : Colors.black)),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Center(
              child: (getBoolValuesFromSharedPrefs("isLoggedIn"))
                  ? ElevatedButton(
                      child: Text("Log out",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent),
                      onPressed: () {
                        setBoolToSharedPrefs("isLoggedIn", false);
                        //signOut(); //fix

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      },
                    )
                  : ElevatedButton(
                      child: Text("Sign in"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent),
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthGate(),
                            ),
                          )),
            ),
          ),
        ],
      ),
    );
  }
}
