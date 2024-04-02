import 'package:flutter/material.dart';

import '../components/navigationbar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Cart page'),
      ),
      bottomNavigationBar: BottomNavigationBarPage(routeName: routeName,)
    );
  }
}