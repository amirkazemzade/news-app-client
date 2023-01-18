part of 'save_tokens_bloc.dart';

abstract class SaveTokensState extends Equatable {
  const SaveTokensState();
}

class SaveTokensInitial extends SaveTokensState {
  @override
  List<Object> get props => [];
}

class SaveTokensLoading extends SaveTokensState {
  @override
  List<Object> get props => [];
}

class SaveTokensSuccess extends SaveTokensState {
  @override
  List<Object> get props => [];
}

class SaveTokensFailure extends SaveTokensState {
  final String error;

  const SaveTokensFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
