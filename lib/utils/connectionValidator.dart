import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

mixin InternetConnectionMixin<T extends StatefulWidget> on State<T> {
  Future<void> checkInternetConnection() async {}
}

class ConnectionValidator {
  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
