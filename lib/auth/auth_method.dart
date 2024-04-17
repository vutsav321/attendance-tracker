import 'dart:convert';

import 'package:attendance_tracker/auth/auth_management.dart';
import 'package:attendance_tracker/consts.dart';
import 'package:attendance_tracker/controller/role_controller.dart';
import 'package:attendance_tracker/controller/user_token_controller.dart';
import 'package:attendance_tracker/model/user_token_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthMethod {
  final RoleController _roleController = Get.put(RoleController());
  final UserControllerToken _token = Get.put(UserControllerToken());
  final AuthenticationManager _authenticationManager =
      Get.put(AuthenticationManager());
  Future<String> registerUser(
      {required String emailOrRoll,
      required String name,
      required String password}) async {
    String futuredata;
    String res = 'Some error occurred';
    try {
      if (emailOrRoll.isNotEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty &&
          _roleController.roleOfUser.value != '') {
        var headers = {'Content-Type': 'application/json'};
        var request = http.Request('POST', Uri.parse('$apiLink/register'));
        request.body = _roleController.roleOfUser.value == "STUDENT"
            ? json.encode({
                "name": name,
                "rollno": emailOrRoll,
                "password": password,
                "role": _roleController.roleOfUser.value
              })
            : json.encode({
                "name": name,
                "email": emailOrRoll,
                "password": password,
                "role": _roleController.roleOfUser.value
              });
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          res = 'success';
          // print(await response.stream.bytesToString());
          futuredata = await response.stream.bytesToString();
          _token.tokenuserdata.value = userTokenModelFromJson(futuredata);
          _authenticationManager.login(
              _token.tokenuserdata.value.token,
              _token.tokenuserdata.value.name,
              emailOrRoll,
              _roleController.roleOfUser.value);
          ;
          print(_token.tokenuserdata.value.token);
        } else {
          print(response.reasonPhrase);
        }
      } else {
        res = "Please fill all the details";
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String emailOrRoll, required String password}) async {
    String futuredata;
    String res = "Some error occurred";
    try {
      if (emailOrRoll.isNotEmpty &&
          password.isNotEmpty &&
          _roleController.roleOfUser.value != '') {
        var headers = {'Content-Type': 'application/json'};
        var request = http.Request('POST', Uri.parse('$apiLink/login'));
        request.body = _roleController.roleOfUser.value == "STUDENT"
            ? json.encode({
                "rollno": emailOrRoll,
                "password": password,
                "role": _roleController.roleOfUser.value
              })
            : json.encode({
                "email": emailOrRoll,
                "password": password,
                "role": _roleController.roleOfUser.value
              });
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          res = 'success';
          // print(await response.stream.bytesToString());
          futuredata = await response.stream.bytesToString();
          print(futuredata);
          _token.tokenuserdata.value = userTokenModelFromJson(futuredata);
          // print(_token.tokenuserdata.value.token);
          // print(userTokenModelFromJson(futuredata).token);
          _authenticationManager.login(
              _token.tokenuserdata.value.token,
              _token.tokenuserdata.value.name,
              emailOrRoll,
              _roleController.roleOfUser.value);
        } else {
          print(response.reasonPhrase);
        }
      } else {
        res = "Please fill all the details";
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }
}
