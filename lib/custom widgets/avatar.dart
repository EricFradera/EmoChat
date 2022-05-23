import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key, required this.radius, required this.url})
      : super(key: key);
  const Profile.small({Key? key, this.radius = 16, required this.url})
      : super(key: key);
  const Profile.medium({Key? key, this.radius = 22, required this.url})
      : super(key: key);
  const Profile.large({Key? key, this.radius = 44, required this.url})
      : super(key: key);

  final double radius;
  final String url;
  //final Color color;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: (radius + (radius * 0.25)),
      backgroundColor: Colors.green,
      child: CircleAvatar(
        radius: radius,
        backgroundImage: CachedNetworkImageProvider(url),
        backgroundColor: Theme.of(context).cardColor,
      ),
    );
  }
}
