import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_world_mobile/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({Key? key, required this.product}) : super(key: key);

  static const routeName = '/product/detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name), // Utilisez les propriétés de product
      ),
      body: Column(
        children: <Widget>[
          Image.asset('images/${product.name}.jpg'),
          Wrap(
            children: [
              const Text(
                'Description: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                product.description,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),

          Row(
            children: [
              const Text(
                'Quantité disponible: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(product.quantity.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w300)),
            ],
          ),
          // Ajoutez d'autres widgets pour afficher les détails du produit
        ],
      ),
    );
  }
}
