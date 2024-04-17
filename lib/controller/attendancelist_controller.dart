import 'dart:convert';

import 'package:attendance_tracker/auth/auth_management.dart';
import 'package:attendance_tracker/model/getattendance_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AttendanceListController extends GetxController {
  var classId = ''.obs;

  var attendanceList = <Attendence>[].obs;
  @override
  void onInit() async {
    await getattendancelist(classId.value);
    super.onInit();
  }

  getattendancelist(String classId) async {
    String futuredata;
    final authmanager = Get.put(AuthenticationManager());
    String token = authmanager.getToken()!;
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImIzYjM5NjQ0LWIyOTYtNGZjNy1iZWY2LTYwZjljMWE4YWQ5MCIsImlhdCI6MTcwMTE5ODgxMiwiZXhwIjoxNzAxNjMwODEyfQ.vtgq28UFyNzphOJi38a4eULG77tle5UC0MY65mjUKK0'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://attendance-tracker-backend-3q87.onrender.com/api/class-attendance'));
    request.body =
        json.encode({"classId": 'c5a2e488-ae15-4fe0-b1a1-69599abcfb0a'});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      futuredata = await response.stream.bytesToString();
      print(futuredata);
      attendanceList.value = getattendancemodelFromJson(futuredata).attendence;
    } else {
      print(response.reasonPhrase);
    }
  }
}
