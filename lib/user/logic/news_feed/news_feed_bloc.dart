import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/user/data/models/user_news_response_model.dart';
import 'package:news_app_client/user/data/repository.dart';

part 'news_feed_event.dart';

part 'news_feed_state.dart';

class NewsFeedBloc extends Bloc<NewsFeedEvent, NewsFeedState> {
  NewsFeedBloc({required this.repository}) : super(NewsFeedInitial()) {
    on<FetchNewsFeed>(_fetchNewsFeed);
    on<ResetNewsFeed>(_resetNewsFeed);
  }

  final Repository repository;

  Future<void> _fetchNewsFeed(
    FetchNewsFeed event,
    Emitter<NewsFeedState> emit,
  ) async {
    emit(NewsFeedLoading());
    try {
      while (true) {
        final response = await repository.fetchUserNewsFeed();
        emit(NewsFeedSuccess(
            news: mapNewsByCategoryId(response.result!.items!)));
        await Future.delayed(const Duration(seconds: 3));
      }
    } catch (e) {
      emit(NewsFeedFailure(error: e.toString()));
    }
  }

  Future<void> _resetNewsFeed(
    ResetNewsFeed event,
    Emitter<NewsFeedState> emit,
  ) async {
    emit(NewsFeedInitial());
  }
}

Map<int, List<UserNewsItem>> mapNewsByCategoryId(List<UserNewsItem> newsList) {
  final newsMap = <int, List<UserNewsItem>>{};
  for (var newsItem in newsList) {
    var list = newsMap[newsItem.categoryId!] ?? [];
    list.add(newsItem);
    newsMap[newsItem.categoryId!] = list;
  }
  return newsMap;
}
