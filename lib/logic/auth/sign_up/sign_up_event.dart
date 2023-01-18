part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class OnSignUp extends SignUpEvent {
  final String username;
  final String password;

  const OnSignUp({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}
