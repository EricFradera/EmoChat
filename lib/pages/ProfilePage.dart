import 'package:chat_app/controllers/expression_theme_controller.dart';
import 'package:chat_app/controllers/user_controller.dart';
import 'package:chat_app/custom%20widgets/action_button.dart';
import 'package:chat_app/custom%20widgets/profile.dart';
import 'package:chat_app/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/user.dart' as localUser;
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _url_Profile(),
          Text("Current emotion is"),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.put(Expression_theme_controller())
                            .changeTheme(1, true);
                        Get.put(UserController()).changeMood(1);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.orange),
                      child: Text("Happy")),
                  ElevatedButton(
                      onPressed: () {
                        Get.put(Expression_theme_controller())
                            .changeTheme(2, true);
                        Get.put(UserController()).changeMood(2);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      child: Text("Sad")),
                  ElevatedButton(
                      onPressed: () {
                        Get.put(Expression_theme_controller())
                            .changeTheme(3, true);
                        Get.put(UserController()).changeMood(3);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      child: Text("Scared")),
                  ElevatedButton(
                      onPressed: () {
                        Get.put(Expression_theme_controller())
                            .changeTheme(4, true);
                        Get.put(UserController()).changeMood(4);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.yellow),
                      child: Text("Disgust")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.put(Expression_theme_controller())
                            .changeTheme(5, true);
                        Get.put(UserController()).changeMood(5);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: Text("Rage")),
                  ElevatedButton(
                      onPressed: () {
                        Get.put(Expression_theme_controller())
                            .changeTheme(6, true);
                        Get.put(UserController()).changeMood(6);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.pink),
                      child: Text("Surprise")),
                  ElevatedButton(
                      onPressed: () {
                        Get.put(Expression_theme_controller())
                            .changeTheme(0, true);
                        Get.put(UserController()).changeMood(0);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.grey),
                      child: Text("Neutral")),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _url_Profile() {
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
  }
}
