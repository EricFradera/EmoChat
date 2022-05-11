import 'package:chat_app/theme.dart';
import "package:flutter/material.dart";

class Action_Button extends StatelessWidget {
  const Action_Button({
    Key? key,
    required this.color,
    required this.icon,
    this.size = 54,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //Do nothing
      },
      child: Icon(icon),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
        backgroundColor: MaterialStateProperty.all(color),
        elevation: MaterialStateProperty.all(4),
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed))
            return Colors.amberAccent; // <-- Splash color
        }),
      ),
    );
  }
}
