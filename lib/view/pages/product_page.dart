import 'package:flutter/material.dart';
import 'package:new_world_mobile/view/components/product_card.dart';
import '../../models/product.dart';
import '../../services/api/api_service.dart';

// La classe ProductPage représente une page qui affiche une liste de produits.
// Elle est Stateless, ce qui signifie qu'elle ne conserve pas d'état mutable elle-même.
// ignore: must_be_immutable
class ProductPage extends StatelessWidget {
  ProductPage({super.key}); // Constructeur de la classe ProductPage.
  static const routeName = '/product'; // Nom de la route pour la navigation.

  // Liste pour stocker les produits récupérés depuis le service API.
  List<Product> card = [];

  // Fonction asynchrone pour récupérer les produits depuis l'API.
  Future<void> setProducer() async {
    ApiService service =
        ApiService(); // Création d'une instance du service API.
    List<Product> products = await service
        .getAllProducts(); // Récupération des produits depuis l'API.
    card = products; // Mise à jour de la liste des produits.
  }

  TextEditingController searchController = TextEditingController();

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
          return Column(
            children: [
              SearchBar(searchController: searchController),
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
              )
            ]
          );
        }
      },
    );
  }
}

// ignore: must_be_immutable
class SearchBar extends StatefulWidget {
  SearchBar({super.key, required this.searchController});
  TextEditingController searchController;

  @override
  State<StatefulWidget> createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              controller: widget.searchController,
            )
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        ],
      ),
    );
  }
}