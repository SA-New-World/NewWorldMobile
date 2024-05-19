import 'package:flutter/material.dart'; // Importation de Flutter Material Design
import 'package:new_world_mobile/view/components/delayed_animation.dart'; // Importation du widget DelayedAnimation
import 'package:new_world_mobile/view/pages/info_page.dart'; // Importation de la page InfoPage

// Définition d'un StatelessWidget nommé WelcomePage
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key}); // Constructeur avec clé super.key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold fournit la structure de base pour l'écran
      body: SingleChildScrollView(
        // SingleChildScrollView permet le défilement si le contenu dépasse la taille de l'écran
        child: Container(
          margin: const EdgeInsets.symmetric(
              vertical: 60, horizontal: 30), // Marges autour du conteneur
          child: Column(
            // Column pour disposer les widgets verticalement
            children: [
              const SizedBox(
                height: 150, // Espace vertical de 150 pixels
              ),
              // Première animation retardée pour le logo
              DelayedAnimation(
                  delay: 1500, // Délai de 1,5 seconde
                  child: Container(
                    child: Image.asset('images/logo.png'), // Affichage du logo
                  )),
              // Deuxième animation retardée pour le texte
              DelayedAnimation(
                  delay: 2500, // Délai de 2,5 secondes
                  child: Container(
                    height: 100, // Hauteur de 100 pixels
                    child: const Text(
                      "Une entreprise à vos côtés", // Texte affiché
                      textAlign:
                          TextAlign.center, // Alignement du texte au centre
                    ),
                  )),
              // Troisième animation retardée pour le bouton
              DelayedAnimation(
                delay: 3500, // Délai de 3,5 secondes
                child: Container(
                  width: double
                      .infinity, // Largeur du conteneur prend toute la largeur disponible
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor:
                            Colors.white, // Couleur du texte du bouton
                        backgroundColor:
                            Colors.red), // Couleur de fond du bouton
                    child: Text('Get Started'), // Texte du bouton
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const InfoPage() // Navigation vers InfoPage lorsqu'on appuie sur le bouton
                            ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
