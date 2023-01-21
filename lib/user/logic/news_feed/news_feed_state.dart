part of 'news_feed_bloc.dart';

abstract class NewsFeedState extends Equatable {
  const NewsFeedState();
}

class NewsFeedInitial extends NewsFeedState {
  @override
  List<Object> get props => [];
}

class NewsFeedLoading extends NewsFeedState {
  @override
  List<Object> get props => [];
}

class NewsFeedSuccess extends NewsFeedState {
  final Map<int, List<UserNewsItem>> news;

  const NewsFeedSuccess({
    required this.news,
  });

  @override
  List<Object> get props => [news];
}

class NewsFeedFailure extends NewsFeedState {
  final String error;

  const NewsFeedFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
