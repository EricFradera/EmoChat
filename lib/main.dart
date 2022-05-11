import 'package:chat_app/theme.dart';
import 'package:chat_app/views/import_views.dart';
import 'package:chat_app/views/test_screen.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //turn on for debug flag
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.light,
      title: 'Emotive Chat',
      home: HomeScreen(),
    );
  }
}
