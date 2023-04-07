class RecentActivityItem {

  late int? humanAnatomyId;
  late String? name;
  late String? shortDetail;
  late int? organsNumber;
  late String? urlImage;

  RecentActivityItem({this.humanAnatomyId, this.name, this.shortDetail, this.organsNumber, this.urlImage});

  RecentActivityItem.fromJson(Map<String, dynamic> json) {
    humanAnatomyId = json["id"];
    name = json["name"];
    shortDetail = json["shortDetail"];
    organsNumber = json["organsNumber"];
    urlImage = json["image"];
  }

}