import "package:flutter/material.dart";

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.onPressed,
    this.size = 54,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final double size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Icon(icon),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const CircleBorder()),
        padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
        backgroundColor: MaterialStateProperty.all(color),
        elevation: MaterialStateProperty.all(4),
      ),
    );
  }
}
