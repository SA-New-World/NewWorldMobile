import 'package:flutter/material.dart';

import 'package:new_world_mobile/view/pages/product_page.dart';
import 'package:new_world_mobile/view/pages/cart_page.dart';
import 'package:new_world_mobile/src/settings/settings_view.dart';
import 'package:new_world_mobile/src/settings/settings_controller.dart';
import 'package:new_world_mobile/src/settings/settings_service.dart';

late BuildContext externContext;

late SettingsController externSettingsController;

List<List> navigationPages = [
  [
    ElevatedButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(externContext, MaterialPageRoute(builder: (context) => ProductPage(settingsController: externSettingsController)), (route) => false,);
      },
      child: const Text('Product'),
    ),
    const Text('Products'),
    ProductPage.routeName
  ],
  [
    ElevatedButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(externContext, MaterialPageRoute(builder: (context) => CartPage(settingsController: externSettingsController)), (route) => false,);
      },
      child: const Text('Cart'),
    ),
    const Text('Cart'),
    CartPage.routeName
  ],
  [
    ElevatedButton(
      onPressed: () async {
        Navigator.push(externContext, MaterialPageRoute(builder: (context) => SettingsView(controller: externSettingsController,)),);
      },
      child: const Text('Settings'),
    ),
    const Text('Settings'),
    '/settings'
  ]
];

class BottomNavigationBarPage extends StatelessWidget {
  BottomNavigationBarPage({super.key, this.routeName, this.settingsController});
  String? routeName;
  SettingsController? settingsController;

  @override
  Widget build(BuildContext context) {
    externContext = context;
    if (settingsController == null) {
      settingsController = SettingsController(SettingsService());
      settingsController?.loadSettings();
    }
    externSettingsController = settingsController!;
    return Container(
      height: 100,
      color: const Color.fromARGB(255, 129, 129, 129),
      child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: navigationPages.length,
      itemBuilder: ((context, index) {
        if (routeName == navigationPages[index][2]) {
          return navigationPages[index][1];
        }
        return navigationPages[index][0];
      })
    ));
  }
}