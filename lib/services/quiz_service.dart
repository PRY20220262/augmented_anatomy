import 'dart:convert';
import 'dart:io';

import 'package:augmented_anatomy/models/questions.dart';
import 'package:augmented_anatomy/models/quiz_attempt.dart';
import 'package:augmented_anatomy/models/quiz_attempt_detail_grouped.dart';
import 'package:augmented_anatomy/utils/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import '../models/quiz_attempt_detail.dart';

var quizAttemptURL = '${BACKEND_URL}quizAttempts';
var userURL = '${BACKEND_URL}users';
var quizURL = '${BACKEND_URL}humanAnatomy';

class QuizService {
  final storage = const FlutterSecureStorage();
  Future<List<Question>> getAllQuestionsAndChoices({required int id}) async {
    List<Question> questionsList = [];
    final token = await storage.read(key: 'token');
    final questionsUrl = Uri.parse('$quizURL/$id/questionsAnswers');
    try {
      http.Response response = await http.get(questionsUrl, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: token ?? ''
      });
      if (response.statusCode == 200) {
        List<dynamic> fetchedQuestions =
            jsonDecode(utf8.decode(response.bodyBytes));
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
    final createQuizAttemptURL =
        Uri.parse('$userURL/$userId/humanAnatomy/$humanAnatomyId/quizAttempt');
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
        quizAttempt =
            QuizAttempt.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
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
    final updateQuizAttemptScoreUrl =
        Uri.parse('$quizAttemptURL/$quizAttemptId/score/$score');
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
        quizAttempt =
            QuizAttempt.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        return quizAttempt.score;
      } else {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse['message'];
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<QuizAttemptDetail>> fetchQuizAttemptByUserId() async {
    final userId = await storage.read(key: 'userId');
    List<QuizAttemptDetail> listQuizAttempts = [];
    final token = await storage.read(key: 'token');
    final fetchQuizAttemptsUrl =
    Uri.parse('$userURL/$userId/quizAttemptsInfo');
    try {
      http.Response response = await http.get(
        fetchQuizAttemptsUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: token ?? ''
        }
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        for (var i = 0; i < data.length; i++) {
          listQuizAttempts.add(QuizAttemptDetail.fromJson(data[i]));
        }
        return listQuizAttempts;
      } else {
        final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return Future.error(errorResponse["message"]);
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<List<QuizAttemptDetailGrouped>> fetchQuizAttemptsGroupedByUserId() async {
    final userId = await storage.read(key: 'userId');
    final token = await storage.read(key: 'token');
    List<QuizAttemptDetailGrouped> listQuizAttemptDetailGrouped = [];
    final fetchQuizAttemptsGroupedUrl = Uri.parse('$userURL/$userId/quizAttemptGroupsByHumanAnatomy');
    try {
      http.Response response = await http.get(
          fetchQuizAttemptsGroupedUrl,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: token ?? ''
          }
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        for (var i = 0; i < data.length; i++) {
          listQuizAttemptDetailGrouped.add(QuizAttemptDetailGrouped.fromJson(data[i]));
        }
        print(listQuizAttemptDetailGrouped.length);
        return listQuizAttemptDetailGrouped;
      } else {
        final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return Future.error(errorResponse["message"]);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

}
