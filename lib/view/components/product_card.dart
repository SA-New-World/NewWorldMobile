import 'package:flutter/material.dart';
import 'package:new_world_mobile/models/Cart.dart';
import 'package:new_world_mobile/models/product.dart';
import 'package:new_world_mobile/services/settings/settings.dart';
import 'package:new_world_mobile/view/pages/product_detail_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_world_mobile/services/api/api_service.dart';
import 'package:new_world_mobile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCard extends StatefulWidget {
  final String cardImg;
  final String cardName;
  final double cardPrice;
  final Product product;

  const ProductCard({
    Key? key,
    required this.cardImg,
    required this.cardName,
    required this.cardPrice,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late TextEditingController _quantityController;
  final FocusNode _focusNode = FocusNode();
  int _localQuantity = 0; // Variable pour stocker localement la valeur de la quantité

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(text: '$_localQuantity');
    _focusNode.addListener(_onFocusChange);
    _loadLocalQuantity(); // Charger la valeur de la quantité depuis les préférences partagées
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      final parsedQuantity = int.tryParse(_quantityController.text) ?? 0;
      if (parsedQuantity >= 0) {
        setState(() {
          _localQuantity =
              parsedQuantity; // Mettre à jour localement la valeur de la quantité
        });
        _updateQuantity(
            parsedQuantity); // Appeler la fonction _updateQuantity avec la nouvelle valeur
      } else {
        _quantityController.text = '$_localQuantity';
      }
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _updateQuantity(int newQuantity) async {
    User? user = Settings().user;
    if (user != null) {
      final difference = newQuantity - _localQuantity;
      if (difference > 0) {
        await ApiService()
            .addToCart(user.login, user.password, widget.product.id);
      } else if (difference < 0) {
        await ApiService()
            .removeFromCart(user.login, user.password, widget.product.id);
      }
      _localQuantity = newQuantity;
      _quantityController.text = '$_localQuantity';
      await _saveLocalQuantity(); // Sauvegarder la nouvelle valeur de la quantité dans les préférences partagées
      Cart.instance.setQuantity(widget.product, _localQuantity);
    }
  }

  Future<void> _loadLocalQuantity() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _localQuantity = prefs.getInt('localQuantity_${widget.product.id}') ?? 0;
      _quantityController.text = '$_localQuantity';
    });
  }

  Future<void> _saveLocalQuantity() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('localQuantity_${widget.product.id}', _localQuantity);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        border: Border.all(width: 2.0),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Text(
            widget.cardName,
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          widget.cardImg.startsWith('http')
              ? FadeInImage(
                  placeholder: const AssetImage('assets/placeholder.png'),
                  image: NetworkImage(widget.cardImg),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                )
              : SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Image.asset(widget.cardImg, fit: BoxFit.cover),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: widget.product,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 40),
                      textStyle: const TextStyle(fontSize: 14),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    child: const Text('En savoir plus'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _localQuantity > 0
                      ? () => _updateQuantity(_localQuantity - 1)
                      : null,
                ),
                SizedBox(
                  width: 40,
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    focusNode: _focusNode,
                    onSubmitted: (value) {
                      final parsedQuantity = int.tryParse(value) ?? 0;
                      if (parsedQuantity >= 0) {
                        _updateQuantity(parsedQuantity);
                      } else {
                        _quantityController.text = '$_localQuantity';
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  color: Colors.red,
                  onPressed: () => _updateQuantity(_localQuantity + 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

