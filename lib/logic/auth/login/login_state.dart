part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  final AuthResponseModel response;

  const LoginSuccess({
    required this.response,
  });

  @override
  List<Object> get props => [response];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
