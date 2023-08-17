import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DW Barbershop',
      navigatorObservers: [AsyncState.observer],
      routes: {
        '/': (_) => const SplashPage(),
      },
    );
  }
}
