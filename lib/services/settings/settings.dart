import 'package:flutter/material.dart';

// Importe shared_preferences pour le stockage persistant des données.
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';

/// UserPreferences utilise le modèle Singleton pour gérer les préférences.
///
/// Permet le stockage et la récupération persistants des préférences utilisateur.
class Settings with ChangeNotifier {
  // Instance unique privée de UserPreferences pour le modèle Singleton.
  static final Settings _instance = Settings._internal();


  // Factory constructor retournant l'instance unique.
  factory Settings() {
    return _instance;
  }

  // Constructeur privé pour l'initialisation de l'instance Singleton.
  Settings._internal();

  // Référence privée à SharedPreferences pour le stockage clé-valeur.
  SharedPreferences? _prefs;

  /// Initialise SharedPreferences. Doit être appelé avant toute opération.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    String? userLogin = _prefs?.getString('userLogin');
    String? userPassword = _prefs?.getString('userPassword');

    if (userLogin != null && userPassword != null) {
      User user = User(login: userLogin, password: userPassword);

      _user = user;
    }

    // Récupère le thème depuis l'instance de SharedPreferences
    String? themeModeName = _prefs?.getString('themeMode');
    if (themeModeName == ThemeMode.light.name) {
      _themeMode = ThemeMode.light;
    }
    else if (themeModeName == ThemeMode.dark.name) {
      _themeMode = ThemeMode.dark;
    }
    else {
      _themeMode = ThemeMode.system;
    }

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  User? _user;

  User? get user {
    return _user;
  }

  /// Setter pour l'utilisateur. Enregistre le login et le mot de passe dans SharedPreferences.
  void updateUser(User? newUser) {
    if (newUser == null) return;

    if (newUser == _user) return;

    _user = newUser;

    _prefs?.setString('userLogin', newUser.login);
    _prefs?.setString('userPassword', newUser.password);
  }

  // supprime l'utilisateur des SharedPreferences
  void removeUser() {
    if (_user == null) return;

    _user = null;

    _prefs?.remove('userLogin');
    _prefs?.remove('userPassword');
  }

  // Theme privé affin de permettre la compatibilité
  ThemeMode? _themeMode;

  /// Getter pour 'themeMode'. Retourne la valeur ou null si non défini.
  ThemeMode get themeMode {
    return _themeMode??ThemeMode.system;
    //return _prefs?.getString('themeMode');
  }

  Function _onUpdateThemeMode = () {};

  void setOnUpdateThemeMode(Function function) {
    _onUpdateThemeMode = function;
  }

  /// Setter pour 'themeMode'. Enregistre la valeur dans SharedPreferences.
  void updateThemeMode(ThemeMode? newThemeMode) {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;
    _prefs?.setString('themeMode', newThemeMode.name);

    _onUpdateThemeMode();
  }
}