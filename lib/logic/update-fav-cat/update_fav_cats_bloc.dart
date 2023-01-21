import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/data/models/general_response_model.dart';
import 'package:news_app_client/data/providers/favorite_category_data_provider.dart';

part 'update_fav_cats_event.dart';

part 'update_fav_cats_state.dart';

class UpdateFavCatsBloc extends Bloc<UpdateFavCatsEvent, UpdateFavCatsState> {
  UpdateFavCatsBloc({required this.provider}) : super(UpdateFavCatsInitial()) {
    on<UpdateFavCatsEvent>(_updateFavCatsEvent);
  }

  final FavoriteCategoryDataProvider provider;

  Future<void> _updateFavCatsEvent(
    UpdateFavCatsEvent event,
    Emitter<UpdateFavCatsState> emit,
  ) async {
    emit(UpdateFavCatsLoading());
    try {
      final response =
          await provider.updateFavoriteCategories(event.favoriteCategories);
      emit(UpdateFavCatsSuccess(response: response));
    } catch (e) {
      emit(UpdateFavCatsFailure(error: e.toString()));
    }
  }
}
