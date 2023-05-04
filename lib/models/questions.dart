import 'package:augmented_anatomy/models/question_choices.dart';

class Question {
  int? id;
  String? title;
  List<QuestionChoices>? answers;

  Question({this.id, this.title, this.answers});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['answers'] != null) {
      answers = <QuestionChoices>[];
      json['answers'].forEach((v) {
        answers!.add(QuestionChoices.fromJson(v));
      });
    }
  }

}