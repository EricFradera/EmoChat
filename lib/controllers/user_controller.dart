import 'package:chat_app/controllers/expression_page_controller.dart';
import 'package:chat_app/controllers/expression_theme_controller.dart';
import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/models/destination_user.dart';
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
  String docRef = "";
  List<String> themeDocRef = ["", "", "", "", "", "", ""];

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

    EmoUser tempUser = await tryGetUser(userCredential);

    //tryAddUser(tempUser);
    myUser = tempUser;
    await createTheme();

    update();
  }

  Future<EmoUser> tryGetUser(UserCredential userCred) async {
    try {
      final query = await db
          .collection("users")
          .where("uid", isEqualTo: userCred.user?.uid)
          .get();
      if (query.docs.isEmpty) {
        return createUser(userCred);
      } else {
        var dataList = query.docs.map((doc) {
          return EmoUser(
              uid: doc["uid"],
              displayName: doc["userName"],
              email: doc["email"],
              photoUrl: doc["photoUrl"],
              mood: doc["mood"]);
        });
        return dataList.single;
      }
    } catch (e) {
      return EmoUser.empty();
    }
  }

  EmoUser createUser(UserCredential userCred) {
    EmoUser tempUser = EmoUser(
        uid: userCred.user!.uid,
        displayName: userCred.user!.displayName ?? '',
        email: userCred.user!.email ?? '',
        photoUrl: userCred.user!.photoURL ?? '',
        mood: 0);
    db.collection("users").add(tempUser.toJson());
    return tempUser;
  }

  Future<void> trySingOut() async {
    myUser = EmoUser.empty();
    selectedUser = DestinationUser.empty();
    docRef = "";

    await GoogleSignIn.standard().disconnect();
    update();
  }

  void selectUser(DestinationUser destinationUser) {
    selectedUser = destinationUser;
    update();
  }

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

  sendMessage(String message, int emotion) {
    if (message.isNotEmpty) {
      ChatMessage msg = ChatMessage(
          chatId: getConversationID(),
          sender: myUser.uid,
          reciever: selectedUser.senderUid,
          message: message,
          timestamp: Timestamp.now(),
          emotion: emotion);

      db.collection("messages").add(msg.toJson());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages() {
    return db
        .collection("messages")
        .where("chatId", isEqualTo: getConversationID())
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  changeMood(int i) async {
    if (docRef.isEmpty) {
      QuerySnapshot query = await db
          .collection("users")
          .where("uid", isEqualTo: myUser.uid)
          .get();
      docRef = query.docs.single.reference.id;
    }
    myUser.mood = i;
    await db.collection("users").doc(docRef).update(myUser.toJson());
    update();
  }

  Future<void> createTheme() async {
    for (int i = 0; i < 7; i++) {
      final query = await getTheme(i);
      if (query.docs.isEmpty) {
        db
            .collection("userThemes")
            .add(Get.put(ExpressionThemeController()).getJson(i, myUser.uid));
      }
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getTheme(int index) async {
    final query = await db
        .collection('userThemes')
        .where('uid', isEqualTo: myUser.uid)
        .where("emotion", isEqualTo: index)
        .get();
    themeDocRef[index] = query.docs.single.reference.path;
    update();
    return query;
  }

  Future<void> updateTheme(int emotion) async {
    db.collection("userThemes").doc(themeDocRef[emotion]).update(
        Get.put(ExpressionThemeController()).getJson(emotion, myUser.uid));
  }
}
