import 'dart:ui';

import 'package:chat_app/controllers/expression_theme_controller.dart';
import 'package:chat_app/controllers/user_controller.dart';
import 'package:chat_app/font_and_emoji_data.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpressionPageController {
  final FontAndEmojiData _data = FontAndEmojiData();
  final List<Color> newColorP = [];
  final List<Color> newColorS = [];
  final List<Color> newColorT = [];
  final List<Color> newTextColor = [];
  final List<String> newFont = [];
  final List<String> newEmoji = [];
  final List<bool> newBold = [];
  final List<bool> newItalic = [];

  ExpressionPageController() {
    for (int i = 0; i < 7; i++) {
      newColorP.add(Get.put(ExpressionThemeController()).getPrimaryColor(i));
      newColorS.add(Get.put(ExpressionThemeController()).getSecondaryColor(i));
      newColorT.add(Get.put(ExpressionThemeController()).getTertiaryColor(i));
      newTextColor.add(Get.put(ExpressionThemeController()).getTextColor(i));

      newFont.add(Get.put(ExpressionThemeController()).getFontName(i));
      newEmoji.add(Get.put(ExpressionThemeController()).getEmoji(i));
      newBold.add(Get.put(ExpressionThemeController()).getBold(i));
      newItalic.add(Get.put(ExpressionThemeController()).getItalic(i));
    }
  }
  String getEmojis(int index) {
    return _data.allEmojis[index];
  }

  int getLengthEmojis() {
    return _data.allEmojis.length;
  }

  Color getColorP(int index) {
    return _data.allPrimary[index];
  }

  Color getColorS(int index) {
    return _data.allSecondary[index];
  }

  Color getColorT(int index) {
    return _data.allTertiaryColor[index];
  }

  String getStringFont(int index) {
    try {
      GoogleFonts.getFont(_data.allFonts[index]);
    } catch (e) {
      return "Roboto";
    }
    return _data.allFonts[index];
  }

  TextStyle getStyleFonts(int index) {
    try {
      return GoogleFonts.getFont(_data.allFonts[index], fontSize: 20);
    } catch (e) {}
    return const TextStyle();
  }

  int getLengthColors() {
    return _data.allPrimary.length;
  }

  int getLengthFonts() {
    return _data.allFonts.length;
  }

  void setNewColor(int emotion, int colorIndex) {
    newColorP[emotion] = _data.allPrimary[colorIndex];
    newColorS[emotion] = _data.allSecondary[colorIndex];
    newColorT[emotion] = _data.allTertiaryColor[colorIndex];
    newTextColor[emotion] = _data.allTextColor[colorIndex];
  }

  void setNewFont(int emotion, int index) {
    newFont[emotion] = _data.allFonts[index];
  }

  void setNewEmoji(int emotion, int index) {
    newEmoji[emotion] = _data.allEmojis[index];
  }

  Future<void> saveData(int emotion) async {
    Get.put(ExpressionThemeController())
        .setPrimaryColor(newColorP[emotion], emotion);
    Get.put(ExpressionThemeController())
        .setSecondaryColor(newColorS[emotion], emotion);
    Get.put(ExpressionThemeController())
        .setTertiaryColor(newColorT[emotion], emotion);
    Get.put(ExpressionThemeController())
        .setTextColor(newTextColor[emotion], emotion);
    Get.put(ExpressionThemeController()).setEmoji(newEmoji[emotion], emotion);
    Get.put(ExpressionThemeController()).setFont(newFont[emotion], emotion);
    Get.put(ExpressionThemeController()).setBold(newBold[emotion], emotion);
    Get.put(ExpressionThemeController()).setItalic(newItalic[emotion], emotion);
    await Get.put(UserController()).updateTheme(emotion);
  }

  void setBold(int emotion) {
    newBold[emotion] = !newBold[emotion];
  }

  void setItalic(int emotion) {
    newItalic[emotion] = !newItalic[emotion];
  }
}
