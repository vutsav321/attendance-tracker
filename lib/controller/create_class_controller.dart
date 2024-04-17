import 'dart:convert';
import 'package:attendance_tracker/auth/auth_management.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

createClass(String courseId, String time, String duration) async {
  final AuthenticationManager authenticationManager =
      Get.put(AuthenticationManager());
  String token = authenticationManager.getToken()!;
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://attendance-tracker-backend-3q87.onrender.com/api/class'));
  request.body =
      json.encode({"courseId": courseId, "start": time, "duration": duration});
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
