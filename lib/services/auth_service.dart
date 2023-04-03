import 'dart:io';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:augmented_anatomy/utils/config.dart';

var authUrl = '${BACKEND_URL}auth';

class AuthService {
  final storage = const FlutterSecureStorage();

  Future<bool> requestPin(email) async {
    final requestPinUrl = Uri.parse('$authUrl/request-pin/$email');

    print('Haciendo llamada a servicio ${requestPinUrl.toString()}');

    http.Response response = await http.post(
      requestPinUrl,
      body: null,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> login(String email, String password) async {
    final loginUrl = Uri.parse('$authUrl/login');

    try {
      final response = await http.post(loginUrl,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'email': email, 'password': password}));
      if (response.statusCode == 200) {
        final authorizationHeader = response.headers['authorization'];
        await storage.write(key: 'token', value: authorizationHeader);
        await storage.write(key: 'email', value: email);
        await storage.write(key: 'password', value: password);
        //await storage.write(key: 'user_id', value: '1');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String> validatePIN(email, pin) async {
    final validatePinUrl = Uri.parse('$authUrl/validate-pin');

    print('Haciendo llamada a servicio ${validatePinUrl.toString()}');
    print('Con PIN $pin y email $email');

    try {
      http.Response response = await http.post(
        validatePinUrl,
        body: json.encode({'email': email, 'pin': pin}),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );
      if (response.statusCode == 200) {
        print('PIN CORRECTO');
        return '';
      } else {
        final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));

        switch (errorResponse["codError"]) {
          case 1002:
            {
              // NO EXISTE PIN;
              print("No existe pin");
            }
            break;

          case 1003:
            {
              // EMAIL Y PIN NO HACEN MATCH;
              print("EMAIL Y PIN NO HACEN MATCH");
            }
            break;
        }

        return 'invalid';
      }
    } catch (e) {
      print(e);
      return 'error';
    }
  }
}