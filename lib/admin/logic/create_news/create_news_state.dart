part of 'create_news_bloc.dart';

abstract class CreateNewsState extends Equatable {
  const CreateNewsState();
}

class CreateNewsInitial extends CreateNewsState {
  @override
  List<Object> get props => [];
}

class CreateNewsLoading extends CreateNewsState {
  @override
  List<Object> get props => [];
}

class CreateNewsSuccess extends CreateNewsState {
  final CreateNewsResponseModel response;

  const CreateNewsSuccess({
    required this.response,
  });

  @override
  List<Object> get props => [response];
}

class CreateNewsFailure extends CreateNewsState {
  final String error;

  const CreateNewsFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
