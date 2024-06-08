import 'package:flutter/material.dart';
import 'package:new_world_mobile/view/screens/cart_screen.dart';
import 'package:new_world_mobile/view/screens/product_screen.dart';
import 'package:new_world_mobile/view/screens/favorite_screen.dart';
import 'package:new_world_mobile/view/pages/settings_page.dart';
import 'package:new_world_mobile/models/screen_data.dart';

import 'package:new_world_mobile/services/notifications/notifications.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<StatefulWidget> createState() => NavigationPageState();
}

class NavigationPageState extends State<NavigationPage>
    with SingleTickerProviderStateMixin {
  NavigationPageState();

  TabController? _tabController;

  final List<ScreenData> _screenData = [
    ScreenData(
        title: 'Accueil',
        icon: const Icon(Icons.home),
        iconLabel: 'Accueil',
        screen: ProductScreen()),
    ScreenData(
        title: 'Panier',
        icon: const Icon(Icons.storefront),
        iconLabel: 'Panier',
        screen: CartScreen()),
    ScreenData(
        title: 'Favoris',
        icon: const Icon(Icons.favorite),
        iconLabel: 'Favoris',
        screen: const FavoriteScreen())
  ];

  void _handleTabSelection() {
    if (_tabController!.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _screenData.length, vsync: this);

    // Ajout de l'écouteur
    _tabController!.addListener(_handleTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    // affiche la nitification si elle est disponible
    NotificationsService().showNotification(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New World'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              },
              icon: const Icon(Icons.settings))
        ],
        leading: Container(),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          for (int item = 0; item < _screenData.length; item++)
            _screenData[item].screen
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: [
          for (int item = 0; item < _screenData.length; item++)
            Tab(icon: _screenData[item].icon, text: _screenData[item].iconLabel)
        ],
        labelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}
