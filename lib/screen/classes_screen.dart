import 'package:attendance_tracker/auth/auth_management.dart';
import 'package:attendance_tracker/consts.dart';
import 'package:attendance_tracker/controller/classdata_controller.dart';
import 'package:attendance_tracker/screen/add_class_screen.dart';
import 'package:attendance_tracker/screen/scanner_screen.dart';
import 'package:attendance_tracker/widget/class_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationManager _authmanager = Get.put(AuthenticationManager());
    final CLassDataController cLassDataController =
        Get.put(CLassDataController());
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey));
    String username = _authmanager.getusername()!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: "Hi.. $username".text.fontFamily(regular).make(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.library_add),
              onPressed: () {
                showModalBottomSheet(
                    context: context, builder: (context) => AddClassScreen());
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          10.heightBox,
          "Your Today's Classes".text.fontFamily(regular).size(20).make(),
          10.heightBox,
          Obx(() => cLassDataController.ClassData.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Container(
                      height: 5,
                    ),
                    itemCount: cLassDataController.ClassData.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Get.to(
                            ScannerScreen(
                                classId:
                                    cLassDataController.ClassData[index].id),
                            transition: Transition.zoom);
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
                  child: Text('No classes are found'),
                ))
        ],
      ),
    );
  }
}
