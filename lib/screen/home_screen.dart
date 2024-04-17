import 'package:attendance_tracker/auth/auth_management.dart';
import 'package:attendance_tracker/controller/bottomnavigation_controller.dart';
import 'package:attendance_tracker/screen/attendance_screen.dart';
import 'package:attendance_tracker/screen/classes_screen.dart';
import 'package:attendance_tracker/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // controller
    var controller = Get.put(BottomNavigationController());
    var authmanager = Get.put(AuthenticationManager());
    var navBarItem = authmanager.getrole() == 'STUDENT'
        ? [
            const BottomNavigationBarItem(
                icon: Icon(Icons.check_circle), label: "Attendance"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Profile"),
          ]
        : [
            const BottomNavigationBarItem(
                icon: Icon(Icons.class_rounded), label: "Classes"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.check_circle), label: "Attendance"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Profile"),
          ];
    var navBody = authmanager.getrole() == 'STUDENT'
        ? [const AttendanceScreen(), const ProfileScreen()]
        : [ClassesScreen(), AttendanceScreen(), ProfileScreen()];

    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Expanded(
              child:
                  Obx(() => navBody.elementAt(controller.currentIndex.value)))
        ]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            items: navBarItem,
            currentIndex: controller.currentIndex.value,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            onTap: (value) => controller.currentIndex.value = value,
          ),
        ),
      ),
    );
  }
}
