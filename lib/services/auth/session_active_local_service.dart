import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utils/config.dart';

class SessionManager {
  final storage = const FlutterSecureStorage();

  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'token');
    final userId = await storage.read(key: 'user_id');
    final email = await storage.read(key: 'email');
    final password = await storage.read(key: 'password');
    try {
      final response = await http.post(
          Uri.parse('${BACKEND_URL}auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': email,
            'password': password
          })
      );
      return response.statusCode == 200 && token != null && userId != null;
    } catch (e) {
      print(e);
      return false;
    }
  }
}