import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/user/data/models/auth_response_model.dart';
import 'package:news_app_client/user/data/repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.repository}) : super(LoginInitial()) {
    on<OnLogin>(_onLogin);
  }

  final Repository repository;

  Future<void> _onLogin(
    OnLogin event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final response = await repository.login(event.username, event.password);
      emit(LoginSuccess(response: response));
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
