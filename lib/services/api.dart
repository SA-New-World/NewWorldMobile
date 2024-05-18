import 'api_key.dart';

/// Classe `API` centralise la configuration nécessaire pour accéder à l'API de New World.
///
/// Cette classe contient la clé API, l'URL de base de l'API, et l'URL de base pour accéder aux images.
/// Elle est utilisée pour construire les requêtes vers l'API et récupérer des informations
///
/// Utilisation :
/// - `apikey` est utilisée pour s'authentifier auprès de l'API TMDB.
/// - `baseUrl` sert de point de départ pour toutes les requêtes API.
/// - `baseImageUrl` est utilisé pour construire les URL complets des images.
///
/// Important :
/// La clé API doit être tenue secrète et ne pas être exposée publiquement, par exemple, dans des dépôts de code source ouverts.
/// Assurez-vous de suivre les meilleures pratiques pour sécuriser votre clé API.
class API {
  /// La clé API pour accéder à l'API. Stockée dans un fichier séparé pour la sécurité.
  final String apikey = APIKey.apikey;

  /// L'URL de base pour les requêtes API.
  final String baseUrl = 'http://127.0.0.1:8000/api';
}
