import 'package:chat_app/controllers/user_controller.dart';
import 'package:chat_app/custom%20widgets/avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/user.dart' as localUser;
import 'package:get/get.dart';

class HowItWorks extends StatelessWidget {
  HowItWorks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [_url_Profile()],
      ),
    );
  }

  Widget _url_Profile() {
    String url = Get.put(UserController()).myUser.photoUrl;
    if (url == '') {
      return const Profile.large(
          url:
              "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png");
    } else {
      return Profile.large(url: url);
    }
  }
}
