import 'package:dw_barbershop/src/core/ui/helper/form_helper.dart';
import 'package:dw_barbershop/src/core/ui/helper/messages.dart';
import 'package:dw_barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_barbershop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:dw_barbershop/src/features/register/barbershop/barbershop_register_state.dart';
import 'package:dw_barbershop/src/features/register/barbershop/barbershop_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class BarbershopRegisterPage extends ConsumerStatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  ConsumerState<BarbershopRegisterPage> createState() =>
      _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState
    extends ConsumerState<BarbershopRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barbershopRegisterVM =
        ref.watch(barbershopRegisterVmProvider.notifier);

    ref.listen(barbershopRegisterVmProvider, (_, state) {
      switch (state.status) {
        case BarbershopRegisterStateStatus.initial:
          break;
        case BarbershopRegisterStateStatus.error:
          Messages.showError(
              'Desculpe ocorreu um erro ao registrar barberia', context);
        case BarbershopRegisterStateStatus.success:
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/adm', (route) => false);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Estabeleciomento'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 19,
                ),
                TextFormField(
                  controller: nameEC,
                  validator: Validatorless.required('Nome obrigatório'),
                  onTapOutside: (_) => context.unfocus(),
                  decoration: const InputDecoration(
                    label: Text("Nome"),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: emailEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Email obrigatório'),
                    Validatorless.email('Email inválido')
                  ]),
                  onTapOutside: (_) => context.unfocus(),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    label: Text("E-mail"),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                WeekdaysPanel(onDayPressed: (value) {
                  barbershopRegisterVM.addOrRemoveOpenDays(value);
                }),
                const SizedBox(
                  height: 24,
                ),
                HoursPanel(
                  startTime: 6,
                  endTime: 23,
                  onHourPressed: (int value) {
                    barbershopRegisterVM.addOrRemoveOpenHour(value);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case false || null:
                        Messages.showError('Formulário inválido', context);
                      case true:
                        barbershopRegisterVM.register(
                          nameEC.text,
                          emailEC.text,
                        );
                    }
                  },
                  child: const Text('Cadastrar Estabelecimento'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
