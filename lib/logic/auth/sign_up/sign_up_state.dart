part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpSuccess extends SignUpState {
  final AuthResponseModel response;

  const SignUpSuccess({
    required this.response,
  });

  @override
  List<Object> get props => [response];
}

class SignUpFailure extends SignUpState {
  final String error;

  const SignUpFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
