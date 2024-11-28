import 'package:get/get.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';

class SecurityController extends GetxController {
final UserSessionController userSessionController = Get.find();
  var useBiometric = false.obs;

  @override
  void onInit() {
    getBiometricValue();
    super.onInit();
  }

  void getBiometricValue() async {
    useBiometric.value = (await userSessionController.getUserBiometrics())!;
  }
}