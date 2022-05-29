import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/controllers/expression_theme_controller.dart';
import 'package:chat_app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile(
      {Key? key, required this.radius, required this.url, required this.mood})
      : super(key: key);
  const Profile.small(
      {Key? key, this.radius = 16, required this.url, required this.mood})
      : super(key: key);
  const Profile.medium(
      {Key? key, this.radius = 22, required this.url, required this.mood})
      : super(key: key);
  const Profile.large(
      {Key? key, this.radius = 44, required this.url, required this.mood})
      : super(key: key);

  final double radius;
  final String url;
  final mood;
  //final Color color;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: (radius + (radius * 0.25)),
      backgroundColor: getCircleColor(),
      child: CircleAvatar(
        radius: radius,
        backgroundImage: CachedNetworkImageProvider(url),
      ),
    );
  }

  Color getCircleColor() {
    return Get.put(ExpressionThemeController()).getEmotionColor(mood);
  }
}
