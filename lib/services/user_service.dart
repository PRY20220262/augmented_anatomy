import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:augmented_anatomy/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:augmented_anatomy/utils/config.dart';

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

  Future<bool> updateProfile(
      {required String email,
      required String phone,
      required String birthday}) async {
    //    final userID = await storage.read(key: 'userId');
    final token = await storage.read(key: 'token');

    final updateProfileUrl = Uri.parse('${userUrl}/1/profile');

    try {
      print('Haciendo llamada a servicio ${updateProfileUrl.toString()}' +
          birthday);

      http.Response response = await http.put(
        updateProfileUrl,
        body:
            json.encode({'email': email, 'phone': phone, 'birthday': birthday}),
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
