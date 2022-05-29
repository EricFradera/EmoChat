import 'package:chat_app/controllers/expression_theme_controller.dart';
import 'package:chat_app/controllers/user_controller.dart';
import 'package:chat_app/custom%20widgets/logInButton.dart';
import 'package:chat_app/models/user.dart' as localUser;
import 'package:chat_app/views/import_views.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
        Center(
            child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Inicia sessión en EmoChat",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      letterSpacing: 0.5,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Interactua, comunica en una experiencia Afectiva",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        letterSpacing: 0.1,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              )
            ],
          ),
        )),
        /*ElevatedButton(
              onPressed: () => _handleSignIn(context),
              child: const Text('SIGN IN'),
            ),*/ //old button
        logInButton(onPressed: (() => _handleSignIn(context)))
      ],
    ));
  }

  Future<void> _handleSignIn(context) async {
    await Get.put(UserController()).signInUser();
    Get.put(Expression_theme_controller())
        .changeTheme(Get.put(UserController()).myUser.mood, true);
    Route route = MaterialPageRoute(builder: (context) => HomeScreen());
    Navigator.pushReplacement(context, route);
  }
}
