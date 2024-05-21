import 'package:flutter/material.dart';
// import 'package:new_world_mobile/view/components/navigation_menu.dart';
import 'package:new_world_mobile/view/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Thême de l'application
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // On charge d'abord la page de bienvenue
      home: WelcomePage(),
    );
  }
}
