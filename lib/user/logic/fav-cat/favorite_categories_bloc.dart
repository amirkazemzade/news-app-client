import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_client/user/data/models/favorite_categories_response_model.dart';
import 'package:news_app_client/user/data/providers/favorite_category_data_provider.dart';

part 'favorite_categories_event.dart';

part 'favorite_categories_state.dart';

class FavoriteCategoriesBloc
    extends Bloc<FavoriteCategoriesEvent, FavoriteCategoriesState> {
  FavoriteCategoriesBloc({required this.provider})
      : super(FavoriteCategoriesInitial()) {
    on<FetchFavoriteCategories>(_fetchFavoriteCategories);
    on<ResetFavoriteCategories>(_resetFavoriteCategories);
  }

  final FavoriteCategoryDataProvider provider;

  Future<void> _fetchFavoriteCategories(
    FetchFavoriteCategories event,
    Emitter<FavoriteCategoriesState> emit,
  ) async {
    emit(FavoriteCategoriesLoading());
    try {
      final response = await provider.fetchFavoriteCategories();
      emit(FavoriteCategoriesSuccess(categories: response.result!));
    } catch (e) {
      emit(FavoriteCategoriesFailure(error: e.toString()));
    }
  }

  Future<void> _resetFavoriteCategories(
    ResetFavoriteCategories event,
    Emitter<FavoriteCategoriesState> emit,
  ) async {
    emit(FavoriteCategoriesInitial());
  }
}
