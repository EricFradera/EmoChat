import 'package:chat_app/controllers/expression_theme_controller.dart';
import 'package:chat_app/controllers/user_controller.dart';
import 'package:chat_app/custom%20widgets/action_button.dart';
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
              style: const TextStyle(fontSize: 14),
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
                  return _MessageOwnTile(
                    message: msg.message,
                    emotion: msg.emotion,
                  );
                } else {
                  return _MessageTile(
                      message: msg.message, emotion: msg.emotion);
                }
              },
            );
          }),
    );
  }
}

class _MessageOwnTile extends StatelessWidget {
  const _MessageOwnTile(
      {Key? key, required this.message, required this.emotion})
      : super(key: key);

  final String message;
  final int emotion;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 50),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Get.put(ExpressionThemeController())
                      .getPrimaryColor(emotion),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(5),
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
                child: Text(
                  message,
                  style: TextStyle(
                      color: Get.put(ExpressionThemeController())
                          .getTextColor(emotion)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({Key? key, required this.message, required this.emotion})
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
                            .getTextColor(emotion))),
              ),
            ),
          ],
        ),
      ),
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
              Container(
                height: 40,
                width: double.infinity,
                //decoration: BoxDecoration(color: Colors.amber),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    emotes("🙂", emotionVal.neutral.index),
                    emotes("😄", emotionVal.happy.index),
                    emotes("😔", emotionVal.sad.index),
                    emotes("😠", emotionVal.angry.index),
                    emotes("🤢", emotionVal.disgust.index),
                    emotes("😮", emotionVal.surprise.index),
                    emotes("😨", emotionVal.fear.index)
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: getColor(emotionMode),
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
                        style:
                            const TextStyle().merge(getTextStyle(emotionMode)),
                        decoration: const InputDecoration(
                            hintText: "Type here", border: InputBorder.none),
                      ),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 4),
                    child: ActionButton(
                      color: getColor(emotionMode),
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
      onTap: () => setState(() {
        emotionMode = newMode;
      }),
      child: Text(
        emoji,
        style: const TextStyle(fontSize: 30),
      ),
    );
  }

  TextStyle getTextStyle(int mode) {
    switch (mode) {
      case 1:
        return bold;
      case 2:
        return italic;
      default:
        return const TextStyle(fontSize: 14);
    }
  }

  Color getColor(int mode) {
    return Get.put(ExpressionThemeController()).getPrimaryColor(mode);
  }
}
