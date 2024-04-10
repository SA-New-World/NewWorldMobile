import 'package:flutter/material.dart';

import '../../src/settings/settings_controller.dart';
import '../components/navigationbar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, required this.settingsController});
  static const routeName = '/cart';
  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Cart page'),
      ),
      bottomNavigationBar: BottomNavigationBarPage(routeName: routeName, settingsController: settingsController,)
    );
  }
}