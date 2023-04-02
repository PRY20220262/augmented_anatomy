import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

mixin InternetConnectionMixin<T extends StatefulWidget> on State<T> {
  Future<void> checkConnectionDevice() async {}
  Future<void> checkInternetConnection() async {}
}

class InternetValidator {
  static Future<bool> validateConnectionDevice() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
  static Future<bool> validateInternetDevice() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com'));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}