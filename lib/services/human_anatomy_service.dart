import 'dart:io';
import 'dart:convert';
import 'package:augmented_anatomy/models/human_anatomy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:augmented_anatomy/utils/config.dart';

var humanAnatomyUrl = BACKEND_URL;

class HumanAnatomyService {
  final storage = const FlutterSecureStorage();

  Future<HumanAnatomy> getById(id) async {
    final getByIdUrl = Uri.parse('${humanAnatomyUrl}human-anatomy/$id');

    print('Haciendo llamada a servicio ${getByIdUrl.toString()}');

    // TODO: final prefs = await SharedPreferences.getInstance();
    // final String? token = prefs.getString('token');
    final String token =
        'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJxdWlzcGVjYWxpeHRvZ2lub0BnbWFpbC5jb20iLCJlbWFpbCI6InF1aXNwZWNhbGl4dG9naW5vQGdtYWlsLmNvbSJ9.SllXYubGYmIX2nXjtjZ_wFNjTRA5J5aSnEfU3YbpBe4x57Kmmnhc1cU4SwNuHooVtQXK6zvaE79-Cafx42eaHQ';

    try {
      http.Response response = await http.get(
        getByIdUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token
        },
      );

      if (response.statusCode == 200) {
        return HumanAnatomy.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return Future.error(errorResponse["message"]);
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
