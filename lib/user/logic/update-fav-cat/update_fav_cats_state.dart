part of 'update_fav_cats_bloc.dart';

abstract class UpdateFavCatsState extends Equatable {
  const UpdateFavCatsState();
}

class UpdateFavCatsInitial extends UpdateFavCatsState {
  @override
  List<Object> get props => [];
}

class UpdateFavCatsLoading extends UpdateFavCatsState {
  @override
  List<Object> get props => [];
}

class UpdateFavCatsSuccess extends UpdateFavCatsState {
  final GeneralResponseModel response;

  const UpdateFavCatsSuccess({
    required this.response,
  });

  @override
  List<Object> get props => [response];
}

class UpdateFavCatsFailure extends UpdateFavCatsState {
  final String error;

  const UpdateFavCatsFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
