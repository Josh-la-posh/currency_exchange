import 'package:get/get.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';
import '../../../utils/helpers/controller/helper_function_controller.dart';
import '../../../utils/socket/socket_helper.dart';
import '../../all_offer/controllers/offer_controller.dart';
import '../../authentication/controllers/auth_controller.dart';
import '../../notification/controller/notification_controller.dart';
import '../../wallet/controller/wallet_controller.dart';

class HomeController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final offerController = Get.put(OfferController());
  final notificationController = Get.put(NotificationController());
  final walletController = Get.put(WalletController());
  final helperFunctionsController = Get.find<HelperFunctionsController>();
  final userSessionController = Get.find<UserSessionController>();
  var displayBalance = false.obs;
  var isOfferLoading = false.obs;
  var isMyBidLoading = false.obs;
  var isMyOfferLoading = false.obs;


  @override
  void onReady() {
    super.onReady();
    authController.getIsVerified();
  }

  @override
  void onInit() {
    _initializeSocket();
    offerController.fetchAllOffers();
    offerController.fetchMyBids(days: '', currency: '');
    offerController.fetchMyOffers(days: '', currency: '');
    super.onInit();
  }

  Future<void> _initializeSocket() async {
    String? token = await userSessionController.getAccessToken();
    if (token != null) {
      SocketManager.shared.initSocket();
    } else {
      print('WHat have I dont to this socket?');
    }
  }

  void clearData() {

  }
}