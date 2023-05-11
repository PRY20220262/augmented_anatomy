class QuizAttemptDetail {
  int? id;
  double? score;
  String? createdAt;
  int? humanAnatomyId;
  String? nameHumanAnatomy;

  QuizAttemptDetail(
      {this.id,
        this.score,
        this.createdAt,
        this.humanAnatomyId,
        this.nameHumanAnatomy});

  QuizAttemptDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    score = json['score'];
    createdAt = json['created_at'];
    humanAnatomyId = json['humanAnatomyId'];
    nameHumanAnatomy = json['nameHumanAnatomy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['score'] = this.score;
    data['created_at'] = this.createdAt;
    data['humanAnatomyId'] = this.humanAnatomyId;
    data['nameHumanAnatomy'] = this.nameHumanAnatomy;
    return data;
  }
}