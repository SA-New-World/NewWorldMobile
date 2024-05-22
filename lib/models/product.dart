import 'dart:ffi';

/// Classe `Movie` représente un modèle pour les données de film.
///
/// Cette classe fournit une structure pour stocker les informations essentielles d'un film,
/// y compris son identifiant, son nom, sa description, et le chemin de son affiche.
/// Elle offre également une méthode pour obtenir l'URL complet de l'affiche du film en utilisant
/// l'URL de base pour les images défini dans la classe `API`.
///
/// Usage :
/// Utilisez cette classe pour créer des instances de `Movie` avec des données récupérées
/// depuis une API ou une source de données. Vous pouvez également obtenir l'URL de l'affiche
/// d'un film en appelant la méthode `posterURL`.
///
/// Exemple :
/// ```dart
/// var movie = Movie(
///   id: 123,
///   name: "Inception",
///   description: "Un voleur, qui s'infiltre dans les rêves...",
///   posterPath: "/pathToPoster.jpg",
/// );
/// print(movie.posterURL()); // Affiche l'URL complet de l'affiche.
/// ```
///
/// Note :
/// Si `posterPath` est `null`, la méthode `posterURL` peut lever une exception puisqu'elle
/// assume que le chemin de l'affiche est toujours fourni. Assurez-vous que `posterPath` n'est
/// pas `null` avant d'appeler `posterURL`.
class Producer {
  final int id;
  dynamic user;
  final String productType;
  final String description;
  final String advancement;

  Producer({
    required this.id,
    required this.user,
    required this.productType,
    required this.description,
    required this.advancement,
  });

  /// Génère et retourne l'URL complet de l'affiche du film en préfixant
  /// `posterPath` avec l'URL de base pour les images. Assurez-vous que
  /// `posterPath` n'est pas `null` avant d'invoquer cette méthode.
  ///String posterURL() {
  ///  API api = API();
  ///  return api.baseUrl + posterPath!;
  ///}
}

class Product {
  final int id;
  final String name;
  final String description;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });
}

class User {
  final int id;
  final String name;

  User({
    required this.id,
    required this.name,
  });
}
