import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:urban_escape/main.dart';

import '../shared.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  const MyAppBar(this.title, this.showHomeIcon, {Key? key}) : super(key: key);

  final String title;
  final bool showHomeIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Necessary to put leading: Builder(...) { return IconButton(...)} instead of leading: IconButton(...)
      // in order to be able to call context for Scaffold.of (to open the drawer on clicking the icon)
      leading: Builder(builder: (context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        );
      }),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo_spin.gif",
            height: 50.0,
            width: 50.0,
          ),
          SizedBox(width: 15),
          Text(title),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              (showHomeIcon)
                  ? Icons.home_filled
                  : ((getBoolValuesFromSharedPrefs("isLoggedIn"))
                      ? Icons.account_circle
                      : null),
            ),
            onPressed: () {
              if (!showHomeIcon && !getBoolValuesFromSharedPrefs("isLoggedIn")) {
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      (showHomeIcon) ? HomeScreen() : ProfileScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
