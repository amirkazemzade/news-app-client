import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/admin/data/models/create_news_response_model.dart';
import 'package:news_app_client/admin/data/providers/admin_news_data_provider.dart';

part 'create_news_event.dart';

part 'create_news_state.dart';

class CreateNewsBloc extends Bloc<CreateNewsEvent, CreateNewsState> {
  CreateNewsBloc({required this.provider}) : super(CreateNewsInitial()) {
    on<CreateNewsEvent>(_createNewsEvent);
  }

  final AdminNewsDataProvider provider;

  Future<void> _createNewsEvent(
    CreateNewsEvent event,
    Emitter<CreateNewsState> emit,
  ) async {
    emit(CreateNewsLoading());
    try {
      final response = await provider.createNews(
        event.title,
        event.body,
        event.categoryId,
        event.viewCount,
      );
      emit(CreateNewsSuccess(response: response));
    } catch (e) {
      emit(CreateNewsFailure(error: e.toString()));
    }
  }
}
