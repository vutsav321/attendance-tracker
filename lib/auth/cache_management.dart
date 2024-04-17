import 'package:attendance_tracker/controller/role_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  Future<bool> saveUserData(
      String? name, String? emailOrRoll, String? role) async {
    final namebox = GetStorage();
    final emailOrRollbox = GetStorage();
    final rolebox = GetStorage();

    await namebox.write(CacheManagerKey.Name.toString(), name);
    await emailOrRollbox.write(
        CacheManagerKey.EmailOrRoll.toString(), emailOrRoll);
    await rolebox.write(CacheManagerKey.Role.toString(), role);
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  String? getusername() {
    final namebox = GetStorage();
    return namebox.read(CacheManagerKey.Name.toString());
  }

  String? getemaiOrRoll() {
    final emailOrRollbox = GetStorage();
    return emailOrRollbox.read(CacheManagerKey.EmailOrRoll.toString());
  }

  String? getrole() {
    final rolebox = GetStorage();
    final RoleController roleController = Get.put(RoleController());
    roleController.roleOfUser.value =
        rolebox.read(CacheManagerKey.Role.toString());
    return roleController.roleOfUser.value;
  } //role controller se bhi kuch dena h

  Future<void> removeToken() async {
    final box = GetStorage();
    final namebox = GetStorage();
    final emailOrRollbox = GetStorage();
    final rolebox = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
    await namebox.remove(CacheManagerKey.Name.toString());
    await emailOrRollbox.remove(CacheManagerKey.EmailOrRoll.toString());
    await rolebox.remove(CacheManagerKey.Role.toString());
  }
}

enum CacheManagerKey { TOKEN, Name, EmailOrRoll, Role }
