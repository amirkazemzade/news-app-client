part of 'favorite_categories_bloc.dart';

abstract class FavoriteCategoriesEvent extends Equatable {
  const FavoriteCategoriesEvent();
}

class FetchFavoriteCategories extends FavoriteCategoriesEvent {
  @override
  List<Object> get props => [];
}

class ResetFavoriteCategories extends FavoriteCategoriesEvent {
  @override
  List<Object> get props => [];
}
