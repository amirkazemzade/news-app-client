part of 'news_feed_bloc.dart';

abstract class NewsFeedEvent extends Equatable {
  const NewsFeedEvent();
}

class FetchNewsFeed extends NewsFeedEvent {
  @override
  List<Object> get props => [];
}

class ResetNewsFeed extends NewsFeedEvent {
  @override
  List<Object> get props => [];
}
