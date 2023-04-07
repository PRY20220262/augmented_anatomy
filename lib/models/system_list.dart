class SystemList {
  int? id;
  String? name;
  String? shortDetail;
  int? organsNumber;
  String? image;

  SystemList(
      {this.id, this.name, this.shortDetail, this.organsNumber, this.image});

  SystemList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortDetail = json['shortDetail'];
    organsNumber = json['organsNumber'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['shortDetail'] = shortDetail;
    data['organsNumber'] = organsNumber;
    data['image'] = image;
    return data;
  }
}
