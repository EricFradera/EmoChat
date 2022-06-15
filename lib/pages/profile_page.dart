import 'package:chat_app/controllers/firebase_controller.dart';
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
                    style: const TextStyle(fontSize: 25),
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
            getButton("Neutral", 0),
            getButton("Happy", 1),
            getButton("Sad", 2)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            getButton("Angry", 3),
            getButton("Disgust", 4),
            getButton("Surprise", 5)
          ],
        ),
        getButton("Fear", 6)
      ],
    );
  }

  Widget getButton(String emotion, int indexEmotion) {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
          onPressed: () {
            Get.put(ExpressionThemeController()).changeTheme(indexEmotion);
            Get.put(FireBaseController()).changeMood(indexEmotion);
          },
          style: ElevatedButton.styleFrom(
              primary: Get.put(ExpressionThemeController())
                  .getPrimaryColor(indexEmotion)),
          child: Text(
            emotion,
            style: TextStyle(
                color: Get.put(ExpressionThemeController())
                    .getTertiaryColor(indexEmotion)),
          )),
    );
  }

  Widget _responsiveProfile() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where('uid', isEqualTo: Get.put(FireBaseController()).myUser.uid)
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
