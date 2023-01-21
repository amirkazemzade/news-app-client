import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/user/data/models/auth_response_model.dart';
import 'package:news_app_client/user/data/repository.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required this.repository}) : super(SignUpInitial()) {
    on<OnSignUp>(_onSignUp);
  }

  final Repository repository;

  Future<void> _onSignUp(
    OnSignUp event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());
    try {
      final response = await repository.signUp(event.username, event.password);
      emit(SignUpSuccess(response: response));
    } catch (e) {
      emit(SignUpFailure(error: e.toString()));
    }
  }
}
