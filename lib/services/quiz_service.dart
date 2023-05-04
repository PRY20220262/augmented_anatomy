import 'dart:convert';
import 'dart:io';

import 'package:augmented_anatomy/models/quiz_attempt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/questions.dart';
import '../utils/config.dart';
import 'package:http/http.dart' as http;

var quizAttemptURL = '${BACKEND_URL}quizAttempts';
var userURL = '${BACKEND_URL}users';
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

  Future<QuizAttempt> createQuizAttempt(int humanAnatomyId) async {
    final token = await storage.read(key: 'token');
    final userRead = await storage.read(key: 'userId');
    int userId = int.parse(userRead!);
    final createQuizAttemptURL = Uri.parse('$userURL/$userId/humanAnatomy/$humanAnatomyId/quizAttempt');
    try {
      http.Response response = await http.post(
        createQuizAttemptURL,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token ?? ''
        },
      );
      if (response.statusCode == 200) {
        QuizAttempt quizAttempt = QuizAttempt();
        quizAttempt =  QuizAttempt.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
        return quizAttempt;
      } else {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse['message'];
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<double?> updateQuizAttemptScore(int quizAttemptId, int score) async {
    final token = await storage.read(key: 'token');
    final updateQuizAttemptScoreUrl = Uri.parse('$quizAttemptURL/$quizAttemptId/score/$score');
    try {
      http.Response response = await http.put(
        updateQuizAttemptScoreUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token ?? ''
        },
      );
      if (response.statusCode == 200) {
        QuizAttempt quizAttempt = QuizAttempt();
        quizAttempt =  QuizAttempt.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
        print("ESTE ES EL QUIZ");
        print(quizAttempt.id);
        print(quizAttempt.createdAt);
        print(quizAttempt.score);
        return quizAttempt.score;
      } else {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse['message'];
      }
    } catch (e) {
      return Future.error(e);
    }
  }

}