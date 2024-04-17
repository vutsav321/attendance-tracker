import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  User user;

  UserModel({
    required this.user,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class User {
  String name;
  dynamic rollno;
  String email;
  String role;

  User({
    required this.name,
    required this.rollno,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        rollno: json["rollno"],
        email: json["email"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "rollno": rollno,
        "email": email,
        "role": role,
      };
}
