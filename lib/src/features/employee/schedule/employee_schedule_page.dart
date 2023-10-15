import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/features/employee/schedule/appointment_ds.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EmployeeSchedulePage extends StatelessWidget {
  const EmployeeSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: Column(children: [
        const Text(
          'Nome e Sobrenome',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 44,
        ),
        Expanded(
          child: SfCalendar(
            allowViewNavigation: true,
            view: CalendarView.day,
            showNavigationArrow: true,
            todayHighlightColor: ColorsConstants.brown,
            showDatePickerButton: true,
            showTodayButton: true,
            dataSource: AppointmentDs(),
            onTap: (calendarAppointmentDetails) {
              if (calendarAppointmentDetails.appointments != null &&
                  calendarAppointmentDetails.appointments!.isNotEmpty) {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      final dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
                      String subject = calendarAppointmentDetails
                          .appointments?.first.subject;
                      String date =
                          dateFormat.format(calendarAppointmentDetails.date!);
                      return SizedBox(
                        height: 100,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Cliente: $subject',
                              ),
                              Text(
                                'Cliente: $date',
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            },
            appointmentBuilder: (context, calendarAppointmentBuilder) {
              return Container(
                decoration: BoxDecoration(
                  color: ColorsConstants.brown,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    calendarAppointmentBuilder.appointments.first.subject,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
