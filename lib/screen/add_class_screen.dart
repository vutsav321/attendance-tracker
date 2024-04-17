import 'package:attendance_tracker/controller/classdata_controller.dart';
import 'package:attendance_tracker/controller/create_class_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

// import 'package:provider/provider.dart';
// import 'package:todoey_flutter/models/task_data.dart';
class AddClassScreen extends StatefulWidget {
  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  final CLassDataController cLassDataController =
      Get.put(CLassDataController());
  String courseId = '';
  String time = '';
  String duration = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF757575),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Add Class',
                style: TextStyle(color: Colors.lightBlueAccent, fontSize: 22),
              ),
              10.heightBox,
              TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(hintText: 'CourseId'),
                onChanged: (value) {
                  courseId = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
              ),
              10.heightBox,
              TextField(
                decoration: InputDecoration(hintText: 'Time'),
                onChanged: (value) {
                  time = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
              ),
              10.heightBox,
              TextField(
                decoration: InputDecoration(hintText: 'Duration'),
                onChanged: (value) {
                  duration = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
              ),
              10.heightBox,
              TextButton(
                onPressed: () {
                  createClass(courseId, time, duration);
                  // cLassDataController.ClassData.length++;
                  Navigator.pop(context);
                },
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                  ),
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.lightBlueAccent),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
