import 'package:flutter/material.dart';

List<List> navigationPages = [
  [const Text('Page 1'),'/',(routeName) {if (routeName) {}}],
  [const Text('Page 2'),'/settings']
];

class BottomNavigationBarPage extends StatelessWidget {
  BottomNavigationBarPage({super.key, this.routeName});
  String? routeName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: const Color.fromARGB(255, 129, 129, 129),
      child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: navigationPages.length,
      itemBuilder: ((context, index) {
        if (routeName == navigationPages[index][1]) {// appliquer un style
          print('page ${navigationPages[index][1]} trouvée dans $index');
        }
        return navigationPages[index][0];
      })
    ));
  }
}