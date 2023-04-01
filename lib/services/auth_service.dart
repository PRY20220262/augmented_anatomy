import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:augmented_anatomy/utils/config.dart';

var authUrl = '${BACKEND_URL}auth';

class AuthService {
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
}
