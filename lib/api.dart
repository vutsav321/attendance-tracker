import 'dart:convert';

import 'package:attendance_tracker/auth/auth_management.dart';
import 'package:attendance_tracker/controller/classdata_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Future api() async {
//   var headers = {
//     'Authorization':
//         'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdlNTk2OGQ0LWI3ZGItNDAyZS1iOTc1LTE2NjZiODZmYTAyZCIsImlhdCI6MTcwMDg0NzgxMiwiZXhwIjoxNzAxMjc5ODEyfQ.SV5lgqdOI8Jontd1dCFpK57z-6eB3VU6Qp6Y7ChcXVk'
//   };
//   var request =
//       http.Request('GET', Uri.parse('http://192.168.29.33:4000/api/user'));

//   request.headers.addAll(headers);

//   http.StreamedResponse response = await request.send();

//   if (response.statusCode == 200) {
//     print(await response.stream.bytesToString());
//     // any = await response.stream.bytesToString();
//     // print(userModelFromJson(any));
//   } else {
//     print(response.reasonPhrase);
//   }
// }

// Future api() async {
//   var headers = {'Content-Type': 'application/json'};
//   var request =
//       http.Request('POST', Uri.parse('http://192.168.29.33:4000/api/register'));
//   request.body = json.encode({
//     "name": "test",
//     "email": "skm@assdyy",
//     "password": "pass",
//     "role": "FACULTY"
//   });
//   request.headers.addAll(headers);

//   http.StreamedResponse response = await request.send();

//   if (response.statusCode == 200) {
//     print(await response.stream.bytesToString());
//   } else {
//     print(response.reasonPhrase);
//   }
// }

// Future api() async {
//   var headers = {'Content-Type': 'application/json'};
//   var request = http.Request(
//       'POST',
//       Uri.parse(
//           'https://attendance-tracker-backend-3q87.onrender.com/api/register'));
//   request.body = json.encode({
//     "name": "name",
//     "rollno": "2022445",
//     "password": "password",
//     "role": "STUDENT"
//   });
//   request.headers.addAll(headers);
//   http.StreamedResponse response = await request.send();

//   if (response.statusCode == 200) {
//     print(await response.stream.bytesToString());
//   } else {
//     print(response.reasonPhrase);
//   }
// }
// Future api() async {
//   var headers = {'Content-Type': 'application/json'};
//   var request = http.Request(
//       'POST',
//       Uri.parse(
//           'http://attendance-tracker-backend-3q87.onrender.com/api/login'));
//   request.body =
//       json.encode({"rollno": "1233134", "password": "pass", "role": "FACULTY"});
//   request.headers.addAll(headers);

//   http.StreamedResponse response = await request.send();

//   if (response.statusCode == 200) {
//     print(await response.stream.bytesToString());
//   } else {
//     print(response.reasonPhrase);
//   }
// }
// Future api() async {
//   var headers = {
//     'Authorization':
//         'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQ2MzIzNzM2LTllMzItNDk2Yy1hOTgxLWZhNWRmZDQ3MzJkYiIsImlhdCI6MTcwMTE5MzUwMiwiZXhwIjoxNzAxNjI1NTAyfQ.k0ePE2PNvRTdsTBNirmyaSncsvhU-8C1GFts8kuPZc0'
//   };
//   var request = http.Request(
//       'GET',
//       Uri.parse(
//           'https://attendance-tracker-backend-3q87.onrender.com/api/class'));
//   request.headers.addAll(headers);

//   http.StreamedResponse response = await request.send();

//   if (response.statusCode == 200) {
//     print(await response.stream.bytesToString());
//   } else {
//     print(response.reasonPhrase);
//   }
// }

Future api() async {
  final AuthenticationManager authenticationManager =
      Get.put(AuthenticationManager());
  final CLassDataController cLassDataController =
      Get.put(CLassDataController());
  String token = authenticationManager.getToken()!;
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  var request = http.Request(
      'POST',
      Uri.parse(
          'https://attendance-tracker-backend-3q87.onrender.com/api/attendance'));
  request.body = json.encode({
    "classId": '87dd8abf-56fc-4536-af4e-c9ae019595de',
    "rollno": '2021UG1013'
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
