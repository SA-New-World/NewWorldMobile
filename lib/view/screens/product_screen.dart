import 'package:flutter/material.dart';
import 'package:new_world_mobile/services/settings/settings.dart';
import 'package:new_world_mobile/view/components/product_card.dart';
import '../../models/product.dart';
import '../../models/user.dart';
import '../../services/api/api_service.dart';
import '../components/search_bar.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key}); // Constructeur de la classe ProductPage.
  @override
  State<StatefulWidget> createState() => ProductScreenState();
}

// La classe ProductPage représente une page qui affiche une liste de produits.
// Elle est Stateless, ce qui signifie qu'elle ne conserve pas d'état mutable elle-même.
// ignore: must_be_immutable
class ProductScreenState extends State<ProductScreen> {
  static const routeName = '/product'; // Nom de la route pour la navigation.

  // Liste pour stocker les produits récupérés depuis le service API.
  List<Product> card = [];

  TextEditingController searchController = TextEditingController();

  Future<List<Product>>? searchFuture;

  // Fonction asynchrone pour récupérer les produits depuis l'API.
  Future<void> getProducts() async {
    if (searchFuture == null) {// si il n'y a pas de recherche en cours
      ApiService service = ApiService(); // Création d'une instance du service API.
      List<Product> products = await service.getAllProducts(); // Récupération des produits depuis l'API.
      card = products; // Mise à jour de la liste des produits.
    }
    else {// sinon, attendre la fin de la recherche
      // getProducts() étant la Future du FutureBuilder
      // c'est mieux d'await ici pour avoir le chargement
      card = await searchFuture!;
    }
  }

  // fonction pour gérer la recherche
  void searchProduct(String name) {
    if (name != '') {// si la recherche est vide
      User? user = Settings().user;
      if (user != null) {
        setState(() {// reload le builder
          // sauvegarder l'état et la progression de la Future
          searchFuture = ApiService().searchProduct(user.login, user.password, name);
        });
      }
    }
    else {// sinon, on oublie la recherche précédente
      setState(() {
        searchFuture = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Utilisation de FutureBuilder pour gérer les opérations asynchrones.
      future: getProducts(), // Le futur à attendre (récupération des produits).
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
              // ajoute la barre de recherche custom (SearchBar existe déjà en flutter)
              CustomSearchBar(searchController: searchController, onSearch: searchProduct),
              Expanded(
                child: ListView.builder(
                  //shrinkWrap: true,
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
              )
            ]
          );
        }
      },
    );
  }
}