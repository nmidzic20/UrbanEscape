import 'package:flutter/material.dart';

import '../widgets/MyAppBar.dart';
import '../widgets/NavDrawer.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar("Shop for gems", false),
    drawer: NavDrawer(),
    body: ShopContent(),);
  }
}

class ShopContent extends StatelessWidget {
  const ShopContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("SHOP");
  }
}

