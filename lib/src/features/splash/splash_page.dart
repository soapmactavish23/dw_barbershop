import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash'),
      ),
      body: ElevatedButton(
        onPressed: () async {
          await Future.delayed(const Duration(seconds: 2)).asyncLoader();
        },
        child: const Text("Teste Loader"),
      ),
    );
  }
}
