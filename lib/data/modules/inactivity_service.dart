import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';

class InactivityService extends GetxService with WidgetsBindingObserver {
  Timer? _timer;
final UserSessionController userSessionController = Get.find();

  // Timeout duration for inactivity (e.g., 5 minutes)
  final Duration timeoutDuration = Duration(minutes: 5);

  // Singleton instance
  static InactivityService get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    startMonitoring();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    stopMonitoring();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _resetTimer(); // Resume monitoring on app foreground
    } else if (state == AppLifecycleState.paused) {
      _timer?.cancel(); // Stop timer when app is in the background
    }
  }

  void startMonitoring() {
    _resetTimer();
    print("Inactivity monitoring started.");
  }

  void stopMonitoring() {
    _timer?.cancel();
    print("Inactivity monitoring stopped.");
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer(timeoutDuration, _logOutIfInactive);
    print("Inactivity timer reset.");
  }

  void _logOutIfInactive() {
    print("User inactive. Logging out...");
    stopMonitoring();
    userSessionController.logoutUser();
  }

  // Public method to reset the timer (called on user interaction)
  void resetTimer() {
    print('I don reset');
    _resetTimer();
  }
}