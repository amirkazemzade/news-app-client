part of 'favorite_categories_bloc.dart';

abstract class FavoriteCategoriesState extends Equatable {
  const FavoriteCategoriesState();
}

class FavoriteCategoriesInitial extends FavoriteCategoriesState {
  @override
  List<Object> get props => [];
}

class FavoriteCategoriesLoading extends FavoriteCategoriesState {
  @override
  List<Object> get props => [];
}

class FavoriteCategoriesSuccess extends FavoriteCategoriesState {
  final FavoriteCategoriesModel categories;

  const FavoriteCategoriesSuccess({
    required this.categories,
  });

  @override
  List<Object> get props => [categories];
}

class FavoriteCategoriesFailure extends FavoriteCategoriesState {
  final String error;

  const FavoriteCategoriesFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
