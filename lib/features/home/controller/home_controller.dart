import 'package:get/get.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';
import 'package:pouch/features/negotiation_offer/controller/negotiation_offer_controller.dart';
import '../../../data/firebase/firebase_api.dart';
import '../../../utils/helpers/controller/helper_function_controller.dart';
import '../../../utils/socket/socket_helper.dart';
import '../../all_offer/controllers/offer_controller.dart';
import '../../notification/controller/notification_controller.dart';
import '../../wallet/controller/wallet_controller.dart';

class HomeController extends GetxController {
  final UserSessionController userSessionController = Get.find();
  final Rx<int> selectedIndex = 0.obs;

  @override
  void onReady() {
    super.onReady();
    userSessionController.getIsVerified();
  }

  @override
  void onInit() {
    _initializeSocket();
    super.onInit();
  }

  Future<void> _initializeSocket() async {
    String? token = await userSessionController.getAccessToken();
    // await FirebaseApi().initPushNotifications();
    if (token != null) {
      SocketManager.shared.initSocket();
    } else {
      print('WHat have I don\'t to this socket?');
    }
  }

  void navigateToIndex(int index) {
    selectedIndex.value = index;
  }

  void clearData() {
  }
}