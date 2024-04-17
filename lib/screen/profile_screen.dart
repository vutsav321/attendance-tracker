import 'package:attendance_tracker/auth/auth_management.dart';
import 'package:attendance_tracker/screen/login_screen.dart';
import 'package:attendance_tracker/widget/detail_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../consts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationManager authenticationManager =
        Get.put(AuthenticationManager());
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: "Your Profile".text.fontFamily(regular).make(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.logout_rounded),
              onPressed: () {
                authenticationManager.logOut();
                Get.off(LoginScreen(), transition: Transition.downToUp);
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(),
            flex: 1,
          ),
          Column(
            children: [
              DetailTile(
                title: "Name",
                descrpition: authenticationManager.getusername()!,
              ),
              authenticationManager.getrole()! == 'FACULTY'
                  ? DetailTile(
                      title: "Email Id",
                      descrpition: authenticationManager.getemaiOrRoll()!,
                    )
                  : DetailTile(
                      title: "Roll no",
                      descrpition: authenticationManager.getemaiOrRoll()!,
                    ),
              DetailTile(
                title: "Role",
                descrpition: authenticationManager.getrole()!.capitalizeFirst!,
              ),
            ],
          ).box.width(250).withDecoration(decoration).make(),
          Flexible(
            child: Container(),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
