part of 'all_news_bloc.dart';

abstract class AllNewsState extends Equatable {
  const AllNewsState();
}

class AllNewsInitial extends AllNewsState {
  @override
  List<Object> get props => [];
}

class AllNewsLoading extends AllNewsState {
  @override
  List<Object> get props => [];
}

class AllNewsSuccess extends AllNewsState {
  final List<NewsItemModel> news;

  const AllNewsSuccess({
    required this.news,
  });

  @override
  List<Object> get props => [news];
}

class AllNewsFailure extends AllNewsState {
  final String error;

  const AllNewsFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
