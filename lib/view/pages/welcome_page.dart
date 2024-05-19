import 'package:flutter/material.dart';
import 'package:new_world_mobile/view/components/delayed_animation.dart';
import 'package:new_world_mobile/view/pages/info_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              DelayedAnimation(
                  delay: 1500,
                  child: Container(
                    child: Image.asset('images/logo.png'),
                  )),
              DelayedAnimation(
                  delay: 2500,
                  child: Container(
                    height: 100,
                    child: const Text(
                      "Une entreprise à vos côtés",
                      textAlign: TextAlign.center,
                    ),
                  )),
              DelayedAnimation(
                delay: 3500,
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red),
                    child: Text('Get Started'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const InfoPage() // Remplacer InfoPage par la page de connection,
                            ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
