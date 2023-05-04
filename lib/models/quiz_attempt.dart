class QuizAttempt {
  int? id;
  double? score;
  String? createdAt;

  QuizAttempt({this.id, this.score, this.createdAt});

  QuizAttempt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    score = json['score'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['score'] = this.score;
    data['created_at'] = this.createdAt;
    return data;
  }
}