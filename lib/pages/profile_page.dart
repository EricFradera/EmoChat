import 'package:chat_app/controllers/user_controller.dart';
import 'package:chat_app/custom%20widgets/how_it_works_widget.dart';
import 'package:chat_app/custom%20widgets/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/expression_theme_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: _responsiveProfile(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28, bottom: 28),
                  child: Text(
                    "Current emotion is " +
                        Get.put(ExpressionThemeController()).getEmotion(),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                changeEmotionButtons(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget changeEmotionButtons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.put(ExpressionThemeController()).changeTheme(1);
                  Get.put(UserController()).changeMood(1);
                },
                style: ElevatedButton.styleFrom(
                    primary: Get.put(ExpressionThemeController())
                        .getPrimaryColor(1)),
                child: Text(
                  "Happy",
                  style: TextStyle(
                      color: Get.put(ExpressionThemeController())
                          .getTertiaryColor(1)),
                )),
            ElevatedButton(
                onPressed: () {
                  Get.put(ExpressionThemeController()).changeTheme(2);
                  Get.put(UserController()).changeMood(2);
                },
                style: ElevatedButton.styleFrom(
                    primary: Get.put(ExpressionThemeController())
                        .getPrimaryColor(2)),
                child: Text(
                  "Sad",
                  style: TextStyle(
                      color: Get.put(ExpressionThemeController())
                          .getTertiaryColor(2)),
                )),
            ElevatedButton(
                onPressed: () {
                  Get.put(ExpressionThemeController()).changeTheme(3);
                  Get.put(UserController()).changeMood(3);
                },
                style: ElevatedButton.styleFrom(
                    primary: Get.put(ExpressionThemeController())
                        .getPrimaryColor(3)),
                child: Text(
                  "Scared",
                  style: TextStyle(
                      color: Get.put(ExpressionThemeController())
                          .getTertiaryColor(3)),
                )),
            ElevatedButton(
                onPressed: () {
                  Get.put(ExpressionThemeController()).changeTheme(4);
                  Get.put(UserController()).changeMood(4);
                },
                style: ElevatedButton.styleFrom(
                    primary: Get.put(ExpressionThemeController())
                        .getPrimaryColor(4)),
                child: Text(
                  "Disgust",
                  style: TextStyle(
                      color: Get.put(ExpressionThemeController())
                          .getTertiaryColor(4)),
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.put(ExpressionThemeController()).changeTheme(5);
                  Get.put(UserController()).changeMood(5);
                },
                style: ElevatedButton.styleFrom(
                    primary: Get.put(ExpressionThemeController())
                        .getPrimaryColor(5)),
                child: Text(
                  "Rage",
                  style: TextStyle(
                      color: Get.put(ExpressionThemeController())
                          .getTertiaryColor(5)),
                )),
            ElevatedButton(
                onPressed: () {
                  Get.put(ExpressionThemeController()).changeTheme(6);
                  Get.put(UserController()).changeMood(6);
                },
                style: ElevatedButton.styleFrom(
                    primary: Get.put(ExpressionThemeController())
                        .getPrimaryColor(6)),
                child: Text("Surprise",
                    style: TextStyle(
                        color: Get.put(ExpressionThemeController())
                            .getTertiaryColor(6)))),
            ElevatedButton(
                onPressed: () {
                  Get.put(ExpressionThemeController()).changeTheme(0);
                  Get.put(UserController()).changeMood(0);
                },
                style: ElevatedButton.styleFrom(
                    primary: Get.put(ExpressionThemeController())
                        .getPrimaryColor(0)),
                child: Text(
                  "Neutral",
                  style: TextStyle(
                      color: Get.put(ExpressionThemeController())
                          .getTertiaryColor(6)),
                )),
          ],
        )
      ],
    );
  }

  Widget _responsiveProfile() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where('uid', isEqualTo: Get.put(UserController()).myUser.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: snapshot.data!.docs.map((document) {
              return Profile.large(
                  url: document["photoUrl"], mood: document["mood"]);
            }).toList(),
          );
        });
  }
}
