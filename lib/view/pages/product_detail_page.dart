import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_world_mobile/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

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
          const SizedBox(
            height: 15, // Espacement vertical de 35 pixels
          ),
          Row(
            children: [
              const Text(
                'Quantité disponible: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                product.quantity.toString(),
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          const SizedBox(
            height: 15, // Espacement vertical de 35 pixels
          ),
          Row(
            children: [
              const Text(
                'Marque: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                product.brand,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          const SizedBox(
            height: 15, // Espacement vertical de 35 pixels
          ),
          Row(
            children: [
              const Text(
                'Origine du produit : ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                product.origin,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          const SizedBox(
            height: 15, // Espacement vertical de 35 pixels
          ),
          Wrap(
            children: [
              const Text(
                'Pays de vente du produit : ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                product.saleCountry,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          const SizedBox(
            height: 15, // Espacement vertical de 35 pixels
          ),
          Row(
            children: [
              const Text(
                'Nutriscore : ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                product.nutriscore,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
            ],
          ),
          // Ajoutez d'autres widgets pour afficher les détails du produit
        ],
      ),
    );
  }
}
