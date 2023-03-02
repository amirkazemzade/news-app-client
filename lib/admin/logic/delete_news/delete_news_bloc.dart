import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/admin/data/providers/admin_news_data_provider.dart';
import 'package:news_app_client/user/data/models/general_response_model.dart';

part 'delete_news_event.dart';

part 'delete_news_state.dart';

class DeleteNewsBloc extends Bloc<DeleteNewsEvent, DeleteNewsState> {
  DeleteNewsBloc({required this.provider}) : super(DeleteNewsInitial()) {
    on<DeleteNewsEvent>(_deleteNewsEvent);
  }

  final AdminNewsDataProvider provider;

  Future<void> _deleteNewsEvent(
    DeleteNewsEvent event,
    Emitter<DeleteNewsState> emit,
  ) async {
    emit(DeleteNewsLoading());
    try {
      final response = await provider.deleteNews(event.newsId);
      emit(DeleteNewsSuccess(response: response));
    } catch (e) {
      emit(DeleteNewsFailure(error: e.toString()));
    }
  }
}
