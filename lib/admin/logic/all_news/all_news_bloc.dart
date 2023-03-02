import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/admin/data/providers/admin_news_data_provider.dart';
import 'package:news_app_client/user/data/models/news_list_response_model.dart';

part 'all_news_event.dart';

part 'all_news_state.dart';

class AllNewsBloc extends Bloc<AllNewsEvent, AllNewsState> {
  AllNewsBloc({required this.provider}) : super(AllNewsInitial()) {
    on<FetchAllNews>(_allNewsEvent);
    on<ResetAllNews>(_resetAllNews);
  }

  final AdminNewsDataProvider provider;

  Future<void> _allNewsEvent(
    FetchAllNews event,
    Emitter<AllNewsState> emit,
  ) async {
    emit(AllNewsLoading());
    try {
      while (true) {
        final response = await provider.fetchNews();
        emit(AllNewsSuccess(news: response.result!.items!));
        await Future.delayed(const Duration(seconds: 3));
      }
    } catch (e) {
      emit(AllNewsFailure(error: e.toString()));
    }
  }

  Future<void> _resetAllNews(
    ResetAllNews event,
    Emitter<AllNewsState> emit,
  ) async {
    emit(AllNewsInitial());
  }
}
