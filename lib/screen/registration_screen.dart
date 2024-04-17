import 'package:attendance_tracker/auth/auth_method.dart';
import 'package:attendance_tracker/consts.dart';
import 'package:attendance_tracker/controller/role_controller.dart';
import 'package:attendance_tracker/screen/home_screen.dart';
import 'package:attendance_tracker/screen/login_screen.dart';
import 'package:attendance_tracker/widget/textfiels_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailControllerOrRollController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _semController = TextEditingController();
  final RoleController roleController = Get.put(RoleController());
  String? value;
  bool _isloading = false;
  bool _isSelectedRole = false;

  @override
  void dispose() {
    _emailControllerOrRollController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _branchController.dispose();
    _semController.dispose();
    super.dispose();
  }

  void register() async {
    setState(() {
      _isloading = true;
    });
    String res = "success";
    res = await AuthMethod().registerUser(
        name: _nameController.text,
        password: _passwordController.text,
        emailOrRoll: _emailControllerOrRollController.text);

    setState(() {
      _isloading = false;
    });
    if (res == 'success') {
      Get.snackbar('YAY', 'You have successfully Register');
      Get.off(HomeScreen());
    } else {
      Get.snackbar('SORRY', res);
    }
  }

  DropdownMenuItem<String> buildMenuItem(String roles) => DropdownMenuItem(
        value: roles,
        child: Text(
          roles.capitalizeFirst!,
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
          children: [
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
            Flexible(
              child: Container(),
              flex: 1,
            ),
            const Text(
              'Register to $appname',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            Flexible(
              child: Container(),
              flex: 1,
            ),
            if (_isSelectedRole)
              Column(children: [
                TextFieldInput(
                    textEditingController: _nameController,
                    hintText: 'Enter your name',
                    textInputType: TextInputType.name),
                8.heightBox,
                TextFieldInput(
                    textEditingController: _emailControllerOrRollController,
                    hintText: roleController.roleOfUser.value == 'STUDENT'
                        ? "Enter your Roll no."
                        : 'Enter your email',
                    textInputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 8,
                ),
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: 'Enter your password',
                  textInputType: TextInputType.visiblePassword,
                  isPass: true,
                ),
                if (roleController.roleOfUser.value == 'STUDENT')
                  Column(
                    children: [
                      8.heightBox,
                      TextFieldInput(
                          textEditingController: _branchController,
                          hintText: 'Enter your branch',
                          textInputType: TextInputType.name),
                      8.heightBox,
                      TextFieldInput(
                          textEditingController: _semController,
                          hintText: 'Enter your sem',
                          textInputType: TextInputType.number),
                      8.heightBox
                    ],
                  )
                else
                  8.heightBox,
              ])
            else
              10.heightBox,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                        roleController.roleOfUser.value = value!;
                        // print(roleController.roleOfUser.value);
                        _isSelectedRole = true;
                      });
                    }),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    register();
                    // api();
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
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 8,
            // ),
            // Flexible(
            //   flex: 1,
            //   child: Container(),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child:
                      "Already have an account? ".text.fontFamily(bold).make(),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                InkWell(
                  onTap: () {
                    Get.to(LoginScreen(),
                        transition: Transition.leftToRightWithFade);
                  },
                  child: Container(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                )
              ],
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
