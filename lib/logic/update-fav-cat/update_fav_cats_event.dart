part of 'update_fav_cats_bloc.dart';

class UpdateFavCatsEvent extends Equatable {
  final List<int> favoriteCategories;

  const UpdateFavCatsEvent({
    required this.favoriteCategories,
  });

  @override
  List<Object> get props => [favoriteCategories];
}
