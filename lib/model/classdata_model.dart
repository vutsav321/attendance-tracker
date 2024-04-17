// To parse this JSON data, do
//
//     final classdatamodel = classdatamodelFromJson(jsonString);

import 'dart:convert';

List<Classdatamodel> classdatamodelFromJson(String str) =>
    List<Classdatamodel>.from(
        json.decode(str).map((x) => Classdatamodel.fromJson(x)));

String classdatamodelToJson(List<Classdatamodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Classdatamodel {
  String id;
  String start;
  String duration;
  Subject subject;

  Classdatamodel({
    required this.id,
    required this.start,
    required this.duration,
    required this.subject,
  });

  factory Classdatamodel.fromJson(Map<String, dynamic> json) => Classdatamodel(
        id: json["id"],
        start: json["start"],
        duration: json["duration"],
        subject: Subject.fromJson(json["subject"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start": start,
        "duration": duration,
        "subject": subject.toJson(),
      };
}

class Subject {
  int sem;
  String coursename;

  Subject({
    required this.sem,
    required this.coursename,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        sem: json["sem"],
        coursename: json["coursename"],
      );

  Map<String, dynamic> toJson() => {
        "sem": sem,
        "coursename": coursename,
      };
}
