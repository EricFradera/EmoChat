import 'package:chat_app/custom%20widgets/how_it_works_widget.dart';
import 'package:flutter/material.dart';

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: const [
          HotItWorks(),
        ],
      ),
    );
  }
}
