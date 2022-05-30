import 'dart:ui';

import 'package:chat_app/controllers/expression_theme_controller.dart';
import 'package:chat_app/font_and_emoji_data.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpressionPageController {
  final FontAndEmojiData _data = FontAndEmojiData();

  List<Color> _newColor = [];
  List<String> _newFont = [];
  List<String> _newEmoji = [];
  ExpressionPageController();

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

  void saveData(int emotion) {
    Get.put(ExpressionThemeController())
        .setPrimaryColor(_newColor[emotion], emotion);
  }
}
