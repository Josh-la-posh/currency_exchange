import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pouch/data/modules/storage_session_controller.dart';
import 'package:pouch/utils/local_storage/local_storage.dart';
import 'package:pouch/utils/socket/my_http_override.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'features/authentication/controllers/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverride();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalStorage.instance.initialize();
  await dotenv.load();
  Get.put(AuthController(), permanent: true);
  Get.put(UserSessionController(), permanent: true);
  runApp(const MyApp());
}
