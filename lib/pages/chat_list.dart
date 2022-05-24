import 'package:chat_app/controllers/user_controller.dart';
import 'package:chat_app/models/destination_User.dart';
import 'package:chat_app/theme.dart';
import 'package:chat_app/views/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../custom widgets/widgets.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  ContactsList({Key? key}) : super(key: key);

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
                  document["photoUrl"], document["uid"]);
            }).toList(),
          );
        });
  }
}

Widget _delegate(
    BuildContext context, String name, String url, String senderUid) {
  return _MessageCard(
      messageData: DestinationUser(
          senderName: name,
          message: "Lorem ipsum",
          profilePicture: url,
          senderUid: senderUid));
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
