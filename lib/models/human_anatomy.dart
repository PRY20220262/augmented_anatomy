import 'package:augmented_anatomy/models/characteristics.dart';

class HumanAnatomy {
  int? id;
  String? name;
  String? detail;
  String? image;
  bool? hasGender;
  List<Characteristic>? characteristics;

  HumanAnatomy(
      {this.id,
      this.name,
      this.detail,
      this.image,
      this.hasGender,
      this.characteristics});

  HumanAnatomy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    detail = json['detail'];
    image = json['image'];
    hasGender = json['hasGender'];
    if (json['characteristics'] != null) {
      characteristics = <Characteristic>[];
      json['characteristics'].forEach((v) {
        characteristics!.add(Characteristic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['detail'] = detail;
    data['image'] = image;
    data['hasGender'] = hasGender;
    if (characteristics != null) {
      data['characteristics'] =
          characteristics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
