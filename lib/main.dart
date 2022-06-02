import 'package:chat_app/controllers/expression_theme_controller.dart';

import 'package:chat_app/views/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false, //turn on for debug flag
          theme: Get.put(ExpressionThemeController()).current.value,
          title: 'Emotive Chat',
          home: const LoginScreen(),
        ));
  }
}
