import 'package:flutter/foundation.dart';

class VerificationProvider extends ChangeNotifier {
  bool showVerifyModal = true;

  void setShowIsVerifyModal(bool val) {
    showVerifyModal = val;
    notifyListeners();
  }

  resetState() {
    showVerifyModal = true;
  }
}