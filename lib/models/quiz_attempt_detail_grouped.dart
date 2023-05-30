import 'package:augmented_anatomy/models/quiz_attempt.dart';

class QuizAttemptDetailGrouped {
  double? maxScore;
  int? humanAnatomyId;
  String? nameHumanAnatomy;
  int? countAttempts;
  List<QuizAttempt>? quizAttemptByHumanAnatomy;

  QuizAttemptDetailGrouped(
      {this.maxScore,
        this.humanAnatomyId,
        this.nameHumanAnatomy,
        this.countAttempts,
        this.quizAttemptByHumanAnatomy});

  QuizAttemptDetailGrouped.fromJson(Map<String, dynamic> json) {
    maxScore = json['maxScore'];
    humanAnatomyId = json['humanAnatomyId'];
    nameHumanAnatomy = json['nameHumanAnatomy'];
    countAttempts = json['countAttempts'];
    if (json['quizAttemptByHumanAnatomy'] != null) {
      quizAttemptByHumanAnatomy = <QuizAttempt>[];
      json['quizAttemptByHumanAnatomy'].forEach((v) {
        quizAttemptByHumanAnatomy!
            .add(QuizAttempt.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxScore'] = this.maxScore;
    data['humanAnatomyId'] = this.humanAnatomyId;
    data['nameHumanAnatomy'] = this.nameHumanAnatomy;
    data['countAttempts'] = this.countAttempts;
    if (this.quizAttemptByHumanAnatomy != null) {
      data['quizAttemptByHumanAnatomy'] =
          this.quizAttemptByHumanAnatomy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
