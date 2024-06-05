import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import commenté, non utilisé
import 'package:new_world_mobile/view/components/delayed_animation.dart';
import 'package:new_world_mobile/view/components/navigation_menu.dart';
import 'package:new_world_mobile/view/pages/signup_page.dart';

import '../../services/api/api_service.dart';

Future<void> canLogUser(
    {required String email,
    required String password,
    required Function onLog}) async {
  ApiService service = ApiService();
  String response = await service.logUser(email, password);
  if (response == 'user logged') {
    onLog();
  }
}

/// Création d'une page de connexion/inscription
// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();

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
                    .center, // Aligne les enfants au début de l'axe horizontal
                children: [
                  DelayedAnimation(
                    delay:
                        1500, // Délai avant l'affichage de cet élément (1500ms)
                    child: Text(
                      "Connexion",
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 22, // Espacement vertical de 22 pixels
                  ),
                  DelayedAnimation(
                    delay:
                        2500, // Délai avant l'affichage de cet élément (2500ms)
                    child: Text(
                      'Veuillez vous connecter afin de profiter pleinement '
                      'de votre application favorite.',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 35, // Espacement vertical de 35 pixels
            ),
            LoginForm(
                mailController: mailController,
                passController:
                    passController), // Widget du formulaire de connexion
            DelayedAnimation(
              delay: 5500, // Délai avant l'affichage de cet élément (5500ms)
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Couleur de fond du bouton
                ),
                child: Text(
                  "S'inscrire",
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
                          SignupPage(), // Navigue vers la bottomBar qui vas servir à
                      // afficher les autres pages
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 50, // Espacement vertical de 50 pixels
            ),
            DelayedAnimation(
              delay: 5700, // Délai avant l'affichage de cet élément (5500ms)
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Couleur de fond du bouton
                  shape: const StadiumBorder(), // Forme du bouton
                  padding: const EdgeInsets.symmetric(
                    horizontal: 125, // Padding horizontal de 125 pixels
                    vertical: 13, // Padding vertical de 13 pixels
                  ),
                ),
                child: Text(
                  'CONFIRM',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  canLogUser(
                      email: mailController.text,
                      password: passController.text,
                      onLog: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const NavigationMenu(), // Navigue vers la bottomBar qui vas servir à
                            // afficher les autres pages
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LoginForm extends StatefulWidget {
  LoginForm(
      {super.key, required this.mailController, required this.passController});
  TextEditingController mailController;
  TextEditingController passController;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _obsureText = true; // Variable pour gérer la visibilité du mot de passe
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30, // Marge horizontale de 30 pixels
      ),
      child: Column(
        children: [
          DelayedAnimation(
            delay: 3500, // Délai avant l'affichage de cet élément (3500ms)
            child: TextField(
              controller: widget.mailController,
              decoration: InputDecoration(
                labelText: "Votre email", // Label du champ de texte
                labelStyle: TextStyle(
                  color: Colors.grey[600], // Couleur du label
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30, // Espacement vertical de 30 pixels
          ),
          DelayedAnimation(
            delay: 4500, // Délai avant l'affichage de cet élément (4500ms)
            child: TextField(
              controller: widget.passController,
              obscureText: _obsureText, // Gère la visibilité du texte
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.grey[600], // Couleur du label
                ),
                labelText:
                    'Votre mot de passe', // Label du champ de texte pour le mot de passe
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility,
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
