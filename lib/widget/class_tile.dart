import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ClassTile extends StatelessWidget {
  final int sem;
  final String subject;
  final String startTime;
  final String duration;
  const ClassTile({
    required this.sem,
    required this.subject,
    required this.startTime,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    // final inputBorder =
    //     OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InnerTile(title: "Sem: ", data: sem.toString()),
            InnerTile(title: "Start Time: ", data: startTime.toString())
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InnerTile(title: "Subject: ", data: subject),
            InnerTile(title: "Duration: ", data: duration.toString())
          ],
        ),
      ],
    );
  }
}

class InnerTile extends StatelessWidget {
  final String title;
  final String data;
  const InnerTile({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.text.size(16).color(Colors.grey).make(),
        5.widthBox,
        data.text.size(16).make()
      ],
    );
  }
}
