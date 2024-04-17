import 'package:attendance_tracker/auth/cache_management.dart';
import 'package:attendance_tracker/controller/user_token_controller.dart';
import 'package:get/get.dart';

class AuthenticationManager extends GetxController with CacheManager {
  final userControllerToken = Get.put(UserControllerToken());
  final isLogged = false.obs;

  void logOut() {
    isLogged.value = false;
    removeToken();
  }

  void login(
      String? token, String name, String emailOrRoll, String role) async {
    isLogged.value = true;
    //Token is cached
    print(token);
    await saveToken(token);
    // username,emailorRoll and role is cached
    await saveUserData(name, emailOrRoll, role);
  }

  void checkLoginStatus() {
    final token = getToken();
    if (token != null && token != '') {
      userControllerToken.tokenuserdata.value.token = token;
      print(token);
      isLogged.value = true;
    }
  }
}
