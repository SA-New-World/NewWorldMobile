import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../services/api_service.dart';
import '../components/card.dart';

// ignore: must_be_immutable
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
                      color: Colors.blue,
                      child: SampleCard(
                        cardName: card[index].user.name,
                      ));
                },
              ),
            ),
          );
        });
  }
}
