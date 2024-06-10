// import 'dart:ffi';

import 'dart:convert';

import 'package:dio/dio.dart';
import '../../models/product.dart';
import 'api.dart';

import 'package:html_unescape/html_unescape.dart';

import 'package:new_world_mobile/services/notifications/notifications.dart';

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
    try {
      return await dio.get(url, queryParameters: query);
    } on DioException {
      return Response(requestOptions: RequestOptions(), statusCode: 404);
    }
  }

  Future<String> logUser(String mail, String pass) async {
    Response response = await getData("/request", params: {
      'for': 'login',
      'token': api.apikey,
      'email': mail,
      'password': pass
    });
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      //print(response.data);
      //print(response.data == 'success');
      if (response.data == 'success') {
        return 'user logged';
      } else {
        return 'loging fail';
      }
    } else {
      NotificationsService().setError(true);
      return 'request fail';
    }
  }

  Future<String> registerUser(String name, String mail, String pass) async {
    Response response = await getData("/request", params: {
      'for': 'register',
      'token': api.apikey,
      'name': name,
      'email': mail,
      'password': pass
    });
    if (response.statusCode == 200) {
      //print(response.data);
      //print(response.data == 'success');
      if (response.data == 'success') {
        return 'user created';
      } else if (response.data == 'invalidemail') {
        return 'email not available';
      } else {
        return 'register fail';
      }
    } else {
      return 'request fail';
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
        if (response.statusCode != 200) {
          NotificationsService().setError(true);
        }
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
              quantity: json['quantity'],
              brand: json['brand'],
              origin: json['origin'],
              saleCountry: json['saleCountry'],
              nutriscore: json['nutriscore'],
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

  Future getProduct(int id) async {
    Response response = await getData("/products/$id");

    if (response.statusCode == 200) {
      Map<String, dynamic> json = response.data;

      Product product = jsonToProduct(json);
      return product;
    } else {
      throw response;
    }
  }

  Product jsonToProduct(Map<String, dynamic> json) {
    return Product(
      description: json['description'],
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      brand: json['brand'],
      origin: json['origin'],
      saleCountry: json['saleCountry'],
      nutriscore: json['nutriscore'],
    );
  }

  Future<String> addToCart(String mail, String pass, int productId) async {
    Response response = await getData("/request", params: {
      'for': 'addToCart',
      'token': api.apikey,
      'email': mail,
      'password': pass,
      'product': productId
    });
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw response;
    }
  }

  Future<String> removeFromCart(String mail, String pass, int productId) async {
    Response response = await getData("/request", params: {
      'for': 'removeFromCart',
      'token': api.apikey,
      'email': mail,
      'password': pass,
      'product': productId
    });
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw response;
    }
  }

  Future<String> removeAllFromCart(
      String mail, String pass, int productId) async {
    Response response = await getData("/request", params: {
      'for': 'removeAllFromCart',
      'token': api.apikey,
      'email': mail,
      'password': pass,
      'product': productId
    });
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw response;
    }
  }

  Future<int> isInCart(String mail, String pass, int productId) async {
    Response response = await getData("/request", params: {
      'for': 'isInCart',
      'token': api.apikey,
      'email': mail,
      'password': pass,
      'product': productId
    });
    if (response.statusCode == 200) {
      return int.parse(response.data);
    } else {
      throw response;
    }
  }

  Future<List<Product>> getCart(String mail, String pass) async {
    Response response = await getData("/request", params: {
      'for': 'getCart',
      'token': api.apikey,
      'email': mail,
      'password': pass
    });
    List<Product> products = [];
    if (response.statusCode == 200) {
      if (response.data != "errorno cart") {
        String data = HtmlUnescape().convert(response.data);

        Map results = json.decode(data);

        results.forEach((key, json) {
          Product product = Product(
            id: json['id'],
            name: json['name'],
            description: json['description'],
            price: json['price'].toDouble(),
            quantity: json['quantity'],
            brand: json['brand'],
            origin: json['origin'],
            saleCountry: json['saleCountry'],
            nutriscore: json['nutriscore'],
          );
          products.add(product);
        });
      }
      return products;
    } else {
      throw response;
    }
  }

  Future<List<Product>> searchProduct(String mail, String pass, String productName) async {
    Response response = await getData("/request", params: {
      'for': 'searchProduct',
      'token': api.apikey,
      'email': mail,
      'password': pass,
      'name': productName
    });
    List<Product> products = [];
    if (response.statusCode == 200) {
      if (response.data != "errorno product") {
        String data = HtmlUnescape().convert(response.data);

        Map results = json.decode(data);

        results.forEach((key, json) {
          Product product = Product(
            id: json['id'],
            name: json['name'],
            description: json['description'],
            price: json['price'].toDouble(),
            quantity: json['quantity'],
            brand: json['brand'],
            origin: json['origin'],
            saleCountry: json['saleCountry'],
            nutriscore: json['nutriscore'],
          );
          products.add(product);
        });
      }
      return products;
    } else {
      throw response;
    }
  }
}
