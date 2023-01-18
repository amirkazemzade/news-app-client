part of 'news_details_bloc.dart';

abstract class NewsDetailsEvent extends Equatable {
  const NewsDetailsEvent();
}

class FetchNewsDetails extends NewsDetailsEvent {
  final int newsId;

  const FetchNewsDetails({
    required this.newsId,
  });

  @override
  List<Object> get props => [newsId];
}

class ResetNewsDetails extends NewsDetailsEvent {
  @override
  List<Object> get props => [];
}
