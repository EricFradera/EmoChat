import 'package:chat_app/controllers/expression_theme_controller.dart';
import 'package:chat_app/custom%20widgets/messages_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HotItWorks extends StatelessWidget {
  const HotItWorks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title("How it works"),
        bodyText(
            "Emo chat is a showcase of some Afective computing features that can be implemented in several projects. The main objective of the app is to showcase how apps can be personalized based on the personality of the user but also on how they are feeling. While better representing the user feelings through the UI it also provides tools to improve empathy and user comunication.\n This page will show the patters as well as showing your current settings"),
        title("UI mood representation"),
        bodyText(
            'The app provides different themes based on how you are feeling, and will change all the colors in app when changing your mood. The customization allows to better fit your idea of the color of emotion. Cutural changes as well as age, race etc might change the relations between emotion and colors so a flexible system allows to customomized base on your ideas as well as ensuring content visibility '),
        emotionColorRep(),
        title("Better empathy"),
        bodyText(
            "In the same way that colors did emojis and Fonts are used to imporve the feels of the sender to better understand how the other user feels. Ins the same page wher colors are chosen a wide variety of emojis and Fonts are provided to improve user emotion perception "),
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child:
              Center(child: MessageTile(message: "Happy emotion", emotion: 1)),
        ),
        title("Realtime"),
        bodyText(
            "In order to have an app that allows for real comunications es fundamental to have realtime input of all the users. THe apps is constantly observing your contacts in order to keep you about how the users are feeling."),
        title("Keep your profile"),
        bodyText(
            "Every configuration is saved in bdd so any app that acces your user profile can know your perception of emotions and adapt in their own way this preferences "),
        title("User analytics"),
        bodyText(
            "All the data stored allows to make diagnistics about you and your enviroment. \n Learn which are your most common emotions, in wich emotion you spend the most time, and how you tend to message people. At the same time learn how your enviroment is feeling and allow to have a better affective reponsability with your friends and familiars")
      ],
    );
  }

  Widget title(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 25),
      ),
    );
  }

  Widget bodyText(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Text(text),
    );
  }

  Widget emotionColorRep() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Colors for Neutral:"),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: colorThemeRep(0),
          ),
          const Text("Colors for Happy:"),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: colorThemeRep(1),
          ),
          const Text("Colors for Sad:"),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: colorThemeRep(2),
          ),
          const Text("Colors for Angry:"),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: colorThemeRep(3),
          ),
          const Text("Colors for Disgust:"),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: colorThemeRep(4),
          ),
          const Text("Colors for Surprise:"),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: colorThemeRep(5),
          ),
          const Text("Colors for Fear:"),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: colorThemeRep(6),
          )
        ],
      ),
    );
  }

  Widget colorThemeRep(int color) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          colorRep("Primary",
              Get.put(ExpressionThemeController()).getPrimaryColor(color)),
          colorRep("Secondary",
              Get.put(ExpressionThemeController()).getSecondaryColor(color)),
          colorRep("Tertiary",
              Get.put(ExpressionThemeController()).getTertiaryColor(color)),
          colorRep("TextColor",
              Get.put(ExpressionThemeController()).getTextColor(color)),
        ],
      ),
    );
  }

  Column colorRep(String colorName, Color color) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.2))
              ]),
        ),
        Text(colorName)
      ],
    );
  }
}
