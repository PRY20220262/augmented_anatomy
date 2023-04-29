import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:augmented_anatomy/models/human_anatomy.dart';
import 'package:augmented_anatomy/models/note.dart';
import 'package:augmented_anatomy/models/user.dart';
import 'package:augmented_anatomy/pages/profile/notes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:augmented_anatomy/utils/config.dart';
import 'package:augmented_anatomy/models/system_list.dart';

var userUrl = "${BACKEND_URL}users";

class UserService {
  final storage = const FlutterSecureStorage();

  Future<User> getUser() async {
    //    final userID = await storage.read(key: 'userId');
    final token = await storage.read(key: 'token');

    final getNotUrl = Uri.parse('${userUrl}/1');
    print('Haciendo llamada a servicio ${getNotUrl.toString()} ');

    try {
      http.Response response = await http.get(
        getNotUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token!
        },
      );
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return Future.error(errorResponse["message"]);
      }
    } on TimeoutException catch (_) {
      return Future.error('La solicitud ha excedido el tiempo de espera.');
    } catch (e) {
      return Future.error(e);
    }
  }
}
