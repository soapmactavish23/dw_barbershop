import 'dart:developer';

import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/features/home/adm/home_adm_state.dart';
import 'package:dw_barbershop/src/features/home/adm/home_adm_vm.dart';
import 'package:dw_barbershop/src/features/home/adm/widget/home_employee_tile.dart';
import 'package:dw_barbershop/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAdmPage extends ConsumerWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeAdmVmProvider);

    return Scaffold(
      body: homeState.when(
        data: (HomeAdmState data) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => HomeEmployeeTile(
                    employee: data.employees[index],
                  ),
                  childCount: data.employees.length,
                ),
              )
            ],
          );
        },
        error: (e, s) {
          log('Erro ao buscar colaboradores', error: e, stackTrace: s);
          return const Center(
            child: Text('Erro ao carregar página'),
          );
        },
        loading: () {
          return const BarbershopLoader();
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsConstants.brown,
        onPressed: () {
          Navigator.of(context).pushNamed('/employee/register');
        },
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 12,
          child: Icon(
            BarbershopIcons.addEmployee,
            color: ColorsConstants.brown,
          ),
        ),
      ),
    );
  }
}
