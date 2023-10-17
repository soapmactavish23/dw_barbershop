import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/features/home/widgets/home_header.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeEmployeePage extends ConsumerWidget {
  const HomeEmployeePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModelAsync = ref.watch(getMeProvider);

    return Scaffold(
      body: userModelAsync.when(
        error: (error, stackTrace) {
          return const Center(
            child: Text('Erro ao carregar página'),
          );
        },
        loading: () => const BarbershopLoader(),
        data: (user) {
          final UserModel(:name) = user;
          return CustomScrollView(slivers: [
            const SliverToBoxAdapter(
              child: HomeHeader(
                hideFilter: true,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const AvatarWidget(
                      hideUploadButton: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * .7,
                      height: 108,
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorsConstants.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '5',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: ColorsConstants.brown,
                            ),
                          ),
                          Text(
                            'Hoje',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/schedule', arguments: user);
                      },
                      child: const Text('AGENDAR CLIENTE'),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/employee/schedule', arguments: user);
                      },
                      child: const Text('VER AGENDA'),
                    ),
                  ],
                ),
              ),
            )
          ]);
        },
      ),
    );
  }
}
