import 'package:flutter/material.dart';
// import 'package:new_world_mobile/view/components/navigation_menu.dart';
import 'package:new_world_mobile/view/components/product_card.dart';
import '../../models/product.dart';
import '../../services/api/api_service.dart';

// ignore: must_be_immutable
class ProductPage extends StatelessWidget {
  ProductPage({super.key});
  static const routeName = '/product';
  List<Product> card = [];

  Future<void> setProducer() async {
    ApiService service = ApiService();
    List<Product> products = await service.getAllProducts();
    card = products;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setProducer(),
      builder: (context, AsyncSnapshot snapchot) {
        return Scaffold(
          body: /*SingleChildScrollView(
           child: Column(
              children: [
                Text(
                  'Nom de la Catégorie',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 30, // Espace vertical de 100 pixels
                ),
                ProductCard(
                  cardImg: 'images/FirstProduct.jpg',
                  cardCategory: 'Vêtements',
                  cardPrice: 35,
                ),
                SizedBox(
                  height: 100, // Espace vertical de 100 pixels
                ),
                ProductCard(
                  cardImg: 'images/FirstProduct.jpg',
                  cardCategory: 'Vêtements',
                  cardPrice: 35,
                ),
                SizedBox(
                  height: 100, // Espace vertical de 100 pixels
                ),
                ProductCard(
                  cardImg: 'images/FirstProduct.jpg',
                  cardCategory: 'Vêtements',
                  cardPrice: 35,
                ),
                SizedBox(
                  height: 100, // Espace vertical de 100 pixels
                ),
                ProductCard(
                  cardImg: 'images/FirstProduct.jpg',
                  cardCategory: 'Vêtements',
                  cardPrice: 35,
                ),
              ],
            ),
          ), 
          */
              ListView.builder(
            itemCount: card.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.blue,
                child: ProductCard(
                  cardCategory: card[index].name,
                  cardImg: 'images/FirstProduct.jpg',
                  cardPrice: card[index].price,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
