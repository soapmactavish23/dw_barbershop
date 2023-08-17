import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/barbershop_app.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  AsyncState.setLoaderPersonalized(
    defaultLoaderWidget: const BarbershopLoader(),
  );
  runApp(const ProviderScope(child: BarbershopApp()));
}
