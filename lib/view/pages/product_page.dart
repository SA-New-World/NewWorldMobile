import 'package:flutter/material.dart';
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
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListView.builder(
            itemCount: card.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.grey,
                child: ProductCard(
                  cardCategory: card[index].name,
                  cardImg: 'images/FirstProduct.jpg',
                  cardPrice: card[index].price,
                ),
              );
            },
          );
        }
      },
    );
  }
}
