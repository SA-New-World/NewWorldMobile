import 'package:flutter/material.dart';
// import 'package:new_world_mobile/view/components/navigation_menu.dart';
// import 'package:new_world_mobile/view/components/navigation_menu.dart';
// import 'package:new_world_mobile/view/components/navigation_menu.dart';
import 'package:new_world_mobile/view/pages/welcome_page.dart';

import 'services/settings/settings.dart';

void main() async {
  await Settings().init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ThemeMode themeMode = Settings().themeMode;

  // Make the access to the setState
  updateThemeMode() => setState(() {});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Give the setState to the singleton function
    Settings().setOnUpdateThemeMode(updateThemeMode);
    return MaterialApp(
      theme: ThemeData(
        // Thême de l'application
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        // Thême de l'application
        textTheme: const TextTheme(
          bodyLarge: TextStyle(),
          bodyMedium: TextStyle(),
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      themeMode: Settings().themeMode,
      debugShowCheckedModeBanner: false,
      // On charge d'abord la page de bienvenue
      home: const WelcomePage(),
    );
  }
}
