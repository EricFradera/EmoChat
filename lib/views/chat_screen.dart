import 'package:chat_app/custom%20widgets/action_button.dart';
import 'package:chat_app/custom%20widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/models/message_data.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key, required this.messageData}) : super(key: key);

  static Route route(MessageData data) => MaterialPageRoute(
        builder: (context) => ChatScreen(
          messageData: data,
        ),
      );

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(89, 122, 66, 1),
        elevation: 0,
        title: _AppBarTitle(messageData: messageData),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/assets/white_back.png"),
                fit: BoxFit.cover)),
        child: Column(
          children: const [Expanded(child: _Message_List()), _TextBar()],
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({
    Key? key,
    required this.messageData,
  }) : super(key: key);
  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Profile.small(
            // remove conts when dynamically add picture
            url:
                "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"),
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

class _Message_List extends StatelessWidget {
  const _Message_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListView(
        children: [
          _MessageTile(message: "HI"),
          _Message_Own_Tile(message: "test"),
          _MessageTile(message: "ACK"),
        ],
      ),
    );
  }
}

class _Message_Own_Tile extends StatelessWidget {
  const _Message_Own_Tile({Key? key, required this.message}) : super(key: key);

  final String message;

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
                  color: const Color.fromRGBO(230, 239, 218, 1),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.2))
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(message),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 50),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.2))
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(message),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextBar extends StatelessWidget {
  const _TextBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
          bottom: true,
          top: false,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(230, 239, 218, 1),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 3),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.2))
                    ]),
                child: const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: TextField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                        hintText: "Type here", border: InputBorder.none),
                  ),
                ),
              )),
              const Padding(
                padding: EdgeInsets.only(left: 12, right: 4),
                child: Action_Button(
                    color: Color.fromARGB(255, 89, 122, 60), icon: Icons.send),
              ),
            ],
          )),
    );
  }
}
