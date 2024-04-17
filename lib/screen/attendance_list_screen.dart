import 'package:attendance_tracker/consts.dart';
import 'package:attendance_tracker/controller/attendancelist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AttendanceListScreen extends StatelessWidget {
  String subject;
  AttendanceListScreen({required this.subject});

  @override
  Widget build(BuildContext context) {
    final AttendanceListController attendanceListController =
        Get.put(AttendanceListController());
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Colors.grey));
    return Scaffold(
      appBar: AppBar(
        title: subject.text.fontFamily(regular).make(),
      ),
      body: Obx(
        () => attendanceListController.attendanceList.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: attendanceListController.attendanceList.length,
                itemBuilder: (context, index) => attendanceListController
                    .attendanceList[index].user.rollno.text
                    .size(23)
                    .make()
                    .box
                    .padding(EdgeInsets.symmetric(horizontal: 12, vertical: 6))
                    .withDecoration(decoration)
                    .make(),
              )
            : Center(
                child: Text('No Attendance recorded yet.'),
              ),
      ),
    );
  }
}
