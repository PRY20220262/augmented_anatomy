class Characteristic {
  int? id;
  String? title;
  String? shortDetail;
  String? detail;

  Characteristic({this.id, this.title, this.shortDetail, this.detail});

  Characteristic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDetail = json['shortDetail'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['shortDetail'] = shortDetail;
    data['detail'] = detail;
    return data;
  }
}
