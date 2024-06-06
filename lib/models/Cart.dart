import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart'; // Import du modèle Product

class Cart {
  static final Cart _instance = Cart._internal();

  factory Cart() {
    return _instance;
  }

  Cart._internal();

  static Cart get instance => _instance;
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Map pour stocker les produits et leurs quantités
  Map<String, int> _items = {};

  void addToCart(Product product) {
    final productId = product.id.toString();
    _items[productId] = (_items[productId] ?? 0) + 1; // Incrémente la quantité
    _saveCart(); // sauvegarde la nouvelle valeur
  }

  void removeFromCart(Product product) {
    final productId = product.id.toString();
    // Vérifie si le produit est déjà dans le panier
    if (_items.containsKey(productId)) {
      _items[productId] = (_items[productId]! - 1); // Décrémente la quantité
      // Supprime le produit si la quantité est 0
      if (_items[productId] == 0) {
        _items.remove(productId);
      }
      _saveCart(); // sauvegarde la nouvelle valeur
    }
  }

  bool isInCart(Product product) {
    // Changement de Movie à Product
    List<String> cartList = _prefs?.getStringList('cartList') ?? [];
    final productId = product.id.toString();
    return cartList.contains(productId);
  }

  List<String> cartList() {
    return _items.keys.toList();
  }

  List<String> getCartList(cart) {
    return cart;
  }

  // Retourne la quantité d'un produit dans le panier
  int getQuantity(Product product) {
    final productId = product.id.toString();
    return _items[productId] ?? 0; // Return 0 if not found
  }

  void setQuantity(Product product, int quantity) {
    final productId = product.id.toString();
    // Si la quantité est supérieure à 0, met à jour la quantité
    if (quantity > 0) {
      _items[productId] = quantity;
    } else {
      _items.remove(productId);
    }
    _saveCart(); // sauvegarde la nouvelle valeur
  }

  void _saveCart() async {
    List<String> encodedItems = [];
    _items.forEach((productId, quantity) {
      encodedItems.add(
          '$productId:$quantity'); // Encodage des données pour SharedPreferences
    });
    _prefs?.setStringList('cartList', encodedItems);
  }

  Future<void> _loadCart() async {
    List<String> encodedItems = _prefs?.getStringList('cartList') ?? [];
    _items = {};
    for (String item in encodedItems) {
      List<String> parts = item.split(':');
      if (parts.length == 2) {
        _items[parts[0]] = int.parse(
            parts[1]); // Décodage des données à partir de SharedPreferences
      }
    }
  }

  void deleteFromCart(Product product) {
    final productId = product.id.toString();
    if (_items.containsKey(productId)) {
      _items.remove(productId);
      _saveCart(); // sauvegarde la nouvelle valeur
    }
  }
}
