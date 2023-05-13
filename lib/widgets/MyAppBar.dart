import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:urban_escape/main.dart';

import '../shared.dart';
import '../theme/theme_manager.dart';

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
          icon: Icon(Icons.menu),
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
              if (!showHomeIcon && !getBoolValuesFromSharedPrefs("isLoggedIn"))
                return;
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
        /*IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search))*/
      ],
    );
  }
}

/*
class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = ['Zagreb', 'Osijek', 'Varaždin', 'Rijeka'];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      hintColor: (themeManager.themeMode == ThemeMode.dark) ? Colors.black : Colors.white,
      textTheme: Theme.of(context).textTheme.copyWith(
        titleLarge: TextStyle(color: (themeManager.themeMode == ThemeMode.dark) ? Colors.black : Colors.white),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return
      IconButton(
          onPressed: () {
            close(context, null);
          },
          icon: const Icon(Icons.arrow_back))
    ;
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var term in searchTerms)
      {
        if (term.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(term);
        }
      }
    return ListView.builder(itemCount: matchQuery.length, itemBuilder: (context, index) {
      var result = matchQuery[index];
      return ListTile(title: Text(result),);
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var term in searchTerms)
    {
      if (term.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(term);
      }
    }
    return ListView.builder(itemCount: matchQuery.length, itemBuilder: (context, index) {
      var result = matchQuery[index];
      return ListTile(title: Text(result),);
    });
  }
}*/
