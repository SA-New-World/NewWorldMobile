import 'package:flutter/material.dart';

class NotificationsService {
  // Instance unique privée de UserPreferences pour le modèle Singleton.
  static final NotificationsService _instance = NotificationsService._internal();


  // Factory constructor retournant l'instance unique.
  factory NotificationsService() {
    return _instance;
  }

  // Constructeur privé pour l'initialisation de l'instance Singleton.
  NotificationsService._internal();

  /// Initialise SharedPreferences. Doit être appelé avant toute opération.
  Future<void> init() async {}

  bool _error = false;

  get error {
    return _error;
  }

  setError(error) {
    _error = error;
  }

  showNotification(context) async {
    if (_error) {
      // empécher le spam
      _error = false;
      // attendre la fin du build
      WidgetsBinding.instance.addPostFrameCallback((_) =>
        // afficher la notification
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Request fail"),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: retry
            ),
          )
        )
      );
    }
  }
}

retry() {
  print('retryed');
}