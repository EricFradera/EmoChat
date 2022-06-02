import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../font_and_emoji_data.dart';

class TestScreen extends StatelessWidget {
  TestScreen({
    Key? key,
  }) : super(key: key);
  final List<PieChartSectionData> sectors = [
    PieChartSectionData(
        value: 5,
        color: Colors.amber,
        radius: 100,
        showTitle: true,
        title: "this is a test",
        titleStyle: const TextStyle(fontSize: 35, color: Colors.black),
        titlePositionPercentageOffset: 20),
    PieChartSectionData(value: 5, color: Colors.blue),
    PieChartSectionData(value: 5, color: Colors.green),
    PieChartSectionData(value: 5, color: Colors.red),
  ];

  FontAndEmojiData data = FontAndEmojiData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AspectRatio(
          aspectRatio: 1.0,
          child: PieChart(PieChartData(
            sectionsSpace: 2.0,
            sections: _chartSections(sectors),
            centerSpaceRadius: 48.0,
          ))),
    );
  }

  List<PieChartSectionData> _chartSections(List<PieChartSectionData> sectors) {
    final List<PieChartSectionData> list = [];
    for (var sector in sectors) {
      const double radius = 40.0;
      final data = PieChartSectionData(
        color: sector.color,
        value: sector.value,
        radius: radius,
        title: '',
      );
      list.add(data);
    }
    return list;
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
