import 'package:chat_app/controllers/user_controller.dart';
import 'package:chat_app/models/expression_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

enum ThemeType { neutral, happy, sad, angry, disgust, surprise, fear }

class ExpressionThemeController extends GetxController {
  // THEME DATA /////////////////////////////////////////
  var currentMood = ThemeType.neutral;
  final ExpressionTheme _theme = ExpressionTheme();
  late Rx<ThemeData> current = (ThemeData()).obs;
  ///////////////////////////////////////////////////////

  ExpressionThemeController() {
    current = _theme.currentTheme;
  }

  void changeTheme(int emotion) {
    currentMood = ThemeType.values[emotion];
    updateTheme(emotion);
  }

  void updateTheme(int emotion) {
    if (currentMood.index == emotion) {
      current.value = buildTheme(emotion);
    }
    update();
  }

  ThemeData buildTheme(int emotion) {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: _theme.primary[emotion],
          secondary: _theme.secondary[emotion],
          tertiary: _theme.tertiaryColor[emotion]),
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: _theme.secondary[emotion]),
          titleTextStyle: TextStyle(color: _theme.tertiaryColor[emotion])),
      textTheme: GoogleFonts.mulishTextTheme()
          .apply(bodyColor: _theme.textColor[emotion]),
      backgroundColor: _theme.secondary[emotion],
      scaffoldBackgroundColor: _theme.secondary[emotion],
      cardColor: _theme.secondary[emotion],
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

// GETTERS AND SETTERS
  Color getPrimaryColor([int? emotion]) {
    if (emotion == null) {
      return _theme.primary[currentMood.index];
    }
    return _theme.primary[emotion];
  }

  Color getSecondaryColor([int? emotion]) {
    if (emotion == null) {
      return _theme.secondary[currentMood.index];
    }
    return _theme.secondary[emotion];
  }

  Color getTertiaryColor([int? emotion]) {
    if (emotion == null) {
      return _theme.tertiaryColor[currentMood.index];
    }
    return _theme.tertiaryColor[emotion];
  }

  Color getTextColor([int? emotion]) {
    if (emotion == null) {
      return _theme.textColor[currentMood.index];
    }
    return _theme.textColor[emotion];
  }

  String getEmoji([int? emotion]) {
    if (emotion == null) {
      return _theme.emojiExpression[currentMood.index];
    }
    return _theme.emojiExpression[emotion];
  }

  bool getBold([int? emotion]) {
    if (emotion == null) {
      return _theme.isBold[currentMood.index];
    }
    return _theme.isBold[emotion];
  }

  bool getItalic([int? emotion]) {
    if (emotion == null) {
      return _theme.isItalic[currentMood.index];
    }
    return _theme.isItalic[emotion];
  }

  TextStyle getTextStyle([int? emotion]) {
    if (emotion == null) {
      return const TextStyle();
    }
    return GoogleFonts.getFont(_theme.textFont[emotion],
        fontWeight:
            (_theme.isBold[emotion] ? FontWeight.bold : FontWeight.normal),
        fontStyle:
            (_theme.isItalic[emotion] ? FontStyle.italic : FontStyle.normal),
        fontSize: 18);
  }

  void setPrimaryColor(Color newColor, int emotion) {
    _theme.primary[emotion] = newColor;
    update();
    updateTheme(emotion);
  }

  void setFont(String newFont, int emotion) {
    _theme.textFont[emotion] = newFont;
    update();
    updateTheme(emotion);
  }

  void setSecondaryColor(Color newColor, int emotion) {
    _theme.secondary[emotion] = newColor;
  }

  void setTertiaryColor(Color newColor, int emotion) {
    _theme.tertiaryColor[emotion] = newColor;
  }

  void setTextColor(Color newColor, int emotion) {
    _theme.textColor[emotion] = newColor;
  }

  void setEmoji(String newEmoji, int emotion) {
    _theme.emojiExpression[emotion] = newEmoji;
    update();
    updateTheme(emotion);
  }

  void setBold(bool isBold, int emotion) {
    _theme.isBold[emotion] = isBold;
  }

  void setItalic(bool isItalic, int emotion) {
    _theme.isItalic[emotion] = isItalic;
  }

  String getFontName(int emotion) {
    return _theme.textFont[emotion];
  }

  Map<String, dynamic> getJson(int emotion, String uid) {
    return _theme.toJson(emotion, uid);
  }

  void setJson(int emotion, Map<String, dynamic> json) {
    _theme.fromJson(json);
  }

  String getEmotion() {
    switch (currentMood.index) {
      case 0:
        return "Neutral";
      case 1:
        return "happy";
      case 2:
        return "sad";
      case 3:
        return "angry";
      case 4:
        return "disgust";
      case 5:
        return "surprise";
      case 6:
        return "fear";
      default:
        return "not defined";
    }
  }
}
