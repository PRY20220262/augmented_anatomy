import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/main_menu.dart';
import '../utils/config.dart';

var authUrl = '${BACKEND_URL}users';

class HomeService {
  final storage = const FlutterSecureStorage();
  Future<MainMenuModel> getMainMenu() async {
    final email = await storage.read(key: 'email');
    final token = await storage.read(key: 'token');
    final requestGetMainMenuUrl = Uri.parse('$authUrl/$email/main-menu');
    try{
      http.Response response = await http.get(
        requestGetMainMenuUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token!,
        },
      );
      if (response.statusCode == 200) {
        return MainMenuModel.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return Future.error(errorResponse["message"]);
      }
    } catch (e){
      return Future.error(e);
    }
  }
}