import 'package:flutter/material.dart';
import 'package:new_world_mobile/models/product.dart';
import 'package:new_world_mobile/view/pages/product_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.cardImg,
    required this.cardName,
    required this.cardPrice,
    //required this.products,
  });

  final String cardImg;
  final String cardName;
  final double cardPrice;
  //final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        border: Border.all(width: 2.0), //Border.all
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ), //BorderRadius.all),
      ),
      child: Column(
        children: [
          Text(
            cardName,
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20, // Espace vertical de 20 pixels
          ),
          SizedBox(
            width: 400,
            child: Image.asset(cardImg, fit: BoxFit.fitWidth),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductPage(), // Navigue vers la classe MyApp
                      ),
                    );
                  },
                  child: const Text('En savoir plus'),
                ),
              ),
              Expanded(
                  child: Row(
                children: [
                  Text('$cardPrice€'),
                  ElevatedButton(
                    child: const Text(
                      'Acheter',
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductPage(), // Navigue vers la classe MyApp
                        ),
                      );
                    },
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}
