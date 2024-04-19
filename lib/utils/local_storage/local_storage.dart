import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._();

  LocalStorage._();

  static LocalStorage get instance => _instance;

  static late SharedPreferences _storageInitializer;

  Future<void> initialize() async {
    _storageInitializer = await SharedPreferences.getInstance();
  }

  SharedPreferences get storage => _storageInitializer;
}
