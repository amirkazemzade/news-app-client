import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/user/data/models/news_details_response_model.dart';
import 'package:news_app_client/user/data/repository.dart';

part 'news_details_event.dart';

part 'news_details_state.dart';

class NewsDetailsBloc extends Bloc<NewsDetailsEvent, NewsDetailsState> {
  NewsDetailsBloc({required this.repository}) : super(NewsDetailsInitial()) {
    on<FetchNewsDetails>(_fetchNewsDetails);
    on<ResetNewsDetails>(_resetNewsDetails);
  }

  final Repository repository;

  Future<void> _fetchNewsDetails(
    FetchNewsDetails event,
    Emitter<NewsDetailsState> emit,
  ) async {
    emit(NewsDetailsLoading());
    try {
      final response = await repository.fetchNewsDetails(event.newsId);
      emit(NewsDetailsSuccess(news: response.result!));
    } catch (e) {
      emit(NewsDetailsFailure(error: e.toString()));
    }
  }

  Future<void> _resetNewsDetails(
    ResetNewsDetails event,
    Emitter<NewsDetailsState> emit,
  ) async {
    emit(NewsDetailsInitial());
  }
}
