import 'package:flutter/material.dart';
import 'package:new_world_mobile/services/api/api_service.dart';
import 'package:new_world_mobile/view/pages/welcome_page.dart';
import 'package:new_world_mobile/view/pages/navigation_page.dart';
import 'package:new_world_mobile/services/settings/settings.dart';

void main() async {
  // Assurez-vous que la liaison des widgets de Flutter est initialisée
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser les paramètres ou d'autres services
  await Settings().init();

  // Vérrification de si l'utilisateur est connecté
  bool isLogged = false;// Par défaut, il n'y a pas d'utilisateur connecté.
  final user = Settings().user;
  if (user != null) {// Vérifie si il y a un utilisateur enregistré.
    // Il faut vérifier que l'utilisateur enregistré peut toujours se connecter.
    String response = await ApiService().logUser(user.login, user.password);
    if (response == 'user logged') {
      isLogged = true;
    }
  }

  // Démarrer l'application
  runApp(MyApp(canEnter: isLogged));
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp({super.key, this.canEnter = false});
  bool canEnter;

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
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
      // On accède à l'application avec la page de navigation qui gère les screen ou on charge d'abord la page de bienvenue.
      home: widget.canEnter ? const NavigationPage()
      : const WelcomePage()
    );
  }
}
