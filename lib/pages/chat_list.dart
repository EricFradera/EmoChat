import 'package:chat_app/controllers/user_controller.dart';
import 'package:chat_app/models/destination_user.dart';
import 'package:chat_app/views/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../custom widgets/profile.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where('uid', isNotEqualTo: Get.put(UserController()).myUser.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return _delegate(context, document["userName"],
                  document["photoUrl"], document["uid"], document["mood"]);
            }).toList(),
          );
        });
  }
}

Widget _delegate(
    BuildContext context, String name, String url, String senderUid, mood) {
  return _MessageCard(
      messageData: DestinationUser(
          senderName: name,
          message: "Lorem ipsum",
          profilePicture: url,
          senderUid: senderUid,
          mood: mood));
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({Key? key, required this.messageData}) : super(key: key);

  final DestinationUser messageData;

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
              child: Profile.medium(
                  url: messageData.profilePicture, mood: messageData.mood),
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
                        fontWeight: FontWeight.w100, color: Color(0xFF9899A5)),
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
