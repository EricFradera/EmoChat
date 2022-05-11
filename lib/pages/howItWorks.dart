import 'package:flutter/material.dart';

class HowItWorks extends StatelessWidget {
  const HowItWorks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
          "En esta pagina se explica el funcionamiento basico de la aplicacion. El sistema es sencillo.\n En la pagina principal aparecen los contactos recientes con los que puedes hablar. En el el segundo se puede acceder a la expresividad segun las emociones y modificarlo acorde"),
    );
  }
}
