import 'package:flutter/material.dart';
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
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset('images/${product.name}.jpg'),
            Text(
              product.description,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
            // Ajoutez d'autres widgets pour afficher les détails du produit
          ],
        ),
      ),
    );
  }
}
