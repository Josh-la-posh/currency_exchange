import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pouch/utils/local_storage/local_storage.dart';
import 'package:pouch/utils/socket/my_http_override.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverride();
  await LocalStorage.instance.initialize();
  await dotenv.load();
  runApp(const MyApp());
}
