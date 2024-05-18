import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class InfoPage extends StatelessWidget {
  const InfoPage({super.key});
  static const routeName = '/info';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
