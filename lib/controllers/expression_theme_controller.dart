import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

enum ThemeType { neutral, happy, sad, angry, disgust, surprise, fear }

class ExpressionThemeController extends GetxController {
  final currentMood = ThemeType.neutral;
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

  final visualDensity = VisualDensity.adaptivePlatformDensity;
  var current = (ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.mulishTextTheme()
        .apply(bodyColor: const Color.fromARGB(255, 85, 98, 76)),
    backgroundColor: const Color.fromARGB(255, 253, 253, 245),
    scaffoldBackgroundColor: const Color.fromARGB(255, 253, 253, 245),
    cardColor: const Color.fromARGB(255, 253, 253, 245),
    primaryTextTheme: const TextTheme(
      headline6: TextStyle(color: Color.fromARGB(255, 85, 98, 76)),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  )).obs;

  void changeTheme(int emotion, bool light) {
    current.value = buildTheme(emotion);
    update();
  }

  ThemeData buildTheme(int emotion) {
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
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  Color getEmotionColor(int emotion) {
    return primary[emotion];
  }
}
