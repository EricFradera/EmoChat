import 'dart:ui';

import 'package:chat_app/models/theme_expression.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

enum ThemeType { Neutral, Happy, Sad, Angry, Disgust, Surprise, Fear }

class Expression_theme_controller extends GetxController {
  final currentMood = ThemeType.Neutral;
  List<Color> secondary = const [
    Color.fromARGB(255, 59, 118, 246),
    Color.fromARGB(255, 239, 20, 210),
    Color.fromARGB(255, 63, 157, 0),
    Color.fromARGB(255, 77, 77, 0),
    Color.fromARGB(255, 93, 53, 0),
    Color.fromARGB(255, 21, 32, 0),
    Color.fromARGB(255, 100, 162, 0)
  ];
  List<Color> accent = [Color(0xFFD6755B)];
  List<Color> textDark = [Color(0xFF53585A)];
  List<Color> textLigth = [Color(0xFFF5F5F5)];
  List<Color> textFaded = [Color(0xFF9899A5)];
  List<Color> iconLight = [Color(0xFFB1B4C0)];
  List<Color> iconDark = [Color(0xFFB1B3C1)];
  List<Color> textHighlight = [Color(0xFF3B76F6)];
  List<Color> cardLight = [Color(0xFFF9FAFE)];
  List<Color> cardDark = [Color(0xFF303334)];
  final visualDensity = VisualDensity.adaptivePlatformDensity;
  var current = (ThemeData(
    brightness: Brightness.light,
    //accentColor: accent[0],
    //visualDensity: visualDensity,
    textTheme:
        GoogleFonts.mulishTextTheme().apply(bodyColor: AppColors.textDark),
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    cardColor: AppColors.cardLight,
    primaryTextTheme: const TextTheme(
      headline6: TextStyle(color: AppColors.textDark),
    ),
    iconTheme: const IconThemeData(color: AppColors.iconDark),
  )).obs;

  void changeTheme(int emotion, bool light) {
    current.value = buildTheme(emotion, light);
    update();
  }

  ThemeData buildTheme(int emotion, bool light) {
    if (light) {
      return ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: secondary.elementAt(emotion),
        ),
        //visualDensity: visualDensity,
        textTheme:
            GoogleFonts.mulishTextTheme().apply(bodyColor: AppColors.textDark),
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        cardColor: AppColors.cardLight,
        primaryTextTheme: const TextTheme(
          headline6: TextStyle(color: AppColors.textDark),
        ),
        iconTheme: const IconThemeData(color: AppColors.iconDark),
      );
    } else {
      return ThemeData(
        brightness: Brightness.light,
        //accentColor: accent[0],
        //visualDensity: visualDensity,
        textTheme:
            GoogleFonts.mulishTextTheme().apply(bodyColor: AppColors.textDark),
        backgroundColor: Color(0xFF1B1E1F),
        scaffoldBackgroundColor: Color(0xFF1B1E1F),
        cardColor: AppColors.cardDark,
        primaryTextTheme: const TextTheme(
          headline6: TextStyle(color: AppColors.textDark),
        ),
        iconTheme: const IconThemeData(color: AppColors.iconDark),
      );
    }
  }

  Color getEmotionColor(int emotion) {
    return secondary[emotion];
  }
}
