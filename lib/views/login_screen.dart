import 'package:chat_app/controllers/user_controller.dart';
import 'package:chat_app/models/user.dart' as localUser;
import 'package:chat_app/views/import_views.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(child: const Text('You are not currently signed in.')),
        ElevatedButton(
          onPressed: () => _handleSignIn(context),
          child: const Text('SIGN IN'),
        ),
      ],
    ));
  }

  Future<void> _handleSignIn(context) async {
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

    print(userCredential.user!.email.toString());

    UserController userController = UserController();

    localUser.User myUser = localUser.User(
        uid: userCredential.user!.uid,
        displayName: userCredential.user!.displayName,
        email: userCredential.user!.email ?? '',
        photoUrl: userCredential.user!.photoURL ?? '');

    userController.tryAddUser(myUser);

    Route route = MaterialPageRoute(builder: (context) => HomeScreen());
    Navigator.pushReplacement(context, route);
  }
}
