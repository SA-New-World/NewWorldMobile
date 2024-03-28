import 'package:flutter/material.dart';

import '../components/navigationbar.dart';
import '../../model/product.dart';
import '../../services/api_service.dart';
import '../components/card.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});
  static const routeName = '/';
  List<Producer> card = [];

  Future<void> setProducer() async {
    ApiService service = ApiService();
    List<Producer> producer = await service.getAllProducer();
    card = producer;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: setProducer(),
        builder: (context, AsyncSnapshot snapchot) {
          return Scaffold(
            appBar: AppBar(title: const Text('Products')),
            body: Center(
              child: ListView.builder(
                itemCount: card.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: SampleCard(
                    cardName: card[index].user.name,
                  ));
                },
              ),
            ),
            bottomNavigationBar: BottomNavigationBarPage(routeName: routeName,)
          );
        });
  }
}