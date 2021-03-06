import 'package:chat_app/controllers/expression_theme_controller.dart';
import 'package:chat_app/controllers/firebase_controller.dart';
import 'package:chat_app/custom%20widgets/log_in_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                      color: Theme.of(context).colorScheme.tertiary,
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
                        color: Theme.of(context).colorScheme.tertiary,
                        letterSpacing: 0.1,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              )
            ],
          ),
        )),
        LogInButton(onPressed: (() => _handleSignIn(context)))
      ],
    ));
  }

  Future<void> _handleSignIn(context) async {
    await Get.put(FireBaseController()).signInUser();
    Get.put(ExpressionThemeController())
        .changeTheme(Get.put(FireBaseController()).myUser.mood);
    Route route = MaterialPageRoute(builder: (context) => HomeScreen());
    Navigator.pushReplacement(context, route);
  }
}
