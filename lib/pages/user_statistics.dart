import 'package:chat_app/controllers/statisticsController.dart';
import 'package:chat_app/controllers/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserStatistics extends StatefulWidget {
  const UserStatistics({Key? key}) : super(key: key);

  @override
  State<UserStatistics> createState() => _UserStatisticsState();
}

class _UserStatisticsState extends State<UserStatistics> {
  final StatatisticsController controller = StatatisticsController();

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(
        children: [
          title("Enviroment mood"),
          _moodStatitistics(),
          _messageStatistics(),
          _themesAnalytics()
        ],
      ),
    ]);
  }

  Widget buildPie(List<PieChartSectionData> data) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 3,
                  color: Theme.of(context).colorScheme.tertiary)
            ]),
        child: AspectRatio(
            aspectRatio: 1.5,
            child: PieChart(PieChartData(
              sectionsSpace: 2.0,
              sections: data,
              centerSpaceRadius: 48.0,
            ))),
      ),
    );
  }

  Widget _moodStatitistics() {
    return StreamBuilder(
        stream: Get.put(UserController()).getUsers(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return buildPie(controller.getMoodData(snapshot));
        });
  }

  Widget _messageStatistics() {
    return StreamBuilder(
        stream: Get.put(UserController()).getMesAnalytics(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(children: [
            title("My own message analytics"),
            buildPie(controller.getMesData(snapshot, 0)),
            title("Other people comon emotions"),
            buildPie(controller.getMesData(snapshot, 1)),
            title("Overall user messages"),
            buildPie(controller.getMesData(snapshot, 2))
          ]);
        });
  }

  Widget _themesAnalytics() {
    final allEmotions = <Widget>[];
    return StreamBuilder(
        stream: Get.put(UserController()).getThemesAnalytics(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          for (int i = 0; i < 7; i++) {
            allEmotions.add(
                title("Most used emojis for " + controller.getEmotionName(i)));
            allEmotions.add(buildPie(
                controller.getThemeData(snapshot, i, "emojiExpression")));
            allEmotions.add(
                title("Most used Colors for " + controller.getEmotionName(i)));
            allEmotions
                .add(buildPie(controller.getThemeData(snapshot, i, "primary")));
            allEmotions.add(
                title("Most used Fonts for " + controller.getEmotionName(i)));
            allEmotions.add(
                buildPie(controller.getThemeData(snapshot, i, "textFont")));
          }
          return Column(children: allEmotions);
        });
  }

  Widget title(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Text(
        title,
        style: const TextStyle(fontSize: 25),
      ),
    );
  }
}
