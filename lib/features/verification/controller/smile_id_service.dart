import 'package:smile_id/smile_id.dart';
import 'package:smile_id/smileid_messages.g.dart';

class SmileIdService {
  static final SmileIdService _instance = SmileIdService._internal();

  factory SmileIdService() {
    return _instance;
  }

  SmileIdService._internal();

  Future<void> initialize() async {
    try {
      SmileID.initialize(
        config: FlutterConfig(
          partnerId: "6951",
          authToken: "KJN217v5KAG6lNRsthGCY0toKbgnyoncCw85m73fztwaCcHIKG0jSCssquLqMMjHGMl5M9bX4K8jX77vPCjcHuE2bDEyLS1MnYG+e+Q69ctWH98zSozgz2EFxpxXVBr59qn2pSWJo27bYf1XaxZgpNUA08b2tjTcWuBv9ES2eR8=",
          prodBaseUrl: "https://api.smileidentity.com/",
          sandboxBaseUrl: "https://testapi.smileidentity.com/",
        ),
        useSandbox: true,
        enableCrashReporting: true,
      );
    } catch (e) {
      print("Error initializing Smile ID: $e");
    }
  }
}
