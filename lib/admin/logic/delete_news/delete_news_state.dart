part of 'delete_news_bloc.dart';

abstract class DeleteNewsState extends Equatable {
  const DeleteNewsState();
}

class DeleteNewsInitial extends DeleteNewsState {
  @override
  List<Object> get props => [];
}

class DeleteNewsLoading extends DeleteNewsState {
  @override
  List<Object> get props => [];
}

class DeleteNewsSuccess extends DeleteNewsState {
  final GeneralResponseModel response;

  const DeleteNewsSuccess({
    required this.response,
  });

  @override
  List<Object> get props => [];
}

class DeleteNewsFailure extends DeleteNewsState {
  final String error;

  const DeleteNewsFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
