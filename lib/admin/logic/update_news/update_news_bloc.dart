import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/admin/data/providers/admin_news_data_provider.dart';
import 'package:news_app_client/user/data/models/general_response_model.dart';

part 'update_news_event.dart';

part 'update_news_state.dart';

class UpdateNewsBloc extends Bloc<UpdateNewsEvent, UpdateNewsState> {
  UpdateNewsBloc({required this.provider}) : super(UpdateNewsInitial()) {
    on<UpdateNewsEvent>(_updateNewsEvent);
  }

  final AdminNewsDataProvider provider;

  Future<void> _updateNewsEvent(
    UpdateNewsEvent event,
    Emitter<UpdateNewsState> emit,
  ) async {
    emit(UpdateNewsLoading());
    try {
      final response = await provider.updateNews(
        event.newsId,
        event.title,
        event.body,
        event.categoryId,
        event.viewCount,
      );
      emit(UpdateNewsSuccess(response: response));
    } catch (e) {
      emit(UpdateNewsFailure(error: e.toString()));
    }
  }
}
