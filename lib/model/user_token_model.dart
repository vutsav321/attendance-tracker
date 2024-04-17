// To parse this JSON data, do
//
//     final userTokenModel = userTokenModelFromJson(jsonString);

import 'dart:convert';

UserTokenModel userTokenModelFromJson(String str) =>
    UserTokenModel.fromJson(json.decode(str));

String userTokenModelToJson(UserTokenModel data) => json.encode(data.toJson());

class UserTokenModel {
  String name;
  String token;

  UserTokenModel({
    required this.name,
    required this.token,
  });

  factory UserTokenModel.fromJson(Map<String, dynamic> json) => UserTokenModel(
        name: json["name"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "token": token,
      };
}
