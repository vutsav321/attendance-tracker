import 'package:attendance_tracker/controller/attendancelist_controller.dart';
import 'package:attendance_tracker/screen/attendance_list_screen.dart';
import 'package:attendance_tracker/widget/class_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../consts.dart';
import '../controller/classdata_controller.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final CLassDataController cLassDataController =
      Get.put(CLassDataController());
  final AttendanceListController attendanceListController =
      Get.put(AttendanceListController());
  final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: "Attendance List".text.fontFamily(regular).make(),
      ),
      body: Column(
        children: [
          10.heightBox,
          "Today's attendance List".text.fontFamily(regular).size(20).make(),
          10.heightBox,
          Obx(() => cLassDataController.ClassData.length != 0
              ? Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Container(
                      height: 5,
                    ),
                    itemCount: cLassDataController.ClassData.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Get.to(AttendanceListScreen(
                          subject: cLassDataController
                              .ClassData[index].subject.coursename,
                        ));
                        attendanceListController.classId.value =
                            cLassDataController.ClassData[index].id;
                      },
                      child: ClassTile(
                        sem: cLassDataController.ClassData[index].subject.sem,
                        subject: cLassDataController
                            .ClassData[index].subject.coursename,
                        startTime: cLassDataController.ClassData[index].start,
                        duration: cLassDataController.ClassData[index].duration,
                      )
                          .box
                          .padding(EdgeInsets.all(8))
                          .withDecoration(decoration)
                          .make(),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                )),
        ],
      ),
    );
  }
}
