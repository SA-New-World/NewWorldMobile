import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_world_mobile/view/pages/cart_page.dart';
import 'package:new_world_mobile/view/pages/info_page.dart';
import 'package:new_world_mobile/view/pages/product_page.dart';
import 'package:new_world_mobile/view/pages/settings_page.dart';

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

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // On crée une instance de NavigationController
    final controller = Get.put(NavigationController());

    return Scaffold(
      // Ajout de la barre de navigation en bas de l'écran
      bottomNavigationBar: Obx(() => NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Accueil'),
              NavigationDestination(
                  icon: Icon(Icons.storefront), label: 'Panier'),
              NavigationDestination(
                  icon: Icon(Icons.favorite), label: 'Favories'),
              NavigationDestination(icon: Icon(Icons.face), label: 'Profil'),
            ],
          )),
      // Mise à jour dynamique du contenu affiché
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'New World Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          const NavigationMenu(), // Utilisation de NavigationMenu comme page d'accueil
    );
  }
}
