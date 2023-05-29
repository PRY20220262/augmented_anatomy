class AnatomyReference {
  int? id;
  String? url;
  String? title;
  String? fuente;

  AnatomyReference({this.id, this.url, this.title, this.fuente});

  AnatomyReference.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    title = json['title'];
    fuente = json['fuente'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['title'] = this.title;
    data['fuente'] = this.fuente;
    return data;
  }
}