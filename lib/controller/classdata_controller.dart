import 'package:attendance_tracker/auth/auth_management.dart';
import 'package:attendance_tracker/model/classdata_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CLassDataController extends GetxController {
  final authmanager = Get.put(AuthenticationManager());
  @override
  void onInit() async {
    await getData();
    super.onInit();
  }

  var ClassData = <Classdatamodel>[].obs;
  getData() async {
    String futuredata;
    String token = authmanager.getToken()!;
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://attendance-tracker-backend-3q87.onrender.com/api/class'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      futuredata = await response.stream.bytesToString();
      ClassData.value = classdatamodelFromJson(futuredata);
    } else {
      print(response.reasonPhrase);
    }
  }
}
