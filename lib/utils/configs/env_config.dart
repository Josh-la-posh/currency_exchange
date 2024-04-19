import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfigurationModule {
  static final EnvConfigurationModule _instance = EnvConfigurationModule._();

  EnvConfigurationModule._();

  static EnvConfigurationModule get instance => _instance;

  _AndroidFirebaseNotificationEnvModule getAndroidFireBaseConfig() {
    return _AndroidFirebaseNotificationEnvModule(
      apiKey: dotenv.env['ANDROID_FIREBASE_API_KEY'] as String,
      appId: dotenv.env['ANDROID_FIREBASE_API_ID'] as String,
      messagingSenderId:
      dotenv.env['ANDROID_FIREBASE_MESSAGING_SENDER_ID'] as String,
      projectId: dotenv.env['ANDROID_FIREBASE_PROJECT_ID'] as String,
      storageBucket: dotenv.env['ANDROID_FIREBASE_STORAGE_BUCKET'] as String,
    );
  }

  _IOSFirebaseNotificationEnvModule getIOSFireBaseConfig() {
    return _IOSFirebaseNotificationEnvModule(
      apiKey: dotenv.env['IOS_FIREBASE_API_KEY'] as String,
      appId: dotenv.env['IOS_FIREBASE_API_ID'] as String,
      messagingSenderId:
      dotenv.env['IOS_FIREBASE_MESSAGING_SENDER_ID'] as String,
      projectId: dotenv.env['IOS_FIREBASE_PROJECT_ID'] as String,
      storageBucket: dotenv.env['IOS_FIREBASE_STORAGE_BUCKET'] as String,
      iosBundleId: dotenv.env['IOS_FIREBASE_BUNDLE_ID'] as String,
    );
  }

  String getEnvType() {
    return dotenv.env['ENV_TYPE'] as String;
  }

  String getApiBaseUrl() {
    if (getEnvType() == 'PROD') {
      return (dotenv.env['PROD_API_BASE_URL'] as String) + '/api';
    }
    return (dotenv.env['API_BASE_URL'] as String) + '/api';
  }

  String getCustomerSupportEmail() {
    return dotenv.env['CUSTOMER_SUPPORT_EMAIL'] as String;
  }

  String getCustomerSupportPhoneNumber() {
    return dotenv.env['CUSTOMER_SUPPORT_EMAIL'] as String;
  }

  String getGooglePlayStoreUrl() {
    return dotenv.env['GOOGLE_PLAY_STORE_URL'] as String;
  }

  String getSentryDNSUrl() {
    return dotenv.env['SENTRY_DNS_URL'] as String;
  }
}

class _AndroidFirebaseNotificationEnvModule {
  final String apiKey;
  final String appId;
  final String messagingSenderId;
  final String projectId;
  final String storageBucket;

  const _AndroidFirebaseNotificationEnvModule({
    required this.apiKey,
    required this.appId,
    required this.messagingSenderId,
    required this.projectId,
    required this.storageBucket,
  });
}

class _IOSFirebaseNotificationEnvModule {
  final String apiKey;
  final String appId;
  final String messagingSenderId;
  final String projectId;
  final String storageBucket;
  final String iosBundleId;

  const _IOSFirebaseNotificationEnvModule({
    required this.apiKey,
    required this.appId,
    required this.messagingSenderId,
    required this.projectId,
    required this.storageBucket,
    required this.iosBundleId,
  });
}
