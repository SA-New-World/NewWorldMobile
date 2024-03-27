import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_world_mobile/model/product.dart';
import 'package:new_world_mobile/services/api_service.dart';
import 'package:new_world_mobile/src/view/sample_feature/sample_item_details_view.dart';

/// Flutter code sample for [Card].

class CardItemsApp extends StatelessWidget {
  CardItemsApp({super.key});
  static const routeName = '/';
  List<Producer> card = [];

  Future<void> setProducer() async {
    ApiService service = ApiService();
    List<Producer> producer = await service.getProducer(1);
    List<User> user = await service.getUser(1);
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
                      child: _SampleCard(
                    cardName: card[index].user.name,
                  ));
                },
              ),
            ),
          );
        });
  }
}

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Flex(direction: Axis.vertical, children: [
        Text(cardName),
        ElevatedButton(
          onPressed: () {
            _cardDetail(context);
          },
          child: const Text('En Savoir Plus'),
        ),
      ]),
    );
  }
}

_cardDetail(context) {
  // Navigate to the details page. If the user leaves and returns to
  // the app after it has been killed while running in the
  // background, the navigation stack is restored.
  Navigator.restorablePushNamed(
    context,
    SampleItemDetailsView.routeName,
  );
}
