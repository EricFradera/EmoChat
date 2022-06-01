import 'package:chat_app/controllers/expression_theme_controller.dart';
import 'package:chat_app/controllers/user_controller.dart';
import 'package:chat_app/custom%20widgets/action_button.dart';
import 'package:chat_app/custom%20widgets/messages_own_tile.dart';
import 'package:chat_app/custom%20widgets/messages_tile.dart';
import 'package:chat_app/custom%20widgets/profile.dart';
import 'package:chat_app/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/destination_user.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.destinationUser}) : super(key: key);

  static Route route(DestinationUser data) => MaterialPageRoute(
        builder: (context) => ChatScreen(
          destinationUser: data,
        ),
      );

  final DestinationUser destinationUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(UserController()).selectUser(widget.destinationUser);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: _AppBarTitle(messageData: widget.destinationUser),
      ),
      body: Column(
        children: const [Expanded(child: _MessageList()), _TextBar()],
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({
    Key? key,
    required this.messageData,
  }) : super(key: key);
  final DestinationUser messageData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Profile.small(
          // remove conts when dynamically add picture
          url: messageData.profilePicture, mood: messageData.mood,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //remove const when dynamically set profile name
            Text(
              messageData.senderName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ))
      ],
    );
  }
}

class _MessageList extends StatelessWidget {
  const _MessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
          stream: Get.put(UserController()).getChatMessages(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];

                ChatMessage msg = ChatMessage(
                    chatId: doc['chatId'],
                    sender: doc['sender'],
                    reciever: doc['reciever'],
                    message: doc['message'],
                    timestamp: doc['timestamp'],
                    emotion: doc['emotion']);

                if (Get.put(UserController()).isOwnMsg(msg)) {
                  return MessageOwnTile(
                    message: msg.message,
                    emotion: msg.emotion,
                  );
                } else {
                  return MessageTile(
                      message: msg.message, emotion: msg.emotion);
                }
              },
            );
          }),
    );
  }
}

enum emotionVal { neutral, happy, sad, angry, disgust, surprise, fear }

class _TextBar extends StatefulWidget {
  const _TextBar({Key? key}) : super(key: key);

  @override
  State<_TextBar> createState() => _TextBarState();
}

class _TextBarState extends State<_TextBar> {
  TextEditingController messageTextController = TextEditingController();

  final bold = const TextStyle(fontWeight: FontWeight.bold, fontSize: 14);

  final italic = const TextStyle(fontStyle: FontStyle.italic, fontSize: 14);

  int emotionMode = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
          bottom: true,
          top: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Get.put(ExpressionThemeController())
                          .getPrimaryColor(emotionMode),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 3),
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.2))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      emotes(
                          Get.put(ExpressionThemeController())
                              .getEmoji(emotionVal.neutral.index),
                          emotionVal.neutral.index),
                      emotes(
                          Get.put(ExpressionThemeController())
                              .getEmoji(emotionVal.happy.index),
                          emotionVal.happy.index),
                      emotes(
                          Get.put(ExpressionThemeController())
                              .getEmoji(emotionVal.sad.index),
                          emotionVal.sad.index),
                      emotes(
                          Get.put(ExpressionThemeController())
                              .getEmoji(emotionVal.angry.index),
                          emotionVal.angry.index),
                      emotes(
                          Get.put(ExpressionThemeController())
                              .getEmoji(emotionVal.disgust.index),
                          emotionVal.disgust.index),
                      emotes(
                          Get.put(ExpressionThemeController())
                              .getEmoji(emotionVal.surprise.index),
                          emotionVal.surprise.index),
                      emotes(
                          Get.put(ExpressionThemeController())
                              .getEmoji(emotionVal.fear.index),
                          emotionVal.fear.index)
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Get.put(ExpressionThemeController())
                            .getPrimaryColor(emotionMode),
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 3),
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.2))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: TextField(
                        controller: messageTextController,
                        style: const TextStyle().merge(
                            Get.put(ExpressionThemeController())
                                .getTextStyle(emotionMode)),
                        decoration: const InputDecoration(
                            hintText: "Type here", border: InputBorder.none),
                      ),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 4),
                    child: ActionButton(
                      color: Get.put(ExpressionThemeController())
                          .getPrimaryColor(emotionMode),
                      icon: Icons.send,
                      onPressed: () {
                        Get.put(UserController()).sendMessage(
                            messageTextController.text, emotionMode);
                        messageTextController.clear();
                        setState(() => emotionMode = 0);
                      },
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget emotes(String emoji, int newMode) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () => setState(() {
        emotionMode = newMode;
      }),
      child: Container(
        decoration: BoxDecoration(
            color:
                Get.put(ExpressionThemeController()).getPrimaryColor(newMode),
            borderRadius: BorderRadius.circular(50)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
