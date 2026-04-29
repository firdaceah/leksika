import 'package:flutter/material.dart';
import 'package:leksika/app.dart';
import 'package:leksika/core/di/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const LeksikaApp());
}