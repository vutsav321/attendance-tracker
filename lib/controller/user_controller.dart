import 'package:attendance_tracker/consts.dart';
import 'package:attendance_tracker/model/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  String token;
  UserController({required this.token});
  var userData = User(name: ' ', rollno: ' ', email: ' ', role: ' ').obs;
  @override
  void onInit() async {
    await getData();
    super.onInit();
  }

  getData() async {
    String futuredata;
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET', Uri.parse('$apiLink/user'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      futuredata = await response.stream.bytesToString();
      userData.value = userModelFromJson(futuredata).user;
      print(futuredata);
    } else {
      print(response.reasonPhrase);
    }
  }
}
