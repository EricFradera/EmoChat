import 'dart:ffi';

import 'package:chat_app/models/chat.dart';
import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/models/destination_User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chat_app/models/user.dart';
import '../models/user.dart';

class UserController extends GetxController {
  //if user is not in database adds, else do nothing

  EmoUser myUser = EmoUser.empty();
  DestinationUser selectedUser = DestinationUser.empty();
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> tryAddUser(EmoUser user) async {
    try {
      final query =
          await db.collection("users").where('uid', isEqualTo: user.uid).get();
      if (query.docs.isEmpty) {
        db.collection("users").add(user.toJson());
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> signInUser() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    //print(userCredential.user!.email.toString());

    EmoUser tempUser = EmoUser(
        uid: userCredential.user!.uid,
        displayName: userCredential.user!.displayName ?? '',
        email: userCredential.user!.email ?? '',
        photoUrl: userCredential.user!.photoURL ?? '',
        mood: '');

    tryAddUser(tempUser);
    myUser = tempUser;
    update();
  }

  void selectUser(DestinationUser destinationUser) {
    selectedUser = destinationUser;
    update();
  }
/* Sometimes the life is hard.
  Future<bool> tryGetChat(MessageData messageData) async {
    //First posible order query
    final query = await db
        .collection("chats")
        .where("uid1", isEqualTo: myUser.uid)
        .where("uid2", isEqualTo: messageData.senderUid)
        .get();

    if (!query.docs.isEmpty) {
      print("CHAT EXISTS V1");
      selectedChat = Chat.fromJson(query.docs.single.data());
      return true;
    }

    //Second posible order query
    final query2 = await db
        .collection("chats")
        .where("uid2", isEqualTo: myUser.uid)
        .where("uid1", isEqualTo: messageData.senderUid)
        .get();

    if (query2.docs.isEmpty) {
      //Create the chat because it doesn't exists
      print("CHAT NOT EXITST, CREATING...");
      createChat(messageData);
      return false;
    }
    print("CHAT EXISTS V2");
    selectedChat = Chat.fromJson(query.docs.single.data());
    return true;
  }

  void createChat(MessageData messageData) {
    Chat newChat = Chat(uid1: myUser.uid, uid2: messageData.senderUid);

    db.collection("chats").add(newChat.toJson());
    selectedChat = newChat;
    update();
  }*/

  bool isOwnMsg(ChatMessage msg) {
    if (msg.sender == myUser.uid) {
      return true;
    }
    return false;
  }

  String getConversationID() {
    return myUser.uid.hashCode <= selectedUser.senderUid.hashCode
        ? myUser.uid + '' + selectedUser.senderUid
        : selectedUser.senderUid + '' + myUser.uid;
  }

  sendMessage(String message) {
    ChatMessage msg = ChatMessage(
        chatId: getConversationID(),
        sender: myUser.uid,
        reciever: selectedUser.senderUid,
        message: message,
        timestamp: Timestamp.now());

    db.collection("messages").add(msg.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages() {
    return db
        .collection("messages")
        .where("chatId", isEqualTo: getConversationID())
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
