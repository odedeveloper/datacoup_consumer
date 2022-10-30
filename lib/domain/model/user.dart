// class User {
//   final String? name;
//   final String? username;
//   final String? image;
//   User({
//     required this.name,
//     required this.username,
//     this.image,
//   });

//   factory User.empty() => User(name: null, username: null, image: null);
// }

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.odenId,
    this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.profileImage,
    this.gender,
    this.dob,
    this.country,
    this.state,
    this.zipCode,
    this.isAdmin,
  });

  String? odenId;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  String? profileImage;
  String? gender;
  String? dob;
  String? country;
  String? state;
  String? zipCode;
  bool? isAdmin;

  factory User.empty() => User(
        odenId: null,
        firstName: null,
        lastName: null,
        mobile: null,
        email: null,
        profileImage: null,
        gender: null,
        dob: null,
        country: null,
        state: null,
        zipCode: null,
        isAdmin: null,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        odenId: json["odenId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobile: json["mobile"],
        email: json["email"],
        profileImage: json["profileImage"],
        gender: json["gender"],
        dob: json["dob"],
        country: json["country"],
        state: json["state"],
        zipCode: json["zipCode"],
        isAdmin: json["isAdmin"],
      );

  Map<String, dynamic> toJson() => {
        "odenId": odenId,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
        "email": email,
        "profileImage": profileImage,
        "gender": gender,
        "dob": dob,
        "country": country,
        "state": state,
        "zipCode": zipCode,
        "isAdmin": isAdmin,
      };
}


class MethodResponse {
  bool isSuccess;
  String errorMessage;
  MethodResponse({this.isSuccess = false, this.errorMessage = ""});
}
