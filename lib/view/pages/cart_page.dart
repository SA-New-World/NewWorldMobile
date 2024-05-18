import 'package:flutter/material.dart';

// import '../../src/settings/settings_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Cart page'),
      ),
    );
  }
}
