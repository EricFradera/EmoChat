import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/expression_theme_controller.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({Key? key, required this.message, required this.emotion})
      : super(key: key);

  final String message;
  final int emotion;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 50),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Get.put(ExpressionThemeController())
                      .getPrimaryColor(emotion),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 3),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.2))
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(message,
                    style: TextStyle(
                            color: Get.put(ExpressionThemeController())
                                .getTextColor(emotion))
                        .merge(Get.put(ExpressionThemeController())
                            .getTextStyle(emotion))),
              ),
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: Center(
                child: Text(
                  Get.put(ExpressionThemeController()).getEmoji(emotion),
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
