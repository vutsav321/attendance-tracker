import 'package:attendance_tracker/controller/add_attendance_controller.dart';
import 'package:get/get.dart';

class Finddeatils {
  var attendance = Get.put(Attendance());
  String details;

  Finddeatils(this.details);
  int i = 0;
  late int length = details.length;

  String Findroll(String classId) {
    while (details[i] != '/') {
      i++;
    }
    // print(details.substring(0, i - 1));
    attendance.rollno.value = details.substring(0, i - 1);
    attendance.addAttendance(classId);
    return (details.substring(0, i - 1));
  }

  String Findname() {
    int j = i + 2;
    i = j;
    while (details[i] != '/') {
      i++;
    }
    return (details.substring(j + 1, i - 1));
  }
}
