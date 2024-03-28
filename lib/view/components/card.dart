import 'package:flutter/material.dart';

import 'package:new_world_mobile/view/pages/info_page.dart';

class SampleCard extends StatelessWidget {
  const SampleCard({required this.cardName});
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
    InfoPage.routeName,
  );
}