import 'dart:ui';

import 'package:chat_app/controllers/expression_theme_controller.dart';
import 'package:chat_app/controllers/user_controller.dart';
import 'package:chat_app/font_and_emoji_data.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpressionPageController {
  final FontAndEmojiData _data = FontAndEmojiData();
  final List<Color> _newColor = [];
  final List<String> _newFont = [];
  final List<String> _newEmoji = [];
  final List<bool> _newBold = [];
  final List<bool> _newItalic = [];

  List<String> testFont = [];
  List<String> testEmoji = [];
  List<bool> testBold = [];
  List<bool> testItalic = [];
  List<Color> testColor = [];
  ExpressionPageController() {
    for (int i = 0; i < 7; i++) {
      _newColor.add(Get.put(ExpressionThemeController()).getPrimaryColor(i));
      _newFont.add(Get.put(ExpressionThemeController()).getFontName(i));
      _newEmoji.add(Get.put(ExpressionThemeController()).getEmoji(i));
      _newBold.add(Get.put(ExpressionThemeController()).getBold(i));
      _newItalic.add(Get.put(ExpressionThemeController()).getItalic(i));
    }
    testFont = _newFont;
    testEmoji = _newEmoji;
    testBold = _newBold;
    testItalic = _newItalic;
    testColor = _newColor;
  }

  String getEmojis(int index) {
    return _data.allEmojis[index];
  }

  int getLengthEmojis() {
    return _data.allEmojis.length;
  }

  String getFonts(int index) {
    try {
      GoogleFonts.getFont(_data.allFonts[index]);
    } catch (e) {
      return "Roboto";
    }
    return _data.allFonts[index];
  }

  Color getColor(int index) {
    return _data.allColors[index];
  }

  int getLengthColors() {
    return _data.allColors.length;
  }

  int getLengthFonts() {
    return _data.allFonts.length;
  }

  TextStyle getFont(int index) {
    try {
      return GoogleFonts.getFont(_data.allFonts[index], fontSize: 20);
    } catch (e) {}
    return const TextStyle();
  }

  void setNewColor(int emotion, int colorIndex) {
    _newColor[emotion] = _data.allColors[colorIndex];
  }

  void setNewFont(int emotion, int index) {
    _newFont[emotion] = _data.allFonts[index];
  }

  void setNewEmoji(int emotion, int index) {
    _newEmoji[emotion] = _data.allEmojis[index];
  }

  Future<void> saveData(int emotion) async {
    Get.put(ExpressionThemeController())
        .setPrimaryColor(_newColor[emotion], emotion);
    Get.put(ExpressionThemeController()).setEmoji(_newEmoji[emotion], emotion);
    Get.put(ExpressionThemeController()).setFont(_newFont[emotion], emotion);
    Get.put(ExpressionThemeController()).setBold(_newBold[emotion], emotion);
    Get.put(ExpressionThemeController())
        .setItalic(_newItalic[emotion], emotion);
    await Get.put(UserController()).updateTheme(emotion);
  }

  void setBold(int emotion) {
    _newBold[emotion] = !_newBold[emotion];
  }

  bool getBold(int emotion) {
    return _newBold[emotion];
  }

  bool getItalic(int emotion) {
    return _newItalic[emotion];
  }

  void setItalic(int emotion) {
    _newItalic[emotion] = !_newItalic[emotion];
  }
}
