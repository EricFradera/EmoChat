import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpressionTheme {
  List<Color> primary = [
    Color.fromRGBO(217, 231, 203, 1),
    Color.fromARGB(255, 224, 220, 105),
    Color.fromARGB(255, 204, 205, 229),
    Color.fromARGB(255, 224, 175, 203),
    Color.fromARGB(255, 204, 229, 225),
    Color.fromARGB(255, 226, 199, 150),
    Color.fromARGB(255, 226, 226, 226)
  ];
  List<Color> secondary = [
    Color.fromARGB(255, 253, 253, 245),
    Color.fromARGB(255, 249, 248, 207),
    Color.fromARGB(255, 245, 245, 252),
    Color.fromARGB(255, 239, 225, 232),
    Color.fromARGB(255, 245, 252, 251),
    Color.fromARGB(255, 247, 233, 205),
    Color.fromARGB(255, 252, 252, 252),
  ];
  List<Color> tertiaryColor = [
    Color.fromARGB(255, 85, 98, 76),
    Color.fromARGB(255, 94, 91, 34),
    Color.fromARGB(255, 75, 75, 96),
    Color.fromARGB(255, 91, 60, 79),
    Color.fromARGB(255, 75, 96, 96),
    Color.fromARGB(255, 96, 81, 53),
    Color.fromARGB(255, 96, 96, 96),
  ];

  List<Color> textColor = [
    Color.fromARGB(255, 47, 75, 30),
    Color.fromARGB(255, 93, 93, 27),
    Color.fromARGB(255, 34, 34, 97),
    Color.fromARGB(255, 69, 23, 55),
    Color.fromARGB(255, 30, 69, 69),
    Color.fromARGB(255, 84, 67, 20),
    Color.fromARGB(255, 55, 55, 55),
  ];
  List<String> emojiExpression = ["🙂", "😄", "😔", "😠", "🤢", "😮", "😨"];

  List<String> textFont = [
    "Roboto",
    "Lobster Two",
    "Shadows Into Light",
    "Teko",
    "Annie Use Your Telescope",
    "Staatliches",
    "Odibee Sans"
  ];
  List<bool> isItalic = [false, true, false, true, false, true, true];
  List<bool> isBold = [false, false, true, false, true, false, false];

  ExpressionTheme();

  final currentTheme = (ThemeData(
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

  Map<String, dynamic> toJson(int emotion, String uid) => {
        'uid': uid,
        'emotion': emotion,
        'primary': primary[emotion].value,
        'secondary': secondary[emotion].value,
        'tertiaryColor': tertiaryColor[emotion].value,
        'textColor': textColor[emotion].value,
        'emojiExpression': emojiExpression[emotion],
        'textFont': textFont[emotion],
        'isItalic': isItalic[emotion],
        'isBold': isBold[emotion]
      };

  ExpressionTheme.fromJson(Map<String, dynamic> json) {
    final emotion = json['emotion'];
    primary[emotion] = Color(json['primary']);
    secondary[emotion] = Color(json['secondary']);
    tertiaryColor[emotion] = Color(json['tertiaryColor']);
    textColor[emotion] = Color(json['textColor']);
    emojiExpression[emotion] = json['emojiExpression'];
    textFont[emotion] = json['textFont'];
    isItalic[emotion] = json['isItalic'];
    isBold[emotion] = json['isBold'];
  }
}
