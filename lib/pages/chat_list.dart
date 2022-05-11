import 'package:chat_app/models/message_data.dart';
import 'package:chat_app/theme.dart';
import 'package:chat_app/views/chat_screen.dart';

import '../custom widgets/widgets.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate(
            _delegate,
          ))
        ],
      ),
    );
  }

  Widget _delegate(BuildContext context, int index) {
    return _MessageCard(
        messageData: MessageData(
            senderName: "Paul Atreides",
            message: "We need water",
            profilePicture:
                "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"));
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({Key? key, required this.messageData}) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(ChatScreen.route(messageData));
      },
      child: Container(
        height: 85,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Profile.medium(url: messageData.profilePicture),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    messageData.senderName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      wordSpacing: 1.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: Text(
                    messageData.message,
                    style: const TextStyle(
                        fontWeight: FontWeight.w100,
                        color: AppColors.textFaded),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
