import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/data/providers/hive_provider.dart';

part 'save_tokens_event.dart';

part 'save_tokens_state.dart';

class SaveTokensBloc extends Bloc<SaveTokensEvent, SaveTokensState> {
  SaveTokensBloc({required this.provider}) : super(SaveTokensInitial()) {
    on<SaveTokensEvent>(_saveAccessTokenEvent);
  }

  final HiveProvider provider;

  Future<void> _saveAccessTokenEvent(
    SaveTokensEvent event,
    Emitter<SaveTokensState> emit,
  ) async {
    emit(SaveTokensLoading());
    try {
      await provider.writeAccessToken(event.accessToken);
      emit(SaveTokensSuccess());
    } catch (e) {
      emit(SaveTokensFailure(error: e.toString()));
    }
  }
}
