import 'package:attendance_tracker/auth/auth_management.dart';
import 'package:attendance_tracker/consts.dart';
import 'package:attendance_tracker/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  final AuthenticationManager _authenticationManager =
      Get.put(AuthenticationManager());
  changeScreen() async {
    _authenticationManager.checkLoginStatus();

    // Simulate other services for 3 seconds
    await Future.delayed(Duration(seconds: 3), () {
      _authenticationManager.isLogged.value
          ? Get.off(HomeScreen(), transition: Transition.zoom)
          : Get.off(LoginScreen(), transition: Transition.zoom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: changeScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashView();
        } else {
          if (snapshot.hasError) {
            return SplashView(info: 'Error ${snapshot.error}');
          } else {
            return SplashView();
          }
        }
      },
    );
  }
}

Scaffold SplashView({String info = ''}) {
  return Scaffold(
    body: Center(
        child: Column(
      children: [
        Flexible(
          child: Container(),
          flex: 3,
        ),
        Image.asset(
          'images/attendance.png',
          width: 100,
          height: 100,
        ),
        // these 20,10,30 are from velocity_x also spacer
        20.heightBox,
        appname.text
            .fontWeight(FontWeight.bold)
            .size(22)
            .color(Colors.blue)
            .make(),
        10.heightBox,
        info.text.size(20).make(),
        Flexible(
          child: Container(),
          flex: 3,
        ),
        // "DBMS Mini Project"
        //     .text
        //     .fontWeight(FontWeight.bold)
        //     .fontFamily(bold)
        //     .make(),
        5.heightBox
      ],
    )),
  );
}
