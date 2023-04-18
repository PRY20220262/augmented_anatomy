import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';

class SystemAR extends StatefulWidget {
  const SystemAR({super.key});

  @override
  State<SystemAR> createState() => _SystemARState();
}

class _SystemARState extends State<SystemAR> {
  late ArCoreController _arCoreController;

  @override
  void dispose() {
    super.dispose();
    _arCoreController.dispose();
  }

  void _onArCoreViewCreated(ArCoreController arCoreController) {
    _arCoreController = arCoreController;
    _addModel();
  }

  void _addModel() {
    final node = ArCoreReferenceNode(
        objectUrl:
            'https://github.com/PRY20220103/AR-Assets/raw/main/Tierra%20con%20Atmosfera/earth_with_mountains_and_atmosphere.glb',
        name: 'hola');

    _arCoreController.addArCoreNodeWithAnchor(node);
  }

  // Future _addModel(ArCoreHitTestResult hit) async {
  //   final node = ArCoreReferenceNode(
  //       objectUrl:
  //           'https://github.com/PRY20220103/AR-Assets/raw/main/Tierra%20con%20Atmosfera/earth_with_mountains_and_atmosphere.glb',
  //       name: 'hola');

  //   _arCoreController.addArCoreNodeWithAnchor(node);
  // }

  // void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
  //   final hit = hits.first;
  //   print(
  //       '--------${hit.pose.rotation}------${hit.pose.translation}-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
  //   _addModel(hit);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true,
        enableUpdateListener: true,
        debug: true,
      ),
    );
  }
}
