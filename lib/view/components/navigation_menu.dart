import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:new_world_mobile/view/pages/cart_page.dart';
import 'package:new_world_mobile/view/pages/info_page.dart';
import 'package:new_world_mobile/view/pages/product_page.dart';

import 'package:new_world_mobile/view/pages/settings_page.dart';

// ignore: must_be_immutable
class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // On crée une instance de NavigationController, la stocke dans une variable finale nommée controller,
    // et on enregistre cette instance dans le système de dépendances de GetX pour une utilisation ultérieure.
    final controller = Get.put(NavigationController());

    // structure visuelle de base avec des éléments standards comme AppBar, body, et FloatingActionButton
    return Scaffold(
      // La propriété bottomNavigationBar de Scaffold permet d'ajouter une barre de navigation
      // en bas de l'écran, ici spécifiquement en utilisant le widget NavigationBar.
      bottomNavigationBar: NavigationBar(
        // On fixe la hauteur du widget à 80
        height: 80,
        // On lui enlève son effet de levitation
        elevation: 0,
        // La propriété selectedIndex: 0 indique que le premier élément est actuellement sélectionné
        // dans un widget de navigation comme une barre de navigation.
        selectedIndex: 0,
        // Callback déclenchée lorsque l'utilisateur sélectionne une destination de navigation, mettant à jour l'index sélectionné dans le contrôleur
        onDestinationSelected: (index) =>
            controller.selectedIndex.value = index,
// Liste de destinations de navigation avec des icônes et des libellés correspondants
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Accueil'),
          NavigationDestination(icon: Icon(Icons.storefront), label: 'Panier'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favories'),
          NavigationDestination(icon: Icon(Icons.face), label: 'Profil'),
        ],
      ),
      // La propriété body de Scaffold utilise un widget Obx pour mettre à jour dynamiquement
      // le contenu affiché en fonction de la valeur actuelle de selectedIndex du contrôleur,
      // en affichant le contenu de l'index correspondant dans la liste screens du contrôleur.
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  // Déclaration de la variable réactive selectedIndex initialisée à 0
  final Rx<int> selectedIndex = 0.obs;

  // Liste des écrans de l'application
  final screens = [
    // Page produit
    ProductPage(),
    // Page panier (constante car n'a pas besoin de changement dynamique pour l'instant)
    const CartPage(),
    // Exemple de page avec un Container rouge

    //To do : Changer ce container par une page favoris qui vas stocker les favoris de l'utilisateur connecté
    const SettingsView(),

    // Page d'informations (constante car n'a pas besoin de changement dynamique pour l'instant)
    const InfoPage(),
  ];
}
