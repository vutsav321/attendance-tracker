import 'package:attendance_tracker/auth/auth_method.dart';
import 'package:attendance_tracker/consts.dart';
import 'package:attendance_tracker/controller/role_controller.dart';
import 'package:attendance_tracker/screen/home_screen.dart';
import 'package:attendance_tracker/screen/registration_screen.dart';
import 'package:attendance_tracker/widget/textfiels_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailOrRollnoController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RoleController _roleController = Get.put(RoleController());
  String? value;
  bool _isloading = false;
  bool _isSelectedRole = false;
  @override
  void dispose() {
    _emailOrRollnoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void logIn() async {
    setState(() {
      _isloading = true;
    });
    String res = "success";
    res = await AuthMethod().loginUser(
        password: _passwordController.text,
        emailOrRoll: _emailOrRollnoController.text);

    setState(() {
      _isloading = false;
    });
    if (res == 'success') {
      Get.snackbar('YAY', 'You have successfully LogIn');
      Get.off(HomeScreen());
    } else {
      Get.snackbar('SORRY', res);
    }
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item.capitalizeFirst!,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Container(),
              flex: 1,
            ),
            Image(
              height: 100,
              width: 100,
              image: AssetImage(
                'images/attendance.png',
              ),
            ),
            10.heightBox,
            const Text(
              'Login to $appname',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            const SizedBox(
              height: 64,
            ),
            if (_isSelectedRole)
              Column(children: [
                TextFieldInput(
                    textEditingController: _emailOrRollnoController,
                    hintText: _roleController.roleOfUser.value == 'FACULTY'
                        ? 'Enter your email'
                        : 'Enter your roll no.',
                    textInputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 12,
                ),
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: 'Enter your password',
                  textInputType: TextInputType.visiblePassword,
                  isPass: true,
                ),
                const SizedBox(
                  height: 12,
                ),
              ])
            else
              Container(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              // margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.shade300)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    focusColor: Colors.transparent,
                    hint: const Text('  Select your role'),
                    isExpanded: true,
                    // icon: Icon(
                    //   Icons.arrow_drop_down,
                    //   color: Colors.black,
                    // ), it can be used for custom icon
                    value: value,
                    items: roles.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                        _roleController.roleOfUser.value = value!;
                        _isSelectedRole = true;
                      });
                    }),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    logIn();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                  ),
                  child: _isloading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Log in',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: "Don't have an account? ".text.fontFamily(bold).make(),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                InkWell(
                  onTap: () {
                    Get.to(RegistrationScreen(),
                        transition: Transition.rightToLeftWithFade);
                  },
                  child: Container(
                    child: Text(
                      "Register",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
