import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/services.dart' show Uint8List, rootBundle;

class ARScreen extends StatefulWidget {
  @override
  _ARScreenState createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        }),
        title: const Text('Examine the planets to find the hidden clue'),
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) async {
    arCoreController = controller;

    final moonMaterial = ArCoreMaterial(color: Colors.grey);

    final moonShape = ArCoreSphere(
      materials: [moonMaterial],
      radius: 0.2,
    );

    final moon = ArCoreNode(
      shape: moonShape,
      position: vector.Vector3(-0.5, 0.5, -3.5),
      rotation: vector.Vector4(0, 0, 0, 0),
    );

    Uint8List bytes = (await rootBundle.load('assets/images/earth.jpg')).buffer.asUint8List();

    final earthMaterial = ArCoreMaterial(
        color: Color.fromARGB(120, 66, 134, 244), textureBytes: bytes);

    final earthShape = ArCoreSphere(
      materials: [earthMaterial],
      radius: 0.4,
    );

    final earth = ArCoreNode(
        shape: earthShape,
        children: [moon],
        position: vector.Vector3(0.5, 0.5, 0.5),
      rotation: vector.Vector4(0, 1, 0, 0),);

    arCoreController.addArCoreNode(moon);
    arCoreController.addArCoreNode(earth);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
