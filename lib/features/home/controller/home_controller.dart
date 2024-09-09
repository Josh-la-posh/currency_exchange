import 'package:get/get.dart';

import '../../../data/modules/session_manager.dart';
import '../../../utils/socket/socket_helper.dart';

class HomeController extends GetxController {
  var displayBalance = false.obs;
  var isOfferLoading = false.obs;



  @override
  void onInit() {
    _initializeSocket();
    super.onInit();
  }

  Future<void> _initializeSocket() async {
    String? token = await UserSession.instance.getAccessToken();
    if (token != null) {
      SocketManager.shared.initSocket();
    } else {
      print('WHat have I dont to this socket?');
    }
  }

  void clearData() {

  }
}