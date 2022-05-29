import 'dart:ui';

import 'package:chat_app/models/theme_expression.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

enum ThemeType { Neutral, Happy, Sad, Angry, Disgust, Surprise, Fear }

class Expression_theme_controller extends GetxController {
  final currentMood = ThemeType.Neutral;
  List<Color> primary = const [
    Color.fromARGB(255, 217, 231, 203),
    Color.fromARGB(255, 224, 220, 105),
    Color.fromARGB(255, 204, 205, 229),
    Color.fromARGB(255, 224, 175, 203),
    Color.fromARGB(255, 204, 229, 225),
    Color.fromARGB(255, 226, 199, 150),
    Color.fromARGB(255, 226, 226, 226)
  ];
  List<Color> secondary = const [
    Color.fromARGB(255, 253, 253, 245),
    Color.fromARGB(255, 249, 248, 207),
    Color.fromARGB(255, 245, 245, 252),
    Color.fromARGB(255, 239, 225, 232),
    Color.fromARGB(255, 245, 252, 251),
    Color.fromARGB(255, 247, 233, 205),
    Color.fromARGB(255, 252, 252, 252),
  ];
  List<Color> tertiaryColor = const [
    Color.fromARGB(255, 85, 98, 76),
    Color.fromARGB(255, 94, 91, 34),
    Color.fromARGB(255, 75, 75, 96),
    Color.fromARGB(255, 91, 60, 79),
    Color.fromARGB(255, 75, 96, 96),
    Color.fromARGB(255, 96, 81, 53),
    Color.fromARGB(255, 96, 96, 96),
  ];
  List<Color> textColor = const [
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 0, 0, 0),
  ];
  // NOT NEEDED FOR NOW
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
    textTheme: GoogleFonts.mulishTextTheme()
        .apply(bodyColor: Color.fromARGB(255, 85, 98, 76)),
    backgroundColor: Color.fromARGB(255, 253, 253, 245),
    scaffoldBackgroundColor: Color.fromARGB(255, 253, 253, 245),
    cardColor: Color.fromARGB(255, 253, 253, 245),
    primaryTextTheme: const TextTheme(
      headline6: TextStyle(color: Color.fromARGB(255, 85, 98, 76)),
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
            primary: primary.elementAt(emotion),
            secondary: secondary.elementAt(emotion),
            tertiary: tertiaryColor.elementAt(emotion)),
        //primaryColor: ,
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: secondary.elementAt(emotion)),
            titleTextStyle: TextStyle(color: tertiaryColor.elementAt(emotion))),

        textTheme: GoogleFonts.mulishTextTheme()
            .apply(bodyColor: textColor.elementAt(emotion)),
        backgroundColor: secondary.elementAt(emotion),
        scaffoldBackgroundColor: secondary.elementAt(emotion),
        cardColor: secondary.elementAt(emotion),
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
    return primary[emotion];
  }
}
