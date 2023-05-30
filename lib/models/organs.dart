class OrgansModel {

  late int id;
  late String name;
  late String shortDetail;
  late String imageUrl;
  late String system;

  OrgansModel(this.id, this.name, this.shortDetail, this.imageUrl, this.system);

  OrgansModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortDetail = json["shortDetail"];
    imageUrl = json ["image"];
    system = json["system"];
  }

}