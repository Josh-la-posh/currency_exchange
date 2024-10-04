import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfigurationModule {
  static final EnvConfigurationModule _instance = EnvConfigurationModule._();

  EnvConfigurationModule._();

  static EnvConfigurationModule get instance => _instance;

  String getEnvType() {
    return dotenv.env['ENV_TYPE'].toString();
  }

  String getApiBaseUrl() {
    return (dotenv.env['API_BASE_URL'] as String);
  }
}
