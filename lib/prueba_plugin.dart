import 'package:flutter/material.dart';

import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:vector_math/vector_math_64.dart';

class ArTest extends StatefulWidget {
  const ArTest({super.key});

  @override
  State<ArTest> createState() => _ArTestState();
}

class _ArTestState extends State<ArTest> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;

  @override
  void dispose() {
    arSessionManager.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) async {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;

    this.arSessionManager.onInitialize(
          showFeaturePoints: false,
          showPlanes: false,
          customPlaneTexturePath: "assets/imgs/triangle.png",
          showWorldOrigin: false,
          handleRotation: true,
          handlePans: true,
          // handleTaps: true,
        );
    this.arObjectManager.onInitialize();
    var newNode = ARNode(
        name: "testNode",
        type: NodeType.webGLB,
        uri:
            'https://github.com/Juanca0312/test-ar/blob/main/realistic_human_stomach.glb?raw=true',
        scale: Vector3(0.5, 0.5, 0.5),
        position: Vector3(0, -0.3, -0.8));

    bool? didAddWebNode = await this.arObjectManager.addNode(newNode);

    this.arObjectManager.onNodeTap = _onTap;
  }

  void _onTap(List<String> nodes) {
    print("Flutter: onNodeTap");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text('onNodeTap on ${nodes[0].toString()}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ARView(
        onARViewCreated: _onARViewCreated,
        planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
      ),
    );
  }
}
