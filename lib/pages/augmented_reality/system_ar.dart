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
    _loadGLTF();
  }

  void _loadGLTF() {
    final node = ArCoreReferenceNode(
        objectUrl:
            'https://augmentedanatomystorage.blob.core.windows.net/models/pulmones/scene.gltf',
        name: 'hola');

    _arCoreController.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(onArCoreViewCreated: _onArCoreViewCreated),
    );
  }
}
