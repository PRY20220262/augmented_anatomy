import 'dart:math';

import 'package:augmented_anatomy/models/model.dart';
import 'package:augmented_anatomy/services/human_anatomy_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/button.dart';
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
import 'package:flutter/src/material/colors.dart' as MaterialColors;

class ArHumanAnatomy extends StatefulWidget {
  final int id;
  final String name;
  const ArHumanAnatomy({super.key, required this.id, required this.name});

  @override
  State<ArHumanAnatomy> createState() => _ArHumanAnatomyState();
}

class _ArHumanAnatomyState extends State<ArHumanAnatomy> {

  int countRotation = 0;
  double radiansRotation = 90;
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;
  List<ARNode> nodes = [];
  List<ARNode> auxNodes = [];
  List<ModelAR>? modelARList;
  HumanAnatomyService humanAnatomyService = HumanAnatomyService();

  @override
  void dispose() {
    arSessionManager.dispose();
    super.dispose();
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
      handleRotation: false,
      handlePans: false,
      // handleTaps: true,
    );
    this.arObjectManager.onInitialize();
    try {
      modelARList = await humanAnatomyService.getModelAr(widget.id);
      for (var i = 0; i < modelARList!.length; i++) {
        var node = ARNode(
          name: "${modelARList?[i].name}",
          type: NodeType.webGLB,
          uri: "${modelARList?[i].url}",
          scale: Vector3(modelARList![i].xScale, modelARList![i].yScale,
              modelARList![i].zScale),
          position: Vector3(modelARList![i].xPosition,
              modelARList![i].yPosition, modelARList![i].zPosition),
        );
        nodes.add(node);
        bool? didAddWebNode = await this.arObjectManager.addNode(node);
      }
      this.arObjectManager.onNodeTap = _onTap;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _rotateNode() async {
      for (var i = 0; i < nodes.length; i++) {
        arObjectManager.removeNode(nodes[i]);
        nodes[i].rotation = Matrix3.rotationY(radiansRotation);
        nodes[i].position = rotateAroundY(nodes[i].position, -90);
        bool? didAddWebNode = await arObjectManager.addNode(nodes[i]);
      }
      radiansRotation += 90;
  }

  Vector3 rotateAroundY(Vector3 point, double angle) {
    double cosAngle = cos(angle);
    double sinAngle = sin(angle);

    double x = point.x * cosAngle + point.z * sinAngle;
    double y = point.y;
    double z = -point.x * sinAngle + point.z * cosAngle;

    return Vector3(x, y, z);
  }

  void _onTap(List<String> nodes) {
    String nodeName = nodes[0];
    String description =
        modelARList!.firstWhere((element) => element.name == nodeName).detail;
    showDialog<void>(
      context: context,
      barrierColor: MaterialColors.Colors.transparent,
      builder: (BuildContext context) => Align(
        alignment: Alignment.bottomRight,
        child: AlertDialog(
          insetPadding: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.50, left: 10, bottom: 100),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          alignment: Alignment.bottomLeft,
          content: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      nodeName,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(description,
                  style: Theme.of(context).textTheme.bodySmall)
                ],
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          ARView(
            onARViewCreated: _onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Positioned(
            top: 30,
            left: MediaQuery.of(context).size.width * 0.25,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  color: AAColors.backgroundWhiteView,
                  borderRadius: BorderRadius.circular(15)),
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(5),
              child: Text(
                widget.name,
                style: TextStyle(
                  color: AAColors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: MediaQuery.of(context).size.width * 0.35,
            child: MainActionButton(
                text: 'Finalizar RA',
                onPressed: () {
                  //navegar a cuestionarios
                  Navigator.of(context).pushNamed('/quiz-detail');
                }),
          ),
          Positioned(
              bottom: 30,
              left: 1,
              child: MainActionButton(text: 'Rotar',
                onPressed: _rotateNode,
              )
          )
        ]),
      ),
    );
  }
}