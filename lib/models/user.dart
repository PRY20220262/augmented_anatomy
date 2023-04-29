import 'package:augmented_anatomy/models/profile.dart';

class User {
  int? id;
  String? email;
  String? password;
  String? pin;
  Profile? profile;

  User({this.id, this.email, this.password, this.pin, this.profile});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    pin = json['pin'];
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['pin'] = pin;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}
