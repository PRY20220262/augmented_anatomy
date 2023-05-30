class QuestionChoices {
  int? id;
  String? choice;
  bool? isCorrect;

  QuestionChoices({this.id, this.choice, this.isCorrect});

  QuestionChoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    choice = json['choice'];
    isCorrect = json['isCorrect'];
  }

}