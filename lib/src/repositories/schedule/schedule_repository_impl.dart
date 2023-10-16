import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/core/restClient/rest_client.dart';
import 'package:dw_barbershop/src/model/schedule_model.dart';
import 'package:dw_barbershop/src/repositories/schedule/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final RestClient restClient;

  ScheduleRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryException, Nil>> scheduleClient(
      ({
        int barbershopId,
        String clientName,
        DateTime date,
        int time,
        int userId
      }) scheduleData) async {
    try {
      await restClient.auth.post(
        '/schedules',
        data: {
          'barbershopId': scheduleData.barbershopId,
          'user_id': scheduleData.userId,
          'client_name': scheduleData.clientName,
          'date': scheduleData.date.toIso8601String(),
          'time': scheduleData.time
        },
      );

      return Success(nil);
    } on DioException catch (e, s) {
      String msg = 'Erro ao registar agendamento';

      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }

  @override
  Future<Either<RepositoryException, List<ScheduleModel>>> findScheduleByDate(
      ({
        DateTime date,
        int userId,
      }) filter) async {
    try {
      final Response(:List data) =
          await restClient.auth.get('/schedules', queryParameters: {
        'user_id': filter.userId,
        'date': filter.date.toIso8601String(),
      });

      final schedules = data.map((e) => ScheduleModel.fromMap(e)).toList();
      return Success(schedules);
    } on DioException catch (e, s) {
      String msg = 'Erro ao buscar agendamentos de uma data';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    } on ArgumentError catch (e, s) {
      String msg = 'JSON inválido';
      log(msg, error: e, stackTrace: s);
      return Failure(RepositoryException(message: msg));
    }
  }
}
