// To parse this JSON data, do
//
//     final getattendancemodel = getattendancemodelFromJson(jsonString);

import 'dart:convert';

Getattendancemodel getattendancemodelFromJson(String str) =>
    Getattendancemodel.fromJson(json.decode(str));

String getattendancemodelToJson(Getattendancemodel data) =>
    json.encode(data.toJson());

class Getattendancemodel {
  List<Attendence> attendence;

  Getattendancemodel({
    required this.attendence,
  });

  factory Getattendancemodel.fromJson(Map<String, dynamic> json) =>
      Getattendancemodel(
        attendence: List<Attendence>.from(
            json["Attendence"].map((x) => Attendence.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Attendence": List<dynamic>.from(attendence.map((x) => x.toJson())),
      };
}

class Attendence {
  User user;

  Attendence({
    required this.user,
  });

  factory Attendence.fromJson(Map<String, dynamic> json) => Attendence(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class User {
  String rollno;

  User({
    required this.rollno,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        rollno: json["rollno"],
      );

  Map<String, dynamic> toJson() => {
        "rollno": rollno,
      };
}
