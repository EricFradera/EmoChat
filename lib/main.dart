import 'package:chat_app/theme.dart';
import 'package:chat_app/views/import_views.dart';
import 'package:chat_app/views/login_screen.dart';
import 'package:chat_app/views/test_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  const bool USE_EMULATOR = false; //firebase emulators:start

  if (USE_EMULATOR) {
    // [Firestore | localhost:8080]
    FirebaseFirestore.instance.settings = const Settings(
      host: 'localhost:8080',
      sslEnabled: false,
      persistenceEnabled: false,
    );

    // [Authentication | localhost:9099]
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

    // [Storage | localhost:9199]
    await FirebaseStorage.instance.useStorageEmulator(
      'localhost',
      9199,
    );
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, //turn on for debug flag
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.light,
      title: 'Emotive Chat',
      home: LoginScreen(),
    );
  }
}
