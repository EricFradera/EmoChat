import 'package:chat_app/controllers/expression_theme_controller.dart';
import 'package:chat_app/controllers/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum GraphType { own, other, overall }

class StatatisticsController {
  List<PieChartSectionData> getMoodData(AsyncSnapshot<QuerySnapshot> moodData) {
    List<PieChartSectionData> section = [];
    List<double> values = [0, 0, 0, 0, 0, 0, 0];
    for (var element in moodData.data!.docs) {
      values[element["mood"]]++;
    }

    for (int i = 0; i < 7; i++) {
      section.add(PieChartSectionData(
          value: values[i],
          color: Get.put(ExpressionThemeController()).getPrimaryColor(i),
          title: getEmotionName(i)));
    }
    return section;
  }

  List<PieChartSectionData> getMesData(
      AsyncSnapshot<QuerySnapshot> moodData, int graphType) {
    List<PieChartSectionData> section = [];
    List<double> valuesOwn = [0, 0, 0, 0, 0, 0, 0];
    List<double> valuesOther = [0, 0, 0, 0, 0, 0, 0];
    List<double> valuesOverall = [0, 0, 0, 0, 0, 0, 0];
    String uid = Get.put(UserController()).myUser.uid;

    for (var element in moodData.data!.docs) {
      if (element["sender"] == uid) {
        valuesOwn[element["emotion"]]++;
      } else if (element["reciever"] == uid) {
        valuesOther[element["emotion"]]++;
      }
      valuesOverall[element["emotion"]]++;
    }
    for (int i = 0; i < 7; i++) {
      if (graphType == GraphType.own.index) {
        section.add(sectorBuilder(valuesOwn, i, getEmotionName(i), false));
      } else if (graphType == GraphType.other.index) {
        section.add(sectorBuilder(valuesOther, i, getEmotionName(i), false));
      }
      if (graphType == GraphType.overall.index) {
        section.add(sectorBuilder(valuesOverall, i, getEmotionName(i), false));
      }
    }
    return section;
  }

  List<PieChartSectionData> getThemeData(AsyncSnapshot<QuerySnapshot> themeData,
      int emotion, String variableName) {
    List<PieChartSectionData> section = [];
    List<String> themeElement = [];
    List<double> values = [];
    bool color = false;
    for (var element in themeData.data!.docs) {
      if (element[variableName].runtimeType == int) {
        color = true;
      }
      if (element["emotion"] == emotion) {
        if (themeElement.contains(element[variableName].toString())) {
          values[themeElement.indexOf(element[variableName].toString())]++;
        } else {
          themeElement.add(element[variableName].toString());
          values.add(1);
        }
      }
    }
    for (int i = 0; i < themeElement.length; i++) {
      section.add(sectorBuilder(values, i, themeElement[i], color));
    }
    return section;
  }

  PieChartSectionData sectorBuilder(
      List<double> values, int i, String title, bool color) {
    return PieChartSectionData(
        value: values[i],
        color: color
            ? Color(int.parse(title))
            : Get.put(ExpressionThemeController()).getPrimaryColor(i),
        title: color ? "" : title);
  }

  String getEmotionName(int index) {
    switch (index) {
      case 1:
        return "Happy";
      case 2:
        return "Sad";
      case 3:
        return "Angry";
      case 4:
        return "Disgust";
      case 5:
        return "Surprise";
      case 6:
        return "Fear";
      default:
        return "neutral";
    }
  }
}
