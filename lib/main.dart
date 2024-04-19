import 'package:flutter/material.dart';
import 'package:swappr/utils/local_storage/local_storage.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.instance.initialize();
  runApp(const MyApp());
}

