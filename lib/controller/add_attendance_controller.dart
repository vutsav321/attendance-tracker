import 'dart:convert';
import 'package:attendance_tracker/auth/auth_management.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Attendance extends GetxController {
  var rollno = ''.obs;
  addAttendance(String classId) async {
    final AuthenticationManager authenticationManager =
        Get.put(AuthenticationManager());
    String token = authenticationManager.getToken()!;
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    rollno.value = '2021UG1013';
    print(classId);
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://attendance-tracker-backend-3q87.onrender.com/api/attendance'));
    request.body = json.encode({"classId": classId, "rollno": rollno.value});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
