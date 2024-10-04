import 'package:permission_handler/permission_handler.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pouch/features/verification/controller/smile_id_service.dart';

class VerificationController extends GetxController {
  var isFetchingSmileId = false.obs;
  var shouldSkipDisplay = false.obs;
  var canSkip = false.obs;
  var isPermissionGranted = false.obs;
  var selectedCountry = Rx<Country?>(null);
  var idTypes = [].obs;
  var showErrorText = false.obs;
  var bvnFocusNode = FocusNode();
  var bvnNumber = ''.obs;

  final SmileIdService _smileIdService = SmileIdService();

  @override
  void onInit() {
    initializeSmileId();
    checkPermission();
    super.onInit();
  }

  @override
  void onClose() {
    bvnFocusNode.dispose();
    super.onClose();
  }

  Future<void> initializeSmileId() async {
    await _smileIdService.initialize();
  }

  Future<void> requestPermissions() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }

    var locationStatus = await Permission.location.status;
    if (!locationStatus.isGranted) {
      await Permission.location.request();
    }
  }

  Future<void> checkPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      isPermissionGranted.value = true;
    } else if (status.isDenied || status.isPermanentlyDenied) {
      // Request permission
      PermissionStatus newStatus = await Permission.camera.request();
      if (newStatus.isGranted) {
        isPermissionGranted.value = true;
      }
    }
  }

  void setSelectedCountry(Country country) {
    selectedCountry.value = country;
  }

  Future<void> fetchSmileData() async {
    final Dio _dio = Dio();
    const String url = 'https://api.smileidentity.com/v1/valid_documents';
    try {
      isFetchingSmileId(true);
      final response = await _dio.get('$url?country_code=${selectedCountry.value?.countryCode}');
      final data = response.data['valid_documents'][0]['id_types'];
      idTypes.assignAll(data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
      } else {
        print('Error: ${e.message}');
      }
    } catch (e) {
      print('Unexpected error: $e');
    } finally {
      isFetchingSmileId(false);
    }
  }

  void validateBvnNumber() {
    if (bvnNumber.value.isEmpty || bvnNumber.value.length < 5) {
      showErrorText.value = true;
    } else {
      showErrorText.value = false;
    }
  }

  void clearData() {
    canSkip.value = false;
    selectedCountry.value = null;
    shouldSkipDisplay.value = false;
    idTypes.clear();
    bvnNumber.value = '';
    showErrorText.value = false;
  }
}