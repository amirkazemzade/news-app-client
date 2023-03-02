part of 'delete_news_bloc.dart';

class DeleteNewsEvent extends Equatable {
  final int newsId;

  const DeleteNewsEvent({
    required this.newsId,
  });

  @override
  List<Object> get props => [newsId];
}
