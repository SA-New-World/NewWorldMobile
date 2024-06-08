import 'package:flutter/material.dart';
import 'package:new_world_mobile/services/settings/settings.dart';
import 'package:new_world_mobile/view/components/product_card.dart';
import '../../models/product.dart';
import '../../models/user.dart';
import '../../services/api/api_service.dart';

// import '../../src/settings/settings_controller.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  static const routeName = '/cart';

  // Liste pour stocker les produits récupérés depuis le service API.
  List<Product> card = [];

  // Fonction asynchrone pour récupérer les produits depuis l'API.
  Future<void> setProducer() async {
    List<Product> products = [];
    ApiService service = ApiService(); // Création d'une instance du service API.
    User? user = Settings().user;
    if (user != null) {
      products = await service.getCart(user.login, user.password);
    }// Récupération des produits depuis l'API.}
    card = products; // Mise à jour de la liste des produits.
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Utilisation de FutureBuilder pour gérer les opérations asynchrones.
      future: setProducer(), // Le futur à attendre (récupération des produits).
      builder: (context, AsyncSnapshot snapshot) {
        // Si l'application est en cours de chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Affiche un indicateur de progression circulaire au centre de l'écran.
          return const Center(child: CircularProgressIndicator());
          // Si une erreur s'est produite pendant la récupération des données
        } else if (snapshot.hasError) {
          // Affiche l'erreur
          return Center(child: Text('Error: ${snapshot.error}'));
          // Si la récupération des données s'est terminée avec succès
        } else {
          // Construit une liste de cartes de produits
          return //Column(children: [
              // SearchBar(searchController: searchController),
              ListView.builder(
            shrinkWrap: true,
            itemCount: card.length, // Nombre d'éléments dans la liste
            itemBuilder: (context, index) {
              // Construit chaque élément de la liste (une carte de produit)
              return Card(
                child: ProductCard(
                  // Les données à afficher sur la carte de produit
                  cardName: card[index].name, // Nom du produit
                  cardPrice: card[index].price, // Prix du produit
                  cardImg: 'images/${card[index].name}.jpg',
                  product: card[index], // Image du produit (fixe ici)
                ),
              );
            },
          );
          // ]);
        }
      },
    );
  }
}
