import 'package:augmented_anatomy/models/model.dart';
import 'package:augmented_anatomy/services/human_anatomy_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
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

class ArTest extends StatefulWidget {
  const ArTest({super.key});

  @override
  State<ArTest> createState() => _ArTestState();
}

class _ArTestState extends State<ArTest> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;
  List<ModelAR>? modelARList;
  HumanAnatomyService humanAnatomyService = HumanAnatomyService();

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
          handleRotation: false,
          handlePans: false,
          // handleTaps: true,
        );
    this.arObjectManager.onInitialize();
    try {
      modelARList = await humanAnatomyService.getModelAr(3);
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
        bool? didAddWebNode = await this.arObjectManager.addNode(node);
      }
      this.arObjectManager.onNodeTap = _onTap;
    } catch (e) {
      print(e);
    }
    //this.arObjectManager.onNodeTap = _onTap;
  }

  void _onTap(List<String> nodes) {
    String nodeName = nodes[0];
    String description =
        modelARList!.firstWhere((element) => element.name == nodeName).detail;
    showDialog<void>(
      context: context,
      barrierColor: MaterialColors.Colors.transparent,
      builder: (BuildContext context) => AlertDialog(
        elevation: 0,
        content: Container(
          width: 200,
          height: 300,
          child: Column(
            children: [
              Text(
                nodeName,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
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
            // Colocamos el texto en la parte superior
            top: 30,
            left: MediaQuery.of(context).size.width * 0.25,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  color: AAColors.backgroundWhiteView,
                  borderRadius: BorderRadius.circular(15)),
              // Centramos el texto horizontalmente
              alignment: Alignment.topCenter,
              // Colocamos un espacio arriba del texto
              padding: const EdgeInsets.all(5),
              child: const Text(
                'Titulo',
                style: TextStyle(
                  color: AAColors.black,
                  fontSize: 20,
                ),
              ),
            ), // <- Termina el widget Container
          ), // <-
        ]),
      ),
    );
  }
}

void _showNodeDetails(
    String nodeName, String description, BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Theme(
        data: Theme.of(context).copyWith(
          // Define el estilo del fondo del AlertDialog
          dialogBackgroundColor: MaterialColors.Colors.transparent,
          // Define el estilo del contenido del AlertDialog
          cardTheme: const CardTheme(
            color: MaterialColors.Colors.red,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nodeName,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  description,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

/*import 'dart:async';

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
    _nodeStreamSubscription?.cancel();
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
      ARLocationManager arLocationManager,
      ) async {
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

    String uriAR = "";
    switch (name) {
      case 'Laringe':
        uriAR = "https://augmentedanatomystorage.blob.core.windows.net/models/larynx.glb";
        break;
      case 'Faringe':
        uriAR = "https://augmentedanatomystorage.blob.core.windows.net/models/pharynx_1k.glb";
        break;
      case 'Bronquios':
        uriAR = "https://augmentedanatomystorage.blob.core.windows.net/models/bronchi.glb";
        break;
      case 'Pulmon':
        uriAR = "https://augmentedanatomystorage.blob.core.windows.net/models/lungs (1).glb";
        break;
      case 'Sistema Respiratorio':
        uriAR = "https://augmentedanatomystorage.blob.core.windows.net/models/respiratory_system.glb";
        break;
      case 'Sistema Digestivo':
        uriAR = "https://github.com/Juanca0312/test-ar/blob/main/realistic_human_stomach.glb?raw=true";
        break;
      default:
        uriAR = "https://augmentedanatomystorage.blob.core.windows.net/models/bronchi.glb";
        break;
    }
    var node = ARNode(
      name: "node",
      type: NodeType.webGLB,
      uri: "https://augmentedanatomystorage.blob.core.windows.net/models/larynx.glb",
      scale: Vector3(0.5, 0.5, 0.5),
      position: Vector3(0, -0.3, -0.8),
    );
    var node1 = ARNode(
        name: "node1",
        type: NodeType.webGLB,
        uri:
            'https://github.com/Juanca0312/test-ar/blob/main/realistic_human_stomach.glb?raw=true',
        uri: "https://augmentedanatomystorage.blob.core.windows.net/models/Larynx/Cricoid_cartilage.glb",
        scale: Vector3(0.5, 0.5, 0.5),
        position: Vector3(0, -0.3, -0.8),
    var node1 = ARNode(
      name: "node1",
      type: NodeType.webGLB,
      uri:
          "https://augmentedanatomystorage.blob.core.windows.net/models/Larynx/Cricoid_cartilage.glb",
      scale: Vector3(0.3, 0.3, 0.3),
      position: Vector3(0, 2, 0),
    );
    var node2 = ARNode(
      name: "node2",
      type: NodeType.webGLB,
      uri: "https://augmentedanatomystorage.blob.core.windows.net/models/Larynx/Thyroid_cartilage.glb",
      scale: Vector3(0.5, 0.5, 0.5),
      position: Vector3(0, -0.3, -0.8),
    );
    var node3 = ARNode(
      name: "node3",
      type: NodeType.webGLB,
      uri: "https://augmentedanatomystorage.blob.core.windows.net/models/Larynx/Trachea.glb",
      scale: Vector3(0.5, 0.5, 0.5),
      position: Vector3(0, -0.3, -0.8),
    );

    //this.arObjectManager.addNode(node1);
    //this.arObjectManager.addNode(node2);
    //this.arObjectManager.addNode(node);
    bool? didAddWebNode = await this.arObjectManager.addNode(node);
    //this.arObjectManager.onNodeTap = _onTap;
      uri:
          "https://augmentedanatomystorage.blob.core.windows.net/models/Larynx/Trachea.glb",
      scale: Vector3(0.3, 0.3, 0.3),
      position: Vector3(0, 0, 0),
    );
    // var newNode = ARNode(
    //     name: "testNode",
    //     type: NodeType.webGLB,
    //     uri:
    //         'https://augmentedanatomystorage.blob.core.windows.net/models/Larynx/Trachea.glb',
    //     scale: Vector3(0.5, 0.5, 0.5),
    //     position: Vector3(0, -0.3, -0.8));

    bool? didAddWebNode = await this.arObjectManager.addNode(node1);
    bool? didAddWebNode2 = await this.arObjectManager.addNode(node2);
    bool? didAddWebNode3 = await this.arObjectManager.addNode(node3);

    this.arObjectManager.onNodeTap = _onTap;
>>>>>>> b729d17 (hu-12 prueba ar varios nodos)
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
    /*final Map<String, dynamic> args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    setState(() {
      name = args['name'];
    });*/
    return Scaffold(
      body: ARView(
        onARViewCreated: _onARViewCreated,
        planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
      ),
    );
  }
}
*/