import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class logInButton extends StatelessWidget {
  const logInButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 217, 231, 203),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.2))
          ]),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            "Log In with Google",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                letterSpacing: 0.5, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
