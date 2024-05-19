import 'package:flutter/material.dart';
import 'dart:async'; // Importation pour utiliser le Timer

// Définition d'un StatefulWidget nommé DelayedAnimation
class DelayedAnimation extends StatefulWidget {
  final Widget child; // Le widget enfant à animer
  final int delay; // Le délai avant de commencer l'animation

  // Constructeur avec les paramètres requis
  const DelayedAnimation({super.key, required this.delay, required this.child});

  @override
  _DelayedAnimationState createState() =>
      _DelayedAnimationState(); // Création de l'état associé
}

// État associé à DelayedAnimation
class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Contrôleur pour l'animation
  late Animation<Offset> _animOffset; // Animation de décalage (glissement)

  @override
  void initState() {
    super.initState();

    // Initialisation du AnimationController avec une durée de 500ms
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    // Définition de la courbe d'animation
    final curve =
        CurvedAnimation(parent: _controller, curve: Curves.decelerate);

    // Définition de l'animation de glissement (déplacement)
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, -0.35), end: Offset.zero)
            .animate(curve);

    // Démarrage de l'animation après le délai spécifié
    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
  }

  // Méthode build pour construire le widget
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller, // Animation de fondu
      child: SlideTransition(
        position: _animOffset, // Animation de glissement
        child: widget.child, // Le widget enfant à animer
      ),
    );
  }
}
