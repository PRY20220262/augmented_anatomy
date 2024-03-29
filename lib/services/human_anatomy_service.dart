import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:augmented_anatomy/models/anatomy_reference.dart';
import 'package:augmented_anatomy/models/human_anatomy.dart';
import 'package:augmented_anatomy/models/model.dart';
import 'package:augmented_anatomy/models/organs.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:augmented_anatomy/utils/config.dart';
import 'package:augmented_anatomy/models/system_list.dart';

var humanAnatomyUrl = BACKEND_URL;

class HumanAnatomyService {
  final storage = const FlutterSecureStorage();

  Future<List<OrgansModel>> getOrgans(
      {String? systemName = null, String? order = null}) async {
    final token = await storage.read(key: 'token');
    final Map<String, dynamic> queryParams = {};
    if (systemName != null) {
      queryParams['systemName'] = systemName;
    }
    if (order != null) {
      queryParams['order'] = order;
    }
    final requestGetOrgans = Uri.parse('${humanAnatomyUrl}organs')
        .replace(queryParameters: queryParams);
    try {
      http.Response response = await http.get(
        requestGetOrgans,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token!,
        },
      ).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        List<dynamic> myData =
            json.decode(const Utf8Decoder().convert(response.bodyBytes));
        List<OrgansModel> organsList = [];
        for (int i = 0; i < myData.length; i++) {
          OrgansModel organsModel = OrgansModel.fromJson(myData[i]);
          organsList.add(organsModel);
        }
        return organsList;
      } else {
        final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return Future.error(errorResponse["message"]);
      }
    } on TimeoutException catch (_) {
      return Future.error('La solicitud ha excedido el tiempo de espera.');
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<HumanAnatomy> getById(id) async {
    final getByIdUrl = Uri.parse('${humanAnatomyUrl}human-anatomy/$id');
    final token = await storage.read(key: 'token');

    print('Haciendo llamada a servicio ${getByIdUrl.toString()}');

    try {
      http.Response response = await http.get(
        getByIdUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token!
        },
      );

      if (response.statusCode == 200) {
        print(utf8.decode(response.bodyBytes));
        return HumanAnatomy.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return Future.error(errorResponse["message"]);
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<List<SystemList>> findSystems() async {
    final getByIdUrl = Uri.parse('${humanAnatomyUrl}systems');
    List<SystemList> systems = [];
    final token = await storage.read(key: 'token');

    print('Haciendo llamada a servicio ${getByIdUrl.toString()}');

    try {
      http.Response response = await http.get(
        getByIdUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token!
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        for (var i = 0; i < data.length; i++) {
          systems.add(SystemList.fromJson(data[i]));
        }
        return systems;
      } else {
        final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return Future.error(errorResponse["message"]);
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<List<SystemList>> searchSystem(String name) async {
    final getByIdUrl = Uri.parse('${humanAnatomyUrl}systems?name=$name');
    List<SystemList> systems = [];
    final token = await storage.read(key: 'token');

    print('Haciendo llamada a servicio ${getByIdUrl.toString()}');

    try {
      http.Response response = await http.get(
        getByIdUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token!
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        for (var i = 0; i < data.length; i++) {
          systems.add(SystemList.fromJson(data[i]));
        }
        return systems;
      } else {
        final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return Future.error(errorResponse["message"]);
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<List<ModelAR>> getModelAr(id) async {
    final getModelAR = Uri.parse('${humanAnatomyUrl}human-anatomy/$id/models');
    final token = await storage.read(key: 'token');

    try {
      http.Response response = await http.get(
        getModelAR,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token!
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> myData =
            json.decode(const Utf8Decoder().convert(response.bodyBytes));
        List<ModelAR> modelsARList = [];
        for (int i = 0; i < myData.length; i++) {
          ModelAR modelAR = ModelAR.fromJson(myData[i]);
          print(modelAR);
          modelsARList.add(modelAR);
        }
        print("ESTE ES LA LISTA DE MODELOS");
        print(modelsARList);
        return modelsARList;
      } else {
        final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return Future.error(errorResponse["message"]);
      }
    } catch (e) {
      print("ESTE ES EL MENSAJE DE ERROR");
      print(e);
      return Future.error(e);
    }
  }

  Future<Map<String, List<AnatomyReference>>> getAnatomyReferences(int humanAnatomyId) async {
    final getReferencesUrl = Uri.parse('${humanAnatomyUrl}humanAnatomy/$humanAnatomyId/references');
    final token = await storage.read(key: 'token');

    try {
      final response = await http.get(
        getReferencesUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token ?? '',
        },
      );

      if (response.statusCode == 200) {
        final myData = json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        final List<AnatomyReference> anatomyReferenceList = myData
            .map((data) => AnatomyReference.fromJson(data))
            .toList();

        final omsReferences = anatomyReferenceList.where((ref) =>
        ref.fuente == 'OMS'
        ).toList();

        final internetReferences = anatomyReferenceList.where((ref) =>
        ref.fuente == 'INTERNET'
        ).toList();

        return {'OMS': omsReferences, 'INTERNET': internetReferences};
      } else {
        final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return Future.error(errorResponse["message"]);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

}
