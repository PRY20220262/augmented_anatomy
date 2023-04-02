import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../utils/config.dart';

var authUrl = '${BACKEND_URL}auth';

class LoginService {
  final requestPinUrl = Uri.parse('$authUrl/login');
  final storage = const FlutterSecureStorage();
  Future<bool> loginRequest(String email, String password) async {
    try {
      final response = await http.post(
          requestPinUrl,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': email,
            'password': password
          })
      );
      if(response.statusCode == 200) {
        final authorizationHeader = response.headers['authorization'];
        await storage.write(key: 'token', value: authorizationHeader);
        await storage.write(key: 'email', value: email);
        await storage.write(key: 'password', value: password);
        //await storage.write(key: 'user_id', value: '1');
        return true;
      } else { return false; }
    } catch (e) {
      print(e);
      return false;
    }
  }

}

/*await storage.write(key: 'token', value: 'valor del token');
await storage.write(key: 'id_usuario', value: '1234');*/