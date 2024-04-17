import 'package:attendance_tracker/consts.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailTile extends StatelessWidget {
  final String title;
  final String descrpition;
  const DetailTile(
      {super.key, this.title = 'Name', this.descrpition = 'abc def'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title.text.size(14).color(Colors.blue).fontFamily(regular).make(),
          8.heightBox,
          descrpition.text.size(18).make()
        ],
      ),
    );
  }
}
