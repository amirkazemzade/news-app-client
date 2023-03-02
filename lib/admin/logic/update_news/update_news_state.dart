part of 'update_news_bloc.dart';

abstract class UpdateNewsState extends Equatable {
  const UpdateNewsState();
}

class UpdateNewsInitial extends UpdateNewsState {
  @override
  List<Object> get props => [];
}

class UpdateNewsLoading extends UpdateNewsState {
  @override
  List<Object> get props => [];
}

class UpdateNewsSuccess extends UpdateNewsState {
  final GeneralResponseModel response;

  const UpdateNewsSuccess({
    required this.response,
  });

  @override
  List<Object> get props => [response];
}

class UpdateNewsFailure extends UpdateNewsState {
  final String error;

  const UpdateNewsFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
