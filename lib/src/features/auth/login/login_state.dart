// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

enum LoginStateStatus {
  initial,
  error,
  admLogin,
  employeeLogin,
}

class LoginState {
  final LoginStateStatus status;
  final String? erroMessage;

  LoginState.initial() : this(status: LoginStateStatus.initial);

  LoginState({
    required this.status,
    this.erroMessage,
  });

  LoginState copyWith({
    LoginStateStatus? status,
    ValueGetter<String?>? erroMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      erroMessage: erroMessage != null ? erroMessage() : this.erroMessage,
    );
  }
}
