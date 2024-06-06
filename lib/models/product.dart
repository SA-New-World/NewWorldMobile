import 'package:flutter/material.dart';

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
  final int quantity;
  final String brand;
  final String origin;
  final String saleCountry;
  final String nutriscore;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.brand,
    required this.origin,
    required this.saleCountry,
    required this.nutriscore,
  });
}

/*
class User {
  final int id;
  final String name;

  User({
    required this.id,
    required this.name,
  });
}
*/

class NutriscoreImage extends StatelessWidget {
  final Product product;

  const NutriscoreImage({super.key, required this.product});

  String getNutriscoreImageUrl(String nutriscore) {
    switch (nutriscore) {
      case "A":
        return 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Nutri-score-A_light_background_logo.svg/1280px-Nutri-score-A_light_background_logo.svg.png';
      case "B":
        return 'https://www.pensersante.fr/sites/default/files/styles/medium_970x970/public/upload/apprendre-pour-mieux-manger/pour-quelles-raisons/l-alimentation-au-coeur-de-la-sante/valeur-nutritionnelle-des-aliments/nutriscore.jpg?itok=AiAmQDiC';
      case "C":
        return 'https://fac.img.pmdstatic.net/scale/https.3A.2F.2Ffac.2Eimg.2Epmdstatic.2Enet.2Ffit.2Fhttp.2E3A.2E2F.2E2Fprd2-bone-image.2E2Es3-website-eu-west-1.2E2Eamazonaws.2E2Ecom.2E2FFAC.2E2Fvar.2E2Ffemmeactuelle.2E2Fstorage.2E2Fimages.2E2Fmedia.2E2Fimages.2E2Funnamed15.2E2F14962854-1-fre-FR.2E2Funnamed.2E2Ejpg.2F650x404.2Fquality.2F80.2Fthumbnail.2Ejpg/650xauto/quality/80/crop-from/center/picture.jpeg';
      case "D":
        return 'https://img.freepik.com/vecteurs-premium/etiquette-officielle-nutri-score-score-illustration-vectorielle_797523-1646.jpg';
      case "E":
        return 'https://static.vecteezy.com/ti/vecteur-libre/p1/27802340-etiquette-nutritionnel-nutri-score-vectoriel.jpg';
      default:
        return 'https://www.easeus.com/images/en/data-recovery/drw-pro/invalid-image-file-header-error.png'; // Placeholder for unknown nutriscore
    }
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = getNutriscoreImageUrl(product.nutriscore);

    return Center(
      child: Image.network(
        imageUrl,
        scale: 5,
      ),
    );
  }
}
