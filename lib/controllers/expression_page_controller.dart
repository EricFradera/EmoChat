import 'dart:ui';

import 'package:chat_app/font_and_emoji_data.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpressionPageController {
  final FontAndEmojiData _data = FontAndEmojiData();
  ExpressionPageController();

  String getEmojis(int index) {
    return _data.allEmojis[index];
  }

  int getLengthEmojis() {
    return _data.allEmojis.length;
  }

  String getFonts(int index) {
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
}
