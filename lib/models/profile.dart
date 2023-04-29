class Profile {
  int? id;
  String? fullName;
  String? phone;
  String? birthDate;
  String? userType;
  String? photoUrl;

  Profile(
      {this.id,
      this.fullName,
      this.phone,
      this.birthDate,
      this.userType,
      this.photoUrl});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    phone = json['phone'];
    birthDate = json['birthDate'];
    userType = json['userType'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['phone'] = phone;
    data['birthDate'] = birthDate;
    data['userType'] = userType;
    data['photoUrl'] = photoUrl;
    return data;
  }
}
