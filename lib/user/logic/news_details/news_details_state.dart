part of 'news_details_bloc.dart';

abstract class NewsDetailsState extends Equatable {
  const NewsDetailsState();
}

class NewsDetailsInitial extends NewsDetailsState {
  @override
  List<Object> get props => [];
}

class NewsDetailsLoading extends NewsDetailsState {
  @override
  List<Object> get props => [];
}

class NewsDetailsSuccess extends NewsDetailsState {
  final NewsDetailsModel news;

  const NewsDetailsSuccess({
    required this.news,
  });

  @override
  List<Object> get props => [news];
}

class NewsDetailsFailure extends NewsDetailsState {
  final String error;

  const NewsDetailsFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
