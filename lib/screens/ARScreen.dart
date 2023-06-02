import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;

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
        title: const Text('Examine the planets to find clues'),
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
      position: vector.Vector3(-0.5, 0.5, 3.5),
      rotation: vector.Vector4(0, 0, 0, 0),
    );

    final earthMaterial = ArCoreMaterial(
        color: Color.fromARGB(120, 66, 134, 244),
        textureBytes: await getImageBytes("images/earth.jpg"));

    final earthShape = ArCoreSphere(
      materials: [earthMaterial],
      radius: 0.4,
    );

    final earth = ArCoreNode(
      shape: earthShape,
      children: [moon],
      position: vector.Vector3(-0.5, 0.2, -0.7),
      rotation: vector.Vector4(0, 1, 0, 0),);

    arCoreController.addArCoreNode(
        earth); //moon is a child of earth and is added accordingly
    //_addImage();
    _addCube();

    final node = ArCoreReferenceNode(
      name: '3D Model',
      object3DFileName: 'UE.obj',
      scale: vector.Vector3(1.0, 1.0, 1.0),
      position: vector.Vector3(0.8, 0, -2.5),
    );

    arCoreController.addArCoreNode(node);
  }


Future<Uint8List> getImageBytes(String imageName) async {
    final ByteData data = await rootBundle.load('assets/$imageName');
    return data.buffer.asUint8List();
  }

  void _addImage() async {
    final imageBytes = await getImageBytes("images/icon.jpg");
    final node = ArCoreNode(
      image:ArCoreImage(bytes:imageBytes,width: 100, height: 100),
      position: vector.Vector3(0, 0, -1.5),
    );
    arCoreController.addArCoreNode(node);
  }

  void _addCube() async {
    final material = ArCoreMaterial(
      color: Colors.pinkAccent,
      textureBytes: await getImageBytes("images/icon.jpg")
    );
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );
    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(0.8, 0, -2.5),
    );
    arCoreController.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
