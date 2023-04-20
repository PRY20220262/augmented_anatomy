import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:augmented_anatomy/models/human_anatomy.dart';
import 'package:augmented_anatomy/models/organs.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:augmented_anatomy/utils/config.dart';
import 'package:augmented_anatomy/models/system_list.dart';

var noteUrl = BACKEND_URL;

class NoteService {
  final storage = const FlutterSecureStorage();

  Future<bool> createNote(
      {required String title, required String description}) async {
    //    final userID = await storage.read(key: 'userId');
    final token = await storage.read(key: 'token');

    final createNoteUrl = Uri.parse('${noteUrl}users/1/notes');

    try {
      print(
          'Haciendo llamada a servicio ${createNoteUrl.toString()} $title $description');

      http.Response response = await http.post(
        createNoteUrl,
        body: json.encode({'title': title, 'detail': description}),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token!
        },
      );
      return true;
    } on TimeoutException catch (_) {
      return Future.error('La solicitud ha excedido el tiempo de espera.');
    } catch (e) {
      return Future.error(e);
    }
  }
}
