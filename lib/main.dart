import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/app.dart';
import 'package:flutter_navigator2_sample/di/service_locator.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarIconBrightness: Brightness.light,
  // ));
  await bootstrapServiceLocator();
  runApp(App());
}
