import 'package:chat_app/controllers/expression_page_controller.dart';
import 'package:chat_app/controllers/expression_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpressionPage extends StatelessWidget {
  const ExpressionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ExpressiveSelector(),
    );
  }
}

class Item {
  Item(
      {required this.headerName,
      this.isExpanded = false,
      required this.emotion});
  String headerName;
  bool isExpanded;
  int emotion;
}

List<Item> generateItems() {
  List<Item> emotionSelectors = [
    Item(headerName: "Neutral expression", emotion: 0),
    Item(headerName: "Happiness expression", emotion: 1),
    Item(headerName: "Sadness expression", emotion: 2),
    Item(headerName: "Anger expression", emotion: 3),
    Item(headerName: "Disgust expression", emotion: 4),
    Item(headerName: "Surprise expression", emotion: 5),
    Item(headerName: "Fear expression", emotion: 6),
  ];
  return emotionSelectors;
}

class ExpressiveSelector extends StatefulWidget {
  const ExpressiveSelector({Key? key}) : super(key: key);

  @override
  State<ExpressiveSelector> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ExpressiveSelector> {
  final List<Item> _data = generateItems();
  ExpressionPageController pageController = ExpressionPageController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                item.headerName + " " + pageController.newEmoji[item.emotion],
                style: const TextStyle(fontSize: 18),
              ), //Feeling name
            );
          },
          body: ListTile(
            subtitle: SizedBox(
              width: double.infinity,
              child: expressionSelector(item.emotion),
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  Widget expressionSelector(int emotion) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.topRight,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Get.put(ExpressionThemeController())
                        .getPrimaryColor(emotion)),
                onPressed: () => pageController.saveData(emotion),
                child: Text("Save preferences",
                    style: TextStyle(
                        color: Get.put(ExpressionThemeController())
                            .getTextColor(emotion))))),
        const Text(
          "Color Selection",
          style: TextStyle(fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 12),
          child: Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: 3,
                        color: Theme.of(context).colorScheme.tertiary)
                  ]),
              child: colorSelection(emotion)),
        ),
        const Text(
          "Text Preview",
          style: TextStyle(fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 12),
          child: Container(
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  color: pageController.newColorP[emotion],
                  borderRadius: BorderRadius.circular(12)),
              child: textPreview(emotion)),
        ),
        const Text(
          "Font Selector",
          style: TextStyle(fontSize: 16),
        ),
        fontWeight(emotion),
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 12),
          child: Container(
              alignment: Alignment.topLeft,
              height: 300,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: 3,
                        color: Theme.of(context).colorScheme.tertiary)
                  ]),
              child: fontSelector(emotion)),
        ),
        const Text(
          "Emoji Selector",
          style: TextStyle(fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 12),
          child: Container(
              alignment: Alignment.topLeft,
              height: 300,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: 3,
                        color: Theme.of(context).colorScheme.tertiary)
                  ]),
              child: emojiSelector(emotion)),
        )
      ],
    );
  }

  Row fontWeight(int emotion) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            alignment: Alignment.topRight,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Get.put(ExpressionThemeController())
                        .getPrimaryColor(emotion)),
                onPressed: () {
                  setState(() {
                    pageController.setBold(emotion);
                  });
                },
                child: Text("Bold",
                    style: TextStyle(
                        color: Get.put(ExpressionThemeController())
                            .getTextColor(emotion))))),
        Container(
            alignment: Alignment.topRight,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Get.put(ExpressionThemeController())
                        .getPrimaryColor(emotion)),
                onPressed: () {
                  setState(() {
                    pageController.setItalic(emotion);
                  });
                },
                child: Text("Italic",
                    style: TextStyle(
                        color: Get.put(ExpressionThemeController())
                            .getTextColor(emotion))))),
      ],
    );
  }

  Widget textPreview(int emotion) {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: TextField(
                decoration: const InputDecoration(labelText: "Type here"),
                style: const TextStyle().merge(GoogleFonts.getFont(
                    pageController.newFont[emotion],
                    fontWeight: pageController.newBold[emotion]
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontStyle: pageController.newItalic[emotion]
                        ? FontStyle.italic
                        : FontStyle.normal)),
              ),
            ),
          ),
        ),
        SizedBox(
            width: 40,
            child: Text(
              pageController.newEmoji[emotion],
              style: const TextStyle(fontSize: 25),
            ))
      ],
    );
  }

  Widget colorSelection(int emotion) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6),
          itemCount: pageController.getLengthColors(),
          itemBuilder: (BuildContext context, index) {
            return InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  setState(() {
                    pageController.setNewColor(emotion, index);
                  });
                },
                child: colorButton(index));
          }),
    );
  }

  Padding colorButton(int index) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border:
                Border.all(color: pageController.getColorT(index), width: 2)),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: pageController.getColorP(index),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(100),
                      bottomLeft: Radius.circular(100)),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: pageController.getColorS(index),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(100),
                      bottomRight: Radius.circular(100)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fontSelector(int emotion) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: pageController.getLengthFonts(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                pageController.setNewFont(emotion, index);
              });
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Text(
                    pageController.getStringFont(index),
                    style: pageController.getStyleFonts(index),
                  ),
                ),
                const Divider()
              ],
            ),
          );
        });
  }

  Widget emojiSelector(int emotion) {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
        itemCount: pageController.getLengthEmojis(),
        itemBuilder: (BuildContext context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                pageController.setNewEmoji(emotion, index);
              });
            },
            child: Center(
              child: Text(
                pageController.getEmojis(index),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          );
        });
  }
}
