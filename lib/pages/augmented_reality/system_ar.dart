import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';

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

  void _loadGLTF() async {
    final ByteData data = await rootBundle.load('assets/your_model.gltf');
    final String gltfPath = utf8.decode(data.buffer.asUint8List());

    final node = ArCoreReferenceNode(objectUrl: gltfPath, name: 'hola');

    _arCoreController.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(onArCoreViewCreated: _onArCoreViewCreated),
    );
  }
}
