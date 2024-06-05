import 'package:flutter/material.dart';

import 'package:new_world_mobile/view/pages/welcome_page.dart';
import '../../services/settings/settings.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings')
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            // Glue the SettingsController to the theme selection DropdownButton.
            //
            // When a user selects a theme from the dropdown list, the
            // SettingsController is updated, which rebuilds the MaterialApp.
            child: DropdownButton<ThemeMode>(
              // Read the selected themeMode from the Singleton
              value: Settings().themeMode,
              // Call the updateThemeMode method any time the user selects a theme.
              onChanged: Settings().updateThemeMode,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark Theme'),
                )
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              // supprime l'utilisateur du cache
              Settings().removeUser();
              // retour à la page d'accueil
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const WelcomePage()),
                  // empécher le retour en arrière pour l'utilisateur
                  (Route<dynamic> route) => false);
            },
            child: const Text('Se déconnecter')
          )
        ],
      )
    );
  }
}
