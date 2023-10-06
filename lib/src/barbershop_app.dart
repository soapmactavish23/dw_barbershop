import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/features/auth/login/login_page.dart';
import 'package:dw_barbershop/src/features/employee/register/employee_register_page.dart';
import 'package:dw_barbershop/src/features/home/adm/home_adm_page.dart';
import 'package:dw_barbershop/src/features/register/barbershop/barbershop_register_page.dart';
import 'package:dw_barbershop/src/features/register/user/user_register_page.dart';
import 'package:dw_barbershop/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'DW Barbershop',
          navigatorObservers: [asyncNavigatorObserver],
          theme: BarbershopTheme.themeData,
          navigatorKey: BarbershopNavGlobalKey.instance.navKey,
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login': (_) => const LoginPage(),
            '/auth/register/user': (_) => const UserRegisterPage(),
            '/auth/register/barbershop': (_) => const BarbershopRegisterPage(),
            '/home/adm': (_) => const HomeAdmPage(),
            '/home/employee': (_) => const Text('EMPLOYEE'),
            '/employee/register': (_) => const EmployeeRegisterPage(),
          },
        );
      },
    );
  }
}
