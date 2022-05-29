import 'package:chat_app/controllers/expression_theme_controller.dart';
import 'package:chat_app/controllers/user_controller.dart';
import 'package:chat_app/custom%20widgets/action_button.dart';
import 'package:chat_app/custom%20widgets/profile.dart';
import 'package:chat_app/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/user.dart' as localUser;
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            _responsiveProfile(),
            const Text("Current emotion is"),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.put(ExpressionThemeController())
                              .changeTheme(1, true);
                          Get.put(UserController()).changeMood(1);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Get.put(ExpressionThemeController())
                                .getEmotionColor(1)),
                        child: Text(
                          "Happy",
                          style: TextStyle(
                              color: Get.put(ExpressionThemeController())
                                  .tertiaryColor
                                  .elementAt(1)),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Get.put(ExpressionThemeController())
                              .changeTheme(2, true);
                          Get.put(UserController()).changeMood(2);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Get.put(ExpressionThemeController())
                                .getEmotionColor(2)),
                        child: Text(
                          "Sad",
                          style: TextStyle(
                              color: Get.put(ExpressionThemeController())
                                  .tertiaryColor
                                  .elementAt(2)),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Get.put(ExpressionThemeController())
                              .changeTheme(3, true);
                          Get.put(UserController()).changeMood(3);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Get.put(ExpressionThemeController())
                                .getEmotionColor(3)),
                        child: Text(
                          "Scared",
                          style: TextStyle(
                              color: Get.put(ExpressionThemeController())
                                  .tertiaryColor
                                  .elementAt(3)),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Get.put(ExpressionThemeController())
                              .changeTheme(4, true);
                          Get.put(UserController()).changeMood(4);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Get.put(ExpressionThemeController())
                                .getEmotionColor(4)),
                        child: Text(
                          "Disgust",
                          style: TextStyle(
                              color: Get.put(ExpressionThemeController())
                                  .tertiaryColor
                                  .elementAt(4)),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.put(ExpressionThemeController())
                              .changeTheme(5, true);
                          Get.put(UserController()).changeMood(5);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Get.put(ExpressionThemeController())
                                .getEmotionColor(5)),
                        child: Text(
                          "Rage",
                          style: TextStyle(
                              color: Get.put(ExpressionThemeController())
                                  .tertiaryColor
                                  .elementAt(5)),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Get.put(ExpressionThemeController())
                              .changeTheme(6, true);
                          Get.put(UserController()).changeMood(6);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Get.put(ExpressionThemeController())
                                .getEmotionColor(6)),
                        child: Text("Surprise",
                            style: TextStyle(
                                color: Get.put(ExpressionThemeController())
                                    .tertiaryColor
                                    .elementAt(6)))),
                    ElevatedButton(
                        onPressed: () {
                          Get.put(ExpressionThemeController())
                              .changeTheme(0, true);
                          Get.put(UserController()).changeMood(0);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Get.put(ExpressionThemeController())
                                .getEmotionColor(0)),
                        child: Text(
                          "Neutral",
                          style: TextStyle(
                              color: Get.put(ExpressionThemeController())
                                  .tertiaryColor
                                  .elementAt(6)),
                        )),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  /*Widget _url_Profile() { // UNRESPONSIVE VER
    String url = Get.put(UserController()).myUser.photoUrl;
    if (url == '') {
      return Profile.large(
        url:
            "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png",
        mood: 0,
      );
    } else {
      return Profile.large(
        url: url,
        mood: Get.put(UserController().myUser.mood),
      );
    }
  }*/

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

  Widget _delegate(String url, int mood) {
    return Profile.large(url: url, mood: mood);
  }
}
