// import 'dart:ffi';

import 'package:dio/dio.dart';
import '../../models/product.dart';
import 'api.dart';

/// Classe `ApiService` gère les requêtes réseau pour récupérer des données de films depuis une API externe.
///
/// Cette classe utilise la bibliothèque Dio pour effectuer des requêtes HTTP. Elle est conçue pour interroger
/// une API spécifique de films et récupérer des informations telles que les films populaires.
///
/// Usage :
/// Pour utiliser `ApiService`, créez une instance de la classe, puis invoquez les méthodes fournies
/// pour récupérer les données souhaitées.
class ApiService {
  final API api = API();
  final Dio dio = Dio();

  /// Récupère les données depuis l'API en utilisant un chemin spécifié et des paramètres optionnels.
  ///
  /// [path] Le chemin de la ressource API à laquelle accéder.
  /// [params] Paramètres optionnels à inclure dans la requête.
  ///
  /// Retourne une réponse Dio si la requête aboutit avec un code de statut 200.
  /// Sinon, lève une exception contenant la réponse de la requête.
  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    // Construction de l'URL complète
    String url = api.baseUrl + path;

    // Ajout des paramètres de requête par défaut et ceux fournis
    Map<String, dynamic> query = {
      'language': 'fr-FR',
    };

    // Ajout des paramètres optionnels
    if (params != null) {
      query.addAll(params);
    }

    // Lancement de la requète
    final response = await dio.get(url, queryParameters: query);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  Future<String> logUser(String mail, String pass) async {
    Response response = await getData("/request", params: {
      'for': 'login',
      'token': api.apikey,
      'email': mail,
      'password': pass
    });
    if (response.statusCode == 200) {
      //print(response.data);
      //print(response.data == 'success');
      if (response.data == 'success') {
        return 'user logged';
      }
      else {
        return 'loging fail';
      }
    }
    else {
      throw response;
    }
  }

  Future<String> registerUser(String name, String mail, String pass) async {
    Response response = await getData("/request", params: {
      'for': 'register',
      'token': api.apikey,
      'name' : name,
      'email': mail,
      'password': pass
    });
    if (response.statusCode == 200) {
      //print(response.data);
      //print(response.data == 'success');
      if (response.data == 'success') {
        return 'user created';
      }
      else if (response.data == 'invalidemail') {
        return 'email not available';
      }
      else {
        return 'register fail';
      }
    }
    else {
      throw response;
    }
  }

  /// Récupère une liste des films populaires à partir de l'API.
  ///
  /// [pageNumber] Le numéro de la page à récupérer pour la pagination des résultats.
  ///
  /// Retourne une liste d'objets `Movie` si la requête est réussie.
  /// Sinon, lève une exception contenant la réponse de la requête.
  Future<List<Producer>> getAllProducer() async {
    Response response = await getData("/producers", params: {
      'page': 1,
    });
    if (response.statusCode == 200) {
      Map data = response.data;

      List<dynamic> results = data["hydra:member"];

      List<Producer> producers = [];

      for (Map<String, dynamic> json in results) {
        // Transformation du JSON en objet Movie
        Producer producer = Producer(
          id: json['id'] as int,
          user: User(id: 1, name: json['user'] as String),
          productType: json['productType'] as String,
          description: json['description'] as String,
          advancement: json['advancement'] as String,
        );
        producers.add(producer);
      }
      Response response2 = await getData("/users");
      if (response2.statusCode == 200) {
        Map data2 = response2.data;
        List<dynamic> results2 = data2["hydra:member"];

        for (Map<String, dynamic> json in results2) {
          // Transformation du JSON en objet
          User user = User(
            id: json['id'] as int,
            name: json['name'] as String,
          );
          for (int i = 0; i < producers.length; i++) {
            if (producers.length >= i &&
                producers[i].user.name == "/api/users/${user.id}") {
              producers[i].user = user;
            }
          }
        }
      }
      return producers;
    } else {
      throw response;
    }
  }

  Future<List<User>> getAllUser() async {
    Response response = await getData("/users");
    if (response.statusCode == 200) {
      Map data = response.data;
      List<dynamic> results1 = data["hydra:member"];

      List<User> users = [];

      for (Map<String, dynamic> json in results1) {
        // Transformation du JSON en objet Movie
        User user = User(
          id: json['id'] as int,
          name: json['name'] as String,
        );
        users.add(user);
      }
      return users;
    } else {
      throw response;
    }
  }

  Future<List<Product>> getAllProducts() async {
    int page = 1;
    List<Product> allProducts = [];
    bool hasMorePages = true;

    while (hasMorePages) {
      try {
        // Effectuer une requête avec le paramètre de pagination
        Response response = await getData("/products", params: {
          'page': page,
        });
        Map data = response.data;
        List<dynamic> results = data["hydra:member"];

        // Si la réponse ne contient pas de produits, on arrête la boucle
        if (results.isEmpty) {
          hasMorePages = false;
        } else {
          // Transformation des résultats JSON en objets Product
          for (Map<String, dynamic> json in results) {
            Product product = Product(
              id: json['id'],
              name: json['name'],
              description: json['description'],
              price: json['price'].toDouble(),
            );
            allProducts.add(product);
          }
          // Passer à la page suivante
          page++;
        }
      } catch (e) {
        hasMorePages = false; // Arrêter la boucle en cas d'erreur
      }
    }
    return allProducts;
  }
}
