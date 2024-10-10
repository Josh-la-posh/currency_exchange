import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<String> getUserAgent() async {
  // Get app info
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appVersion = packageInfo.version;

  // Get device info
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceData;

  if (GetPlatform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceData = 'Android ${androidInfo.version.release}; ${androidInfo.model}';
  } else if (GetPlatform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceData = 'iOS ${iosInfo.systemVersion}; ${iosInfo.name}';
  } else {
    deviceData = 'Unknown';
  }

  // Construct user agent string
  return 'App/${packageInfo.appName} $appVersion ($deviceData)';
}
