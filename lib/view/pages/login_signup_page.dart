import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_world_mobile/main.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import commenté, non utilisé
import 'package:new_world_mobile/view/components/delayed_animation.dart';

/// Création d'une page de connexion/inscription
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Supprime l'ombre sous la barre d'application
        backgroundColor: Colors.white
            .withOpacity(0), // Rend la barre d'application transparente
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            size: 30, // Définit la taille de l'icône de fermeture
          ),
          onPressed: () {
            Navigator.pop(
                context); // Revient à la page précédente lorsqu'on appuie sur le bouton de fermeture
          },
        ),
      ),
      body: SingleChildScrollView(
          // Permet de faire défiler le contenu
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Aligne les enfants au début de l'axe horizontal
              children: [
                DelayedAnimation(
                  delay:
                      1500, // Délai avant l'affichage de cet élément (1500ms)
                  child: Center(
                    child: Text(
                      "Se connecter",
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 22, // Espacement vertical de 22 pixels
                ),
                DelayedAnimation(
                  delay:
                      2500, // Délai avant l'affichage de cet élément (2500ms)
                  child: Center(

                    child: Text(
                      textAlign: TextAlign.center,
                      'Veuillez vous connecter pour accéder à votre compte et profiter de tous nos services exclusifs.',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 35, // Espacement vertical de 35 pixels
          ),
          LoginForm(), // Widget du formulaire de connexion
          SizedBox(
            height: 125, // Espacement vertical de 125 pixels
          ),
          DelayedAnimation(
            delay: 5500, // Délai avant l'affichage de cet élément (5500ms)
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Couleur de fond du bouton
                shape: StadiumBorder(), // Forme du bouton
                padding: EdgeInsets.symmetric(
                  horizontal: 125, // Padding horizontal de 125 pixels
                  vertical: 13, // Padding vertical de 13 pixels
                ),
              ),
              child: Text(
                'CONFIRMER',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MyApp(), // Navigue vers la classe MyApp
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _obsureText = true; // Variable pour gérer la visibilité du mot de passe
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30, // Marge horizontale de 30 pixels
      ),
      child: Column(
        children: [
          DelayedAnimation(
            delay: 3500, // Délai avant l'affichage de cet élément (3500ms)
            child: TextField(
              decoration: InputDecoration(
                labelText: "Votre Email", // Label du champ de texte
                labelStyle: TextStyle(
                  color: Colors.grey[400], // Couleur du label
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30, // Espacement vertical de 30 pixels
          ),
          DelayedAnimation(
            delay: 4500, // Délai avant l'affichage de cet élément (4500ms)
            child: TextField(
              obscureText: _obsureText, // Gère la visibilité du texte
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.grey[400], // Couleur du label
                ),
                labelText:
                    'Mot de passe', // Label du champ de texte pour le mot de passe
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility,
                      color: Colors
                          .black), // Icône pour montrer/cacher le mot de passe
                  onPressed: () {
                    setState(() {
                      _obsureText =
                          !_obsureText; // Change l'état de la visibilité du mot de passe
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
