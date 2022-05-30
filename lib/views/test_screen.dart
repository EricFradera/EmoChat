import 'package:flutter/material.dart';

import '../font_and_emoji_data.dart';

class TestScreen extends StatelessWidget {
  TestScreen({Key? key}) : super(key: key);

  FontAndEmojiData data = FontAndEmojiData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Test screen")), body: getEmoji());
  }

  Widget getEmoji() {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
        itemCount: data.allEmojis.length,
        itemBuilder: (BuildContext context, index) {
          return InkWell(
            onTap: (() => print(data.allEmojis[index])),
            child: Center(
              child: Text(
                data.allEmojis[index],
                style: const TextStyle(fontSize: 20),
              ),
            ),
          );
        });
  }
/*
  Widget getFont() {
    return ListView.builder(
        itemCount: data.fonts.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (() => print(data.fonts[index])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  data.fonts[index],
                  style: const TextStyle(fontSize: 20),
                ),
                Text("Texto de ejemplo", style: getFontDef(index)),
                const Divider()
              ],
            ),
          );
        });
  }

  TextStyle getFontDef(int index) {
    try {
      return GoogleFonts.getFont(data.fonts[index], fontSize: 20);
    } catch (e) {
      print("thisNotExist " + data.fonts[index]);
    }
    return TextStyle();
  }*/
}
