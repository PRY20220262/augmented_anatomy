import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  final storage = const FlutterSecureStorage();

  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'token');
    final email = await storage.read(key: 'email');
    return email != null && token != null;
  }
}
