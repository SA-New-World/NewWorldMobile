import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart'; // Import du modèle Product

class Cart {
  static final Cart _instance = Cart._internal();

  Map<String, int> _items = {};
  SharedPreferences? _prefs;
  Timer? _saveTimer;

  factory Cart() {
    return _instance;
  }

  Cart._internal();

  static Cart get instance => _instance;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadCart();
  }

  void addToCart(Product product) {
    final productId = product.id.toString();
    _items[productId] = (_items[productId] ?? 0) + 1; // Incrémente la quantité
    _scheduleSaveCart(); // Planifie la sauvegarde
  }

  void removeFromCart(Product product) {
    final productId = product.id.toString();
    if (_items.containsKey(productId)) {
      _items[productId] = (_items[productId]! - 1); // Décrémente la quantité
      if (_items[productId] == 0) {
        _items.remove(productId); // Supprime si la quantité est 0
      }
      _scheduleSaveCart(); // Planifie la sauvegarde
    }
  }

  bool isInCart(Product product) {
    return _items.containsKey(product.id.toString());
  }

  int getQuantity(Product product) {
    return _items[product.id.toString()] ?? 0;
  }

  void setQuantity(Product product, int quantity) {
    final productId = product.id.toString();
    if (quantity > 0) {
      _items[productId] = quantity;
    } else {
      _items.remove(productId);
    }
    _scheduleSaveCart(); // Planifie la sauvegarde
  }

  void setLocalQuantity(int productId, int quantity) {
    _items[productId.toString()] = quantity;
    _scheduleSaveCart(); // Planifie la sauvegarde
  }

  int getLocalQuantity(int productId) {
    return _items[productId.toString()] ?? 0;
  }

  void _scheduleSaveCart() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(seconds: 1), _saveCart);
  }

  void _saveCart() {
    List<String> encodedItems =
        _items.entries.map((entry) => '${entry.key}:${entry.value}').toList();
    _prefs?.setStringList('cartList', encodedItems);
  }

  Future<void> _loadCart() async {
    List<String> encodedItems = _prefs?.getStringList('cartList') ?? [];
    _items = {
      for (var item in encodedItems)
        item.split(':')[0]: int.parse(item.split(':')[1])
    };
  }

  void deleteFromCart(Product product) {
    final productId = product.id.toString();
    if (_items.containsKey(productId)) {
      _items.remove(productId);
      _scheduleSaveCart(); // Planifie la sauvegarde
    }
  }

  List<String> get cartList {
    return _items.keys.toList();
  }
}
