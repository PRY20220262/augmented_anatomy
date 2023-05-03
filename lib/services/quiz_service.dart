import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/questions.dart';
import '../utils/config.dart';
import 'package:http/http.dart' as http;

var quizURL = '${BACKEND_URL}humanAnatomy';

class QuizService {
  final storage = const FlutterSecureStorage();
  Future<List<Question>> getAllQuestionsAndChoices({required int id}) async {
    List<Question> questionsList = [];
    final token = await storage.read(key: 'token');
    final questionsUrl = Uri.parse('$quizURL/$id/questionsAnswers');
    try{
      http.Response response = await http.get(
          questionsUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token ?? ''
        }
      );
      if (response.statusCode == 200) {
        List<dynamic> fetchedQuestions = jsonDecode(utf8.decode(response.bodyBytes));
        for (var i = 0; i < fetchedQuestions.length; i++) {
          questionsList.add(Question.fromJson(fetchedQuestions[i]));
        }
        print(questionsList[0].answers?.length);
        return questionsList;
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