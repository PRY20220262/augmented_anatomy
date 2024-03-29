import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:augmented_anatomy/models/note.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:augmented_anatomy/utils/config.dart';

var noteUrl = BACKEND_URL;

class NoteService {
  final storage = const FlutterSecureStorage();

  Future<bool> createNote(
      {required String title, required String description}) async {
    final userId = await storage.read(key: 'userId');
    final token = await storage.read(key: 'token');

    final createNoteUrl = Uri.parse('${noteUrl}users/$userId/notes');

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

  Future<List<Note>> findNotes() async {
    final userId = await storage.read(key: 'userId');
    List<Note> notes = [];
    final token = await storage.read(key: 'token');
    final findNotesUrl = Uri.parse('${noteUrl}users/$userId/notes');

    print('Haciendo llamada a servicio ${findNotesUrl.toString()}');

    try {
      http.Response response = await http.get(
        findNotesUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token!
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        for (var i = 0; i < data.length; i++) {
          notes.add(Note.fromJson(data[i]));
        }
        return notes;
      } else {
        final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return Future.error(errorResponse["message"]);
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<bool> deleteNote({required int id}) async {
    final userId = await storage.read(key: 'userId');

    final token = await storage.read(key: 'token');
    final deleteNoteUrl = Uri.parse('${noteUrl}users/$userId/notes/$id');

    try {
      print('Haciendo llamada a servicio ${deleteNoteUrl.toString()} ');

      http.Response response = await http.delete(
        deleteNoteUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token!
        },
      );
      print("${response.statusCode} ---- ${response.body}");
      return true;
    } on TimeoutException catch (_) {
      return Future.error('La solicitud ha excedido el tiempo de espera.');
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> updateNote(
      {required String title,
      required String description,
      required int id}) async {
    final userId = await storage.read(key: 'userId');
    final token = await storage.read(key: 'token');

    final createNoteUrl = Uri.parse('${noteUrl}users/$userId/notes/$id');

    try {
      print(
          'Haciendo llamada a servicio ${createNoteUrl.toString()} $title $description');

      http.Response response = await http.put(
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
